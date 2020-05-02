import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String _iconPath = "assets/images/Cloud-Download.svg";

class CloudLoading extends StatefulWidget {
  @override
  _CloudLoadingState createState() => _CloudLoadingState();
}

class _CloudLoadingState extends State<CloudLoading>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 30.0, end: 45.0).animate(_animationController);

    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = 150.0;
    return Container(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0.0, _animation.value),
            child: SvgPicture.asset(
              _iconPath,
              color: Colors.white,
              fit: BoxFit.cover,
              height: iconSize,
              width: iconSize,
            ),
          );
        },
      ),
    );
  }
}
