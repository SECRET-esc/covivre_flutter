package com.example.covivre

import android.R
import android.app.*
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.content.BroadcastReceiver
import android.content.ContentValues.TAG
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Binder
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.Math.random


class ForegroundService : Service() {
    private val CHANNEL_ID: String = "my_chanel"
    private val CHANNEL = "covivre/scan"
    private val myBinder = MyLocalBinder()
    private lateinit var methodChannel: MethodChannel
    val bleModule = BleModule()
    var s: MutableList<String>? = null
    var sick = 0
    private val DELAY = 2
    private var signal = 100.0
    var scan: Boolean? = null
    var risk: Boolean? = null
    var positive: Boolean? = null
    var closeContact: Boolean? = null
    var showAtRisk: Boolean? = null
    var showMeetingRooms: Boolean? = null
    val NOTIFICATION_ID = 1988
    var illPersonsNum = 0
    var oldPersonsNum = 0

    companion object {
        lateinit var instance: ForegroundService
    }

    init {
        instance = this
    }

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "In onCreate")
    }

    fun configureFlatterChanel(flutterEngine: FlutterEngine) {
        this.methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        this.methodChannel.setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method == "startScan") {
                this.scan = call.argument("scan")
                this.risk = call.argument("risk")
                this.positive = call.argument("positive")
                this.closeContact = call.argument("closeContact")
                this.showAtRisk = call.argument("showAtRisk")
                this.showMeetingRooms = call.argument("showMeetingRooms")

                if (startScan() != -1) {
                    result.success(0)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    fun sendResult(arguments: Any?) {
        print("sendResult = $arguments")
        checkIfNotificationNeeded(arguments)
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
        } else {
            print("this::methodChannel.isInitialized not init")
        }
    }

    private fun checkIfNotificationNeeded(arguments: Any?){
        val params = arguments as Map<*, *>
        if (params["ill"] as Int > 0) {
            if (illPersonsNum < params["ill"] as Int) {
                illPersonsNum = params["ill"] as Int
                sendIllNotification()
            }
        }else {
            illPersonsNum = params["ill"] as Int
        }
        if (params["old"] as Int > 0) {
            if (oldPersonsNum < params["old"] as Int) {
                oldPersonsNum = params["old"] as Int
                sendOldNotification()
            }
        }else{
            oldPersonsNum = params["old"] as Int
        }
        if (illPersonsNum==0 && oldPersonsNum==0){
            clearNotification()
        }
    }

    private fun clearNotification() {
        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        notificationManager.cancel(NOTIFICATION_ID)
    }

    private fun sendIllNotification() {
        // Create an explicit intent for an Activity in your app
        val intent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        }
        val pendingIntent: PendingIntent = PendingIntent.getActivity(this, 0, intent, 0)

        val builder = NotificationCompat.Builder(this, CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_dialog_alert)
                .setContentTitle("Covivre")
                .setContentText("detect covid19 ill ${this.illPersonsNum} person near you")
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                // Set the intent that will fire when the user taps the notification
                .setContentIntent(pendingIntent)
                .setAutoCancel(true)
        with(NotificationManagerCompat.from(this)) {
            // notificationId is a unique int for each notification that you must define
            notify(NOTIFICATION_ID, builder.build())
        }
    }

    private fun sendOldNotification() {
        // Create an explicit intent for an Activity in your app
        val intent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        }
        val pendingIntent: PendingIntent = PendingIntent.getActivity(this, 0, intent, 0)

        val builder = NotificationCompat.Builder(this, CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_dialog_alert)
                .setContentTitle("Covivre")
                .setContentText("detect ${this.oldPersonsNum} vulnerable person near you")
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)
                // Set the intent that will fire when the user taps the notification
                .setContentIntent(pendingIntent)
                .setAutoCancel(true)
        with(NotificationManagerCompat.from(this)) {
            // notificationId is a unique int for each notification that you must define
            notify(NOTIFICATION_ID, builder.build())
        }
    }


    private fun startScan(): Int {
        makeCheck()
        bleModule.startScan(this, this.scan)
        return 0
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
        fun getService(): ForegroundService {
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

    @RequiresApi(Build.VERSION_CODES.O)
    fun ShowNotification() {
        Log.d(TAG, "In notify func")
        createNotificationChannel()
        val builder: NotificationCompat.Builder = NotificationCompat.Builder(applicationContext, CHANNEL_ID)
                .setContentTitle("You in dangerous!")
                .setContentText("Close to you have a ill person!")
                .setSmallIcon(R.drawable.alert_dark_frame)
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)
        val notification: Notification = builder.build()
        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        val num = random().toInt() + 1
        notificationManager.notify(num, notification)
    }

    override fun onDestroy() {
        super.onDestroy()
        try {
            unregisterReceiver(mBroadcastReceiver1)
            unregisterReceiver(mBroadcastReceiver2)
            unregisterReceiver(mBroadcastReceiver3)
            unregisterReceiver(mSamsungScreenOffReceiver)
        } catch (e: IllegalArgumentException) {
        }
        Log.d(TAG, "stop scanning!")
        bleModule.cancelDiscovery()
        stopSelf()
    }

    private val mBroadcastReceiver1: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent) {
            val action = intent.action
            if (action == BluetoothAdapter.ACTION_DISCOVERY_FINISHED) {
                Log.d(TAG, "Scan was stopped!")
                s?.clear()
                sick = 0
                s?.add("0x101010xmx909022x235ff5")
                val intent2 = Intent()
                intent2.putExtra("FindSick", 3)
                sendBroadcast(intent2)
                try {
                    Thread.sleep(1000 * DELAY.toLong())
                } catch (e: InterruptedException) {
                    e.printStackTrace()
                }
                unregisterReceiver(this)
//                startDiscovering()
            }
        }
    }
    private val mBroadcastReceiver2: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent) {
            val action = intent.action
            if (action == BluetoothAdapter.ACTION_DISCOVERY_STARTED) {
                Log.d(TAG, "Scan was STARTED!")
            }
            bleModule.turnOnDiscoverable()
        }
    }


    // Device scan callback.
    private val mBroadcastReceiver3: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent1: Intent) {
            val action = intent1.action
            Log.d(TAG, "onReceive: ACTION FOUND.")
            val rssi = intent1.getShortExtra(BluetoothDevice.EXTRA_RSSI, Short.MIN_VALUE).toInt()
            Log.d(TAG, "RSSI:$rssi")
            if (action == BluetoothDevice.ACTION_FOUND) {
                val device = intent1.getParcelableExtra<BluetoothDevice>(BluetoothDevice.EXTRA_DEVICE)
                val name = if (device?.name != null) device.name else "none"
                Log.d(TAG, "onReceive: " + name + ": " + device?.address)
                Log.d(TAG, name)
                if (name !== "none") {
                    if (name.length > 3) {
                        if (name.substring(name.length - 3) == "x34") {
                            val device_name: Boolean = s?.contains(name)!!
                            if (!device_name) {
                                if (rssi > -69) {
                                    //TODO: write logic
                                } else {
                                    val meters: Double = getMeters(rssi)
                                    if (meters < signal) {
                                        signal = meters
                                    } else {
                                        Log.i(TAG, "Signal val:" + signal.toString() + "Meters:" + meters)
                                    }
                                }
                                sick++
                                Log.d(TAG, "Sick:$sick")
                                s!!.add(name)
                            }
                        }
                    } else {
                        Log.d(TAG, "Name lower 3")
                    }
                    Log.d(TAG, """Device Name: ${device?.name} Address: ${device?.address}
""")
                }
            }
        }
    }

    fun getMeters(rssi: Int): Double {
        Log.d(TAG, "Calculate meters...")
        val i = Math.pow(10.0, (-69.0 - rssi) / (10 * 2))
        Log.d(TAG, "Meters = $i")
        return i
    }

    private val mSamsungScreenOffReceiver: BroadcastReceiver = object : BroadcastReceiver() {
        @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
        override fun onReceive(context: Context?, intent: Intent?) {
            Log.d(TAG, "Screen has gone off while using a wildcard scan filter on Samsung.  Restarting scanner with non-empty filters.")
            //bleModule.scanLeDevice()
        }
    }

    fun makeCheck() {
        if (Build.MANUFACTURER.equals("samsung", ignoreCase = true)) {
            Log.d(TAG, "Using a wildcard scan filter on Samsung because the screen is on.  We will switch to a non-empty filter if the screen goes off")
            // if this is samsung, as soon as the screen goes off we will need to start a different scan
            // that has scan filters
            val filter = IntentFilter(Intent.ACTION_SCREEN_OFF)
            registerReceiver(mSamsungScreenOffReceiver, filter)
            Log.d(TAG, "registering SamsungScreenOffReceiver $mSamsungScreenOffReceiver")
        }
    }
}