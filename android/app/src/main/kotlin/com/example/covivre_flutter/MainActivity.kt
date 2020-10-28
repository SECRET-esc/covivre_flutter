package com.example.covivre_flutter

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/battery"
    private lateinit var methodChannel: MethodChannel

    @RequiresApi(VERSION_CODES.LOLLIPOP)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        this.methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        this.methodChannel.setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }

    }

    fun sendResult(arguments: String){
        this.methodChannel.invokeMethod("result", arguments, object : MethodChannel.Result {
            override fun success(result: Any?) {
//                TODO("Not yet implemented")
            }

            override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                TODO("Not yet implemented")
            }

            override fun notImplemented() {
                TODO("Not yet implemented")
            }
        })
    }

    @RequiresApi(VERSION_CODES.LOLLIPOP)
    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        startScan()
        return batteryLevel
    }

    @RequiresApi(VERSION_CODES.LOLLIPOP)
    private fun startScan() {
            val bleModule = BleModule()
            bleModule.startScan("start", this)
    }
}

