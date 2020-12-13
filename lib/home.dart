
import 'package:flutter/material.dart';
import 'package:native_state/native_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with StateRestoration {
  var _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
      SavedState.of(context).putInt("counter", _counter);
    });
  }

  @override
  void restoreState(SavedStateData savedState) {
    debugPrint("restoreState");
    setState(() {
      _counter = savedState.getInt("counter") ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Count = $_counter'),
            RaisedButton(
              child: Text("Increment"),
              onPressed: () => _increment(),
            ),
            LayoutBuilder(
              builder: (context, _) => RaisedButton(
                child: Text("Go"),
                onPressed: () =>
                    Navigator.of(context).pushNamed("/intermediate"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
