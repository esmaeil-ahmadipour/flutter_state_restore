package ir.ea2.flutter_state_restore
import android.os.Bundle
import io.flutter.plugin.common.MethodCall
import android.widget.Button
import java.util.*
import kotlin.collections.ArrayList
import kotlin.concurrent.schedule
import io.flutter.plugin.common.MethodChannel


class NativeViewActivity : io.flutter.embedding.android.FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val channel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, MainActivity.CHANNEL)

        setContentView(R.layout.layout)
        findViewById<Button>(R.id.button).setOnClickListener {
            channel.invokeMethod("message", "Hello from Android native host")
            MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, MainActivity.CHANNEL).setMethodCallHandler(
                    object : MethodChannel.MethodCallHandler {
                        override  fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
                            if (call.method == "ABC") {
                                val list: MutableList<String> = ArrayList()
                                list.add("Phone number 1")
                                list.add("Phone number 2")
                                list.add("Phone number 3")
                                result.success(list)
                            } else {
                                result.notImplemented()
                            }
                        }
                    }
            )
            Timer("Delay Time", false).schedule(500) {
                finish()
            }
        }


    }
}