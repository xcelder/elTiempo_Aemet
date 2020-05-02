import 'package:aemet_radar/features/search_page/router/SearchRouter.dart';
import 'package:aemet_radar/features/search_page/view_state/SearchViewState.dart';
import 'package:aemet_radar/model/LocationOption.dart';
import 'package:flutter/material.dart';
import 'injector/SearchInjector.dart';
import 'interface_builder/SearchLayout.dart';
import 'presenter/SearchPresenter.dart';

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
    _animationController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    _animation = IntTween(begin: 60, end: 30).animate(_animationController);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    presenter = injectSearchPresenter(SearchViewState.of(context));

    presenter.loadProvinceData();

    super.didChangeDependencies();
  }

  void onOptionSelected(LocationOption option) {
    widget.router.navigateToMainPage(option);
  }

  @override
  Widget build(BuildContext context) => SearchLayout().build(
    context,
    _animation,
    searchController,
    onOptionSelected,
  );
}
