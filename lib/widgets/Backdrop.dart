// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

const double _kFrontHeadingHeight = 32.0; // front layer beveled rectangle
const double _kFrontClosedHeight = 92.0; // front layer height when closed

// The size of the front layer heading's left and right beveled corners.
final Animatable<BorderRadius> _kFrontHeadingBevelRadius = BorderRadiusTween(
  begin: const BorderRadius.only(
    topLeft: Radius.circular(12.0),
    topRight: Radius.circular(12.0),
  ),
  end: const BorderRadius.only(
    topLeft: Radius.circular(_kFrontHeadingHeight),
    topRight: Radius.circular(_kFrontHeadingHeight),
  ),
);

class _TappableWhileStatusIs extends StatefulWidget {
  const _TappableWhileStatusIs(
    this.status, {
    Key key,
    this.controller,
    this.child,
  }) : super(key: key);

  final AnimationController controller;
  final AnimationStatus status;
  final Widget child;

  @override
  _TappableWhileStatusIsState createState() => _TappableWhileStatusIsState();
}

class _TappableWhileStatusIsState extends State<_TappableWhileStatusIs> {
  bool _active;

  @override
  void initState() {
    super.initState();
    widget.controller.addStatusListener(_handleStatusChange);
    _active = widget.controller.status == widget.status;
  }

  @override
  void dispose() {
    widget.controller.removeStatusListener(_handleStatusChange);
    super.dispose();
  }

  void _handleStatusChange(AnimationStatus status) {
    final bool value = widget.controller.status == widget.status;
    if (_active != value) {
      setState(() {
        _active = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = AbsorbPointer(
      absorbing: !_active,
      child: widget.child,
    );

    if (!_active) {
      child = FocusScope(
        autofocus: false,
        debugLabel: '$_TappableWhileStatusIs',
        child: child,
      );
    }
    return child;
  }
}

class Backdrop extends StatefulWidget {
  const Backdrop({
    this.frontAction,
    this.frontTitle,
    this.frontHeading,
    this.frontLayer,
    this.backTitle,
    this.backLayer,
    this.controller,
  });

  final Widget frontAction;
  final Widget frontTitle;
  final Widget frontLayer;
  final Widget frontHeading;
  final Widget backTitle;
  final Widget backLayer;
  final BackdropController controller;

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  Animation<double> _frontOpacity;

  static final Animatable<double> _frontOpacityTween =
      Tween<double>(begin: 0.2, end: 1.0).chain(
          CurveTween(curve: const Interval(0.0, 0.4, curve: Curves.easeInOut)));

  @override
  void initState() {
    if (widget.controller != null) {
      widget.controller.toggleFrontLayerListener = toggleFrontLayerListener;
      widget.controller.isOpenListener = isOpenListener;
    }

    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
    _frontOpacity = _controller.drive(_frontOpacityTween);
  }

  void toggleFrontLayerListener() {
    _toggleFrontLayer();
  }

  bool isOpenListener() => isOpen();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double get _backdropHeight {
    // Warning: this can be safely called from the event handlers but it may
    // not be called at build time.
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();
    return math.max(0.0, renderBox.size.height - _kFrontClosedHeight);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -=
        details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  void _toggleFrontLayer() {
    _controller.fling(velocity: isOpen() ? -2.0 : 2.0);
  }

  bool isOpen() {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final Animation<RelativeRect> frontRelativeRect =
        _controller.drive(RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, constraints.biggest.height - _kFrontClosedHeight, 0.0, 0.0),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ));
    final Animation<RelativeRect> backRelativeRect =
        _controller.drive(RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: RelativeRect.fromLTRB(
          0.0, constraints.biggest.height - _kFrontClosedHeight, 0.0, 0.0),
    ));
    return Stack(
      key: _backdropKey,
      children: <Widget>[
        // Back layer
        PositionedTransition(
          rect: backRelativeRect,
          child: _TappableWhileStatusIs(
            AnimationStatus.dismissed,
            controller: _controller,
            child: Visibility(
              child: widget.backLayer,
              visible: true,
              maintainState: true,
            ),
          ),
        ),
        // Front layer
        PositionedTransition(
          rect: frontRelativeRect,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget child) {
              return PhysicalShape(
                elevation: 12.0,
                color: Theme.of(context).canvasColor,
                clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        _kFrontHeadingBevelRadius.transform(_controller.value),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: child,
              );
            },
            child: FadeTransition(
              opacity: _frontOpacity,
              child: widget.frontLayer,
            ),
          ),
        ),
        // The front "heading" is a (typically transparent) widget that's stacked on
        // top of, and at the top of, the front layer. It adds support for dragging
        // the front layer up and down and for opening and closing the front layer
        // with a tap. It may obscure part of the front layer's topmost child.
        if (widget.frontHeading != null)
          PositionedTransition(
            rect: frontRelativeRect,
            child: ExcludeSemantics(
              child: Container(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _toggleFrontLayer,
                  onVerticalDragUpdate: _handleDragUpdate,
                  onVerticalDragEnd: _handleDragEnd,
                  child: widget.frontHeading,
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _buildStack);
  }
}

class BackdropController {
  Function toggleFrontLayerListener;
  Function isOpenListener;

  void toggleFrontLayer() {
    if (toggleFrontLayerListener != null) {
      toggleFrontLayerListener();
    }
  }

  bool isOpen() {
    if (isOpenListener != null) {
      return isOpenListener();
    } else {
      return false;
    }
  }
}
