package com.example.covivre


import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.bluetooth.le.*
import android.content.ContentValues
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.ParcelUuid
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import java.lang.reflect.Method
import java.util.*


class BleModule() : AppCompatActivity() {
    private val TAG : String = "debug"


    val random: Random = Random()

    lateinit var btLeScanner: BluetoothLeScanner
    lateinit var handler: Handler
    private lateinit var btAdapter: BluetoothAdapter
    var isScan = false
    private var REQUEST_LOCATION_PERMISSION = 1
    private var REQUEST_ENABLE_BT = 1
    var scanPeriod: Long = 5000
    var strengthThreshold = -60
    private lateinit var context: ForegroundService
    var btManager: BluetoothManager? = null
    var advertiser: BluetoothLeAdvertiser? = null
    var idChannel = "my_channel_01"
    private val uuid = UUID.fromString("10000000-0000-0000-0000-000000000001")


    companion object {
        lateinit var instance: BleModule
    }

    init {
        instance = this
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun scanLeDevice() {
        if (!isScan) {
        btLeScanner.startScan(callBack)
            this.isScan = true
            if (!this::handler.isInitialized){
                handler = Handler()
            }
            handler.postDelayed(Runnable() {
                btLeScanner.stopScan(callBack)
                this.isScan = false
            }, scanPeriod)
        }
    }
    // LOLLIPOP - android 5.1.1
    private val callBack: ScanCallback = @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    object : ScanCallback(){
        @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
        override fun onScanResult(callbackType: Int, result: ScanResult) {
            super.onScanResult(callbackType, result)
            val name = result.device.name
            val uuids = result.device.uuids
            if (name!==null) {
                getResult(name)
                context.sendResult(name)
            }
            Log.d(TAG, "Device name:" + name + "rssi: " + result.getRssi() + "uuids: " + uuids.toString());
            btLeScanner.startScan(callBackStop)

        }
    }
    private val callBackStop: ScanCallback = @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    object : ScanCallback(){
        @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
        override fun onScanResult(callbackType: Int, result: ScanResult) {
            super.onScanResult(callbackType, result)
            context.sendResult("scanning was stopped! - $result")
            Log.d(TAG, "scanning was stopped!$result")
        }
    }

    private val mAdvertiseCallback: AdvertiseCallback = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
        object : AdvertiseCallback() {
            override fun onStartSuccess(settingsInEffect: AdvertiseSettings) {
                Log.i("App", "LE Advertise Started.")
            }

            override fun onStartFailure(errorCode: Int) {
                Log.w("App", "LE Advertise Failed: $errorCode")
            }
        }
    } else {
        TODO("VERSION.SDK_INT < LOLLIPOP")
    }


    private fun isAboveMarshmallow(): Boolean {
        Log.d(TAG, "In isAboveMarshmallow")
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun getResult(name: String){
        Log.d(TAG, "In result")
    }


    fun startScan(context: ForegroundService){
        Log.d(TAG, "In startScan")
        this.context = context
        checkLocationPermission()
    }
    private fun checkLocationPermission( ) {
        Log.d(TAG, "In checkLocationPermission")
        if (isAboveMarshmallow()) {
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                initBLEModule()
            }
        }
    }
    /***After receive the Location Permission, the Application need to initialize the
     * BLE Module and BLE Service*/
    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    private fun initBLEModule() {
        btAdapter = BluetoothAdapter.getDefaultAdapter()
        btLeScanner = btAdapter.getBluetoothLeScanner();
        advertiser = btAdapter.getBluetoothLeAdvertiser();
        Log.d(TAG, "Start service");
        btLeScanner = btAdapter.bluetoothLeScanner
        Log.d(TAG, "In initBLEModule")
// BLE initialization
        if (!btAdapter.isEnabled) {
            val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
            MainActivity.instance.startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT)
        }
        if (btAdapter.isEnabled) {
            scanLeDevice()
            startAdvertising()
        }
    }

    private fun startAdvertising() {
        if (advertiser == null) {
            Log.d("App", "Failed to create advertiser")
            return
        }
        val settings = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            AdvertiseSettings.Builder()
                    .setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_BALANCED)
                    .setConnectable(true)
                    .setTimeout(0)
                    .setTxPowerLevel(AdvertiseSettings.ADVERTISE_TX_POWER_MEDIUM)
                    .build()
        } else {
            TODO("VERSION.SDK_INT < LOLLIPOP")
        }
        val data = AdvertiseData.Builder()
                .setIncludeDeviceName(true)
                .setIncludeTxPowerLevel(false)
                .addServiceUuid(ParcelUuid(uuid))
                .build()
        advertiser!!
                .startAdvertising(settings, data, mAdvertiseCallback)
    }


    fun turnOnDiscoverable() {
        if (btAdapter.scanMode != BluetoothAdapter.SCAN_MODE_CONNECTABLE_DISCOVERABLE) {
            Log.d(ContentValues.TAG, "Restart discoverable")
            val method: Method
            try {
                method = btAdapter.javaClass.getMethod("setScanMode", Int::class.javaPrimitiveType, Int::class.javaPrimitiveType)
                method.invoke(btAdapter, BluetoothAdapter.SCAN_MODE_CONNECTABLE_DISCOVERABLE, 400)
                Log.e("invoke", "method invoke successfully")
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    fun cancelDiscovery(){
        btAdapter.cancelDiscovery()
    }


}
