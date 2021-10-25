import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../theme/app_theme.dart';

class SearchPage extends StatefulWidget {
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  bool _searchButtonPress = false;
  int _validate = 0;
  final _text = TextEditingController();

  @override
  Widget build(context) {
    return _getBody();
  }

  Widget _getBody() {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _searchTextField(),
          SizedBox(height: 20.0),
          _searchButton(),
        ],
      ),
    );
  }

  Widget _searchTextField() {
    return TextField(
      controller: _text,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).searchTextFieldTitle,
      ),
    );
  }

  Widget _searchButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            Theme.of(context).elevatedButtonTheme.style.backgroundColor,
      ),
      onPressed: _onPress,
      child: _searchButtonPress
          ? SizedBox(
              height: _elevatedButtonLoadingHeight,
              width: _elevatedButtonLoadingWidth,
              child: CircularProgressIndicator(
                color: AppTheme.searchButtonLoadingColor,
              ),
            )
          : Text(AppLocalizations.of(context).searchButtonTitle),
    );
  }

  void _onPress() {
    setState(() {
      if (_text.text.isEmpty) {
        _validate = 0;
        _errorDialog();
      } else if (_text.text.length < 3) {
        _validate = 1;
        _errorDialog();
      } else {
        _validate = 2;
        _onLoading();
      }
    });
  }

  Future _errorDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: _errorString(),
          actions: [
            TextButton(
              child: Text(AppLocalizations.of(context).okButtonText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _errorString() {
    if (_validate == 0) {
      return Text(AppLocalizations.of(context).emptyStringError);
    }
    return Text(AppLocalizations.of(context).searchValidationError);
  }

  void _onLoading() {
    setState(() {
      _searchButtonPress = true;
      new Future.delayed(new Duration(seconds: 2), _searchResultPage);
    });
  }

  Future _searchResultPage() async {
    setState(() => _searchButtonPress = false);
  }

  static const _elevatedButtonLoadingHeight = 20.0;
  static const _elevatedButtonLoadingWidth = 20.0;
}
