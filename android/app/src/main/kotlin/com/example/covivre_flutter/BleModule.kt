package com.example.covivre_flutter


import android.Manifest
import android.app.Activity
import android.app.AlertDialog
import android.bluetooth.BluetoothAdapter
import android.bluetooth.le.BluetoothLeScanner
import android.bluetooth.le.ScanCallback
import android.bluetooth.le.ScanResult
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Handler
import android.util.Log
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat


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
    private lateinit var context: MainActivity

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun scanLeDevice() {
//        if (!isScan) {
        btLeScanner.startScan(callBack)
//            this.isScan = true
//
//            handler.postDelayed(Runnable() {
//                btLeScanner.stopScan(callBack)
//                this.isScan = false
//            }, scanPeriod)
//        }
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
            context.sendResult("scanning was stopped!")
            Log.d(TAG,"scanning was stopped!")
        }
    }

    private fun requestLocationPermission() {
        Log.d(TAG, "In requestLocationPermission")
        ActivityCompat.requestPermissions(context,
                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                REQUEST_LOCATION_PERMISSION)
    }

    private fun displayRationale() {
        Log.d(TAG, "In displayRationale")
        AlertDialog.Builder(this)
                .setMessage("Allow use location.")
                .setPositiveButton("Allow")
                { _, _ -> requestLocationPermission() }
                .setNegativeButton("Deny") { _, _ -> }
                .show()
    }

    private fun isAboveMarshmallow(): Boolean {
        Log.d(TAG, "In isAboveMarshmallow")
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
    }

    private fun isLocationPermissionEnabled(): Boolean {
        Log.d(TAG, "In isLocationPermissionEnabled")
        return ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) ==
                PackageManager.PERMISSION_GRANTED
    }


    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun getResult(name : String){
        Log.d(TAG, "In result")
    }



    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun startScan(a: String, context: MainActivity){
        Log.d(TAG, "In startScan")
        this.context = context
        checkLocationPermission()
//        promise.resolve(a)
    }
    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    private fun checkLocationPermission( ) {
        Log.d(TAG, "In checkLocationPermission")
        if (isAboveMarshmallow()) {
            when {
                isLocationPermissionEnabled() -> initBLEModule()
                ActivityCompat.shouldShowRequestPermissionRationale(context,
                        Manifest.permission.ACCESS_FINE_LOCATION) -> displayRationale()
                else -> requestLocationPermission()
            }
        } else {
            initBLEModule()
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
