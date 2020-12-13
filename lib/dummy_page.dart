import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_state/native_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DummyPage extends StatefulWidget {
  static const route = "/intermediate";
  static const platform = const MethodChannel(
      'ir.ea2.flutter_app_sample3');
  DummyPage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<DummyPage> {
  String text='Default Text ..';

  List<dynamic> phoneNumbersList = [];
  String apiToken;
  @override
  void initState() {
    super.initState();
    DummyPage.platform.setMethodCallHandler(_handleMethod);
  }

  @override
  Widget build(BuildContext context) {
    _getNativeDataList();
    if(mounted){
      if(phoneNumbersList!=null && phoneNumbersList.length>0){
        setState(() {
          text=("${phoneNumbersList[0]}  ${phoneNumbersList[1]}");
        });
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(text),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
              child: new Text(text),
              onPressed: ()async{
                showNativeView();
              },
            ),
          ],
        ),
      ),
    );
  }


  Future setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user.token','${phoneNumbersList==[]?'null':phoneNumbersList.length}');
    debugPrint(">>>>>>>>>>> getData");
    getData2();
  }
  Future getData2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiToken = 'token ${prefs.getString('user.token')}';
    debugPrint('apiToken : $apiToken');
    debugPrint(">>>>>>>>>>> getData2");
    Navigator.of(context).pushNamed(NestedState.route);
  }

  Future<dynamic> _getNativeDataList() async {
    String allData='';
    phoneNumbersList = await DummyPage.platform.invokeMethod('ABC');
    for (var i = 0; i < phoneNumbersList.length; ++i) {
      allData =allData+'/'+ phoneNumbersList[i];
    }
    debugPrint(">>>>>>>>>>> $allData");
    setState(() {

    });
    return phoneNumbersList;
  }

  Future<Null> showNativeView() async {
    await DummyPage.platform.invokeMethod('showNativeView');
  }


  Future<dynamic> _handleMethod(MethodCall call) async {
    switch(call.method) {
      case "message":{
        debugPrint('Flutter: ${call.arguments}');
        await _getNativeDataList();
        await setData();
      }
      return new Future.value("");
    }
  }
}





/*

class DummyPage2 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy page'),
      ),
      body: RaisedButton(
        child: Text("Onwards"),
        onPressed: () => Navigator.of(context).pushNamed(NestedState.route),
      ),
    );
  }
}
*/

class NestedState extends StatelessWidget {
  static const String route = "/intermediate/nested_state";

  final SavedStateData savedState;
  final bool restoredFromState;

  NestedState({this.savedState})
      : this.restoredFromState = savedState.getBool("saved") {
    savedState.putBool("saved", true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Text('Restored from state: $restoredFromState'),
      ),
    );
  }
}