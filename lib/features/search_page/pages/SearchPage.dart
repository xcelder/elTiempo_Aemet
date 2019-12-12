import 'package:aemet_radar/features/search_page/router/SearchRouter.dart';
import 'package:aemet_radar/model/LocationOption.dart';
import 'package:flutter/material.dart';
import 'injector/SearchInjector.dart';
import 'presenter/SearchPresenter.dart';
import 'package:aemet_radar/features/search_page/pages/interface_builder/SearchIB.dart'
    as searchIB;

class SearchPage extends StatefulWidget {
  final SearchRouter router;

  SearchPage(this.router);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  SearchPresenter presenter;

  TextEditingController searchController = TextEditingController();

  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    presenter = injectSearchPresenter(widget.router);

    _animationController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    _animation = IntTween(begin: 60, end: 30).animate(_animationController);
    super.initState();
  }

  void onSearch() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (!_animationController.isCompleted) {
      _animationController.forward();
    }
    presenter.searchLocation(searchController.text);
  }

  void onOptionSelected(LocationOption option) =>
    presenter.getWeatherDataOfLocation(option.locationCode);

  @override
  Widget build(BuildContext context) => searchIB.build(
        presenter.stateStream,
        _animation,
        searchController,
        onSearch,
        onOptionSelected,
      );

  @override
  void dispose() {
    presenter.dispose();
    super.dispose();
  }
}
