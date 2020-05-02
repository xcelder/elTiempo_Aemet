import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../SearchState.dart';

class SearchViewState extends InheritedWidget {
  final StreamController<SearchState> stateController;

  SearchViewState(this.stateController, {Widget child}) : super(child: child);

  static SearchViewState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SearchViewState>();

  void updateState(SearchState state) {
    stateController.sink.add(state);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
