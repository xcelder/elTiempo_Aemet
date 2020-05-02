import 'package:aemet_radar/features/search_page/view_state/SearchViewState.dart';
import 'package:aemet_radar/model/LocationOption.dart';
import 'package:aemet_radar/values/Strings.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/values/AppColors.dart';

import '../../SearchState.dart';

class SearchLayout {
  Widget build(
    BuildContext context,
    Animation animation,
    TextEditingController searchController,
    Function(LocationOption) onOptionSelected,
  ) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: _buildSearch(
        context,
        animation,
        searchController,
        onOptionSelected,
      ),
    );
  }

  Widget _buildSearch(
    BuildContext context,
    Animation animation,
    TextEditingController searchController,
    Function(LocationOption) onOptionSelected,
  ) {
    return StreamBuilder<SearchState>(
      initialData: Idle(),
      stream: SearchViewState.of(context).stateController.stream,
      builder: (context, snapshot) => Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Column(
              children: [
                Expanded(
                  flex: animation.value,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildTextField(snapshot.data, onOptionSelected),
                  ),
                ),
                Expanded(
                  flex: 100 - animation.value,
                  child: _buildContentForState(snapshot.data),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    SearchState state,
    Function(LocationOption) onOptionSelected,
  ) {
    final suggestions = (state is OptionsResult)
        ? state.options
        : Iterable<LocationOption>.empty().toList();

    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: nightSky),
    );

    final inputDecoration = InputDecoration(
      labelStyle: TextStyle(fontSize: 24, color: nightSky),
      labelText: townLabel,
      border: inputBorder,
      enabledBorder: inputBorder,
      focusedBorder: inputBorder,
      errorBorder: inputBorder.copyWith(
        borderSide: BorderSide(color: Colors.redAccent, width: 2),
      ),
    );

    return AutoCompleteTextField<LocationOption>(
      decoration: inputDecoration,
      style: TextStyle(fontSize: 24),
      suggestions: suggestions,
      itemBuilder: (context, option) => _buildOption(option),
      itemSorter: (a, b) => 0,
      itemFilter: (suggestion, input) {
        final suggestionLC = suggestion.name.toLowerCase();
        final inputLC = input.toLowerCase().trim();

        return suggestionLC.startsWith(inputLC);
      },
      itemSubmitted: onOptionSelected,
      key: GlobalKey(),
    );
  }

  Widget _buildContentForState(SearchState state) {
    switch (state.runtimeType) {
      case Idle:
        return Container();
      case Busy:
        return _buildLoading();
      case Error:
        return _buildError((state as Error).message);
      default:
        return Container();
    }
  }

  Widget _buildOption(LocationOption option) => ListTile(
        title: Text(
          option.name,
          style: TextStyle(fontSize: 24, color: nightSky),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: nightSky,
        ),
      );

  Widget _buildError(String message) {
    return Center(
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: Colors.white,
          ),
          SizedBox(
            width: 12,
          ),
          Text(message, style: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          Center(
            child: Text(loadingLabel),
          )
        ],
      ),
    );
  }
}
