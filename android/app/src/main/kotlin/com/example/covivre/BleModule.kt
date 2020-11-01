package com.example.covivre


import android.bluetooth.BluetoothAdapter
import android.bluetooth.le.BluetoothLeScanner
import android.bluetooth.le.ScanCallback
import android.bluetooth.le.ScanResult
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.PersistableBundle
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity


class BleModule() : AppCompatActivity() {
    private val TAG : String = "debug"
    lateinit var btLeScanner: BluetoothLeScanner
    lateinit var handler: Handler
    private lateinit var btAdapter: BluetoothAdapter
    var isScan = false
    private var REQUEST_LOCATION_PERMISSION = 1
    private var REQUEST_ENABLE_BT = 1
    var scanPeriod: Long = 5000
    var strengthThreshold = -60
    private lateinit var context: ForegroundService

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
        override fun onScanResult(callbackType:Int, result: ScanResult) {
            super.onScanResult(callbackType, result)
            val name = result.device.name
            if (name!==null) {
                getResult(name)
                context.sendResult(name)
            }
            btLeScanner.startScan(callBackStop)

        }
    }
    private val callBackStop: ScanCallback = @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    object : ScanCallback(){
        @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
        override fun onScanResult(callbackType:Int, result: ScanResult) {
            super.onScanResult(callbackType, result)
            context.sendResult("scanning was stopped! - $result")
            Log.d(TAG, "scanning was stopped!$result")
        }
    }

    private fun isAboveMarshmallow(): Boolean {
        Log.d(TAG, "In isAboveMarshmallow")
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun getResult(name : String){
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
        btLeScanner = btAdapter.bluetoothLeScanner
        Log.d(TAG, "In initBLEModule")
// BLE initialization
        if (!btAdapter.isEnabled) {
            val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
            startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT)
        }
        if (btAdapter.isEnabled) {
            scanLeDevice()
        }
    }



}
