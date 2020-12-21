import 'dart:async';

import 'package:search/classes/appTheme.dart';
import 'package:search/components/drawer.dart';
import 'package:search/constants/appConstants.dart';

import 'package:flutter/material.dart';
import 'package:search/serviceLocator.dart';
import 'package:search/services/LocalStorageService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  Color _tempColor;
  void changeColor(Color color) => setState(
        () {
          locator<LocalStorageService>().highlightColor = color.toString();
          // Provider.of<ThemeModel>(context, listen: false)
          //     .updateTheme(ThemeData.light().copyWith(highlightColor: color));
          // LightAppTheme.theme =
          //     ThemeData.light().copyWith(highlightColor: color);
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 56,
        title: Text(
          SETTINGS_SCREEN_TITLE,
        ),
        backgroundColor: Theme.of(context).appBarTheme.color,
        iconTheme: Theme.of(context).iconTheme,
      ),
      drawer: CommonDrawer(SETTINGS_SCREEN_TITLE),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: Text("Highlight Color"),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        contentPadding: const EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                          child: MaterialPicker(
                            pickerColor: hexToColor(
                                locator<LocalStorageService>().highlightColor),
                            onColorChanged: (color) =>
                                setState(() => _tempColor = color),
                            enableLabel: true,
                          ),
                        ),
                        actions: [
                          FlatButton(
                            child: Text('CANCEL'),
                            onPressed: Navigator.of(context).pop,
                          ),
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() => locator<LocalStorageService>()
                                      .highlightColor =
                                  _tempColor.value.toString());
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.circle,
                  size: 36,
                ),
                color:
                    hexToColor(locator<LocalStorageService>().highlightColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}