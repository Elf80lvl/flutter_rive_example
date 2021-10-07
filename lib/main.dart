import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rive/smiley_controller.dart';
import 'package:delayed_display/delayed_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _rating = 5.0;
  String _currentAnimation = '5+';
  SmileyController _smileyController = SmileyController();

  void _onChanged(double value) {
    setState(() {
      if (_rating == value) return;
      //направление анимации, от более улыбчивой к менее или наоборот
      var direction = _rating < value ? '+' : '-';
      _rating = value;
      _currentAnimation = '${value.round()}$direction';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              child: DelayedDisplay(
                delay: Duration(seconds: 3),
                child: FlareActor(
                  'assets/happiness_emoji.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  controller: _smileyController,
                  animation: _currentAnimation,
                ),
              ),
            ),
            Slider(
              value: _rating,
              min: 1.0,
              max: 5.0,
              divisions: 4,
              onChanged: _onChanged,
            ),
            DelayedDisplay(
              child: Text(
                '${_rating.round()}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
