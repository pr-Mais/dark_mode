import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Brightness brightness;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  brightness =
      (prefs.getBool("isDark") ?? false) ? Brightness.dark : Brightness.light;

  runApp(MyApp(brightness));
}

class MyApp extends StatelessWidget {
  final Brightness brightness;
  MyApp(this.brightness);

  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
      data: (brightness) => ThemeData(
        primarySwatch: Colors.indigo,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          theme: theme,
          title: 'Dark Mode Example',
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dark Mode Example"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Change Brightness"),
          onPressed: () {
            changeBrightness();
          },
        ),
      ),
    );
  }
}
