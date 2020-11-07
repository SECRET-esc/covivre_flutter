package com.example.covivre

import android.R
import android.app.*
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.content.*
import android.content.ContentValues.TAG
import android.os.Binder
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
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

    fun sendResult(arguments: String) {
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
        } else {
            print("this::methodChannel.isInitialized not init")
        }
    }


    private fun startScan(): Int {
        bleModule.startScan(this)
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
        unregisterReceiver(mBroadcastReceiver1)
        unregisterReceiver(mBroadcastReceiver2)
        unregisterReceiver(mBroadcastReceiver3)
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
}