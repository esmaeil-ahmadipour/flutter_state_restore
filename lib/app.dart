import 'package:flutter/material.dart';
import 'package:flutter_state_restore/dummy_page.dart';
import 'package:flutter_state_restore/home.dart';
import 'package:native_state/native_state.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var savedState = SavedState.of(context);
    debugPrint("rebuild app");
    // Navigator will set up the correct route history if they are structured in a hierarchical way.
    // See https://api.flutter.dev/flutter/widgets/Navigator/initialRoute.html
    return MaterialApp(
      // for restoring navigator state, you'll need to set a navigator key!
      navigatorKey: GlobalKey(),
      // Setup an observer that will save the current route into the saved state
      navigatorObservers: [SavedStateRouteObserver(savedState: savedState)],
      routes: {
        // If you want to get the saved state passed to your widget, use the builder constructor
        // The SavedState passed in here is "scoped" to this widget; it won't see any of the global state.
        NestedState.route: (context) => SavedState.builder(
            builder: (context, savedState) =>
                NestedState(savedState: savedState)),

        DummyPage.route: (context) => DummyPage(),
      },
      // restore the route or default to the home page
      initialRoute: SavedStateRouteObserver.restoreRoute(savedState) ?? "/",
      home: HomePage(),
    );
  }
}
