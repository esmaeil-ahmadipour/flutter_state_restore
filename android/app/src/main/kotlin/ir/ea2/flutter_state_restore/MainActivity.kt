package ir.ea2.flutter_state_restore

import android.content.Intent
import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant





class MainActivity: io.flutter.embedding.android.FlutterActivity() {
    companion object {
        const val CHANNEL = "ir.ea2.flutter_app_sample3"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        GeneratedPluginRegistrant.registerWith(FlutterEngine(this))

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "showNativeView") {
                val intent = Intent(this, NativeViewActivity::class.java)
                startActivity(intent)
                result.success(true)
            }

        }



    }



}

