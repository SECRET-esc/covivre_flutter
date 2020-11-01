package com.example.covivre

import android.R
import android.app.*
import android.content.ContentValues.TAG
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Binder
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class ForegroundService : Service() {
    private val CHANNEL_ID: String = "my_chanel"
    private val CHANNEL = "samples.flutter.dev/battery"
    private val myBinder = MyLocalBinder()
    private lateinit var methodChannel: MethodChannel

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "In onCreate")
    }

    fun configureFlatterChanel(flutterEngine: FlutterEngine) {
        this.methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        this.methodChannel.setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                    getBatteryLevel()
                } else {
                    TODO("VERSION.SDK_INT < LOLLIPOP")
                }
                val bleModule = BleModule()
                bleModule.startScan(this)
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
        print("sendResult = $arguments")
        if (this::methodChannel.isInitialized) {
            this.methodChannel.invokeMethod("result", arguments, object : MethodChannel.Result {
                override fun success(result: Any?) {
                    print("methodChannel all done")
                }

                override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                    print("error $errorCode $errorMessage")
                }

                override fun notImplemented() {
                    print("notImplemented")
                }
            })
        }else{
            print("this::methodChannel.isInitialized not init")
        }
    }


    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLevel
    }

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        val input = intent.getStringExtra("inputExtra")
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            createNotificationChannel()
        }
        val pendingIntent = PendingIntent.getActivity(this, 0, Intent(this, MainActivity::class.java), 0)
        val notification: Notification = NotificationCompat.Builder(this, CHANNEL_ID)
                .setContentTitle("Covivre protection is active")
                .setContentText(input)
                .setSmallIcon(R.drawable.ic_dialog_alert)
                .setContentIntent(pendingIntent)
                .build()
        startForeground(1, notification)

        Log.d(TAG, "In onStartCommand")
        return START_NOT_STICKY
    }
    fun getService(): ForegroundService? {
        // Return this instance of MyService so clients can call public methods
        return this@ForegroundService
    }
    override fun onBind(intent: Intent): IBinder? {
        return myBinder
    }

    inner class MyLocalBinder : Binder() {
        fun getService() : ForegroundService {
            return this@ForegroundService
        }

    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun createNotificationChannel() {
        val serviceChannel = NotificationChannel(
                CHANNEL_ID,
                "Foreground Service Channel",
                NotificationManager.IMPORTANCE_DEFAULT)
        getSystemService(NotificationManager::class.java).createNotificationChannel(serviceChannel)
    }
}