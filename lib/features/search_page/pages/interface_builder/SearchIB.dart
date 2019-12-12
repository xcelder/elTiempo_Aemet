import 'package:aemet_radar/model/LocationOption.dart';
import 'package:flutter/material.dart';
import 'package:aemet_radar/values/AppColors.dart';

import '../../SearchState.dart';

Widget build(
    Stream<SearchState> stream,
    Animation animation,
    TextEditingController searchController,
    Function onSearch,
    Function(LocationOption) onOptionSelected) {
  return Container(
    height: 400,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    child: _buildSearch(
        stream, animation, searchController, onSearch, onOptionSelected),
  );
}

Widget _buildContentForState(
    SearchState state, Function(LocationOption) onOptionSelected) {
  switch (state.runtimeType) {
    case Idle:
      return Container();
    case Busy:
      return _buildLoading();
    case OptionsResult:
      return _buildOptions((state as OptionsResult).options, onOptionSelected);
    case Error:
      return _buildError((state as Error).message);
    default:
      return Container();
  }
}

Widget _buildSearch(
  Stream<SearchState> stream,
  Animation animation,
  TextEditingController searchController,
  Function onSearch,
  Function(LocationOption) onOptionSelected,
) {
  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: nightSky),
  );

  final textField = TextField(
    controller: searchController,
    cursorColor: Colors.white,
    style: TextStyle(fontSize: 24),
    decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 24, color: nightSky),
        labelText: "Municipio",
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        errorBorder: inputBorder.copyWith(
            borderSide: BorderSide(color: Colors.redAccent, width: 2))),
  );

  return Center(
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: textField,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 2,
                      child: MaterialButton(
                        height: 70,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        color: nightSky,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () => onSearch(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 100 - animation.value,
              child: StreamBuilder<SearchState>(
                initialData: Idle(),
                stream: stream,
                builder: (context, snapshot) =>
                    _buildContentForState(snapshot.data, onOptionSelected),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _buildOptions(List<LocationOption> options,
        Function(LocationOption) onOptionSelected) =>
    ListView(
      children: options
          .map((option) => ListTile(
                title: Text(
                  option.name,
                  style: TextStyle(fontSize: 24, color: nightSky),
                ),
                subtitle: Text(
                  option.province,
                  style: TextStyle(fontSize: 18, color: nightSky),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: nightSky,
                ),
                onTap: () => onOptionSelected(option),
              ))
          .toList(),
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
        Text(message),
      ],
    ),
  );
}

Widget _buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
