package com.example.covivre

import android.Manifest
import android.app.AlertDialog
import android.content.*
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.os.IBinder
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {

    private val MY_PERMISSIONS_REQUEST_FOR_LOCATION = 1
    var myService: ForegroundService? = null
    var isBound = false
    private lateinit var flutterEngine1: FlutterEngine

    private val myConnection = object : ServiceConnection {
        override fun onServiceConnected(className: ComponentName,
                                        service: IBinder) {
            val binder = service as ForegroundService.MyLocalBinder
            myService = binder.getService()
            myService!!.configureFlatterChanel(flutterEngine1);
            isBound = true
        }

        override fun onServiceDisconnected(name: ComponentName) {
            isBound = false
        }
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        this.flutterEngine1 = flutterEngine
        startServiceForScan()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val intent = Intent(this, ForegroundService::class.java)
        bindService(intent, myConnection, Context.BIND_AUTO_CREATE)
    }


    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    private fun startServiceForScan() {

        if (ContextCompat.checkSelfPermission(this,
                        Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {

            if (ActivityCompat.shouldShowRequestPermissionRationale(this,
                            Manifest.permission.ACCESS_FINE_LOCATION)) {

            } else {

                // No explanation needed, we can request the permission.
                AlertDialog.Builder(this)
                        .setMessage("Allow use location.")
                        .setPositiveButton("Allow")
                        { _, _ -> requestLocationPermission() }
                        .setNegativeButton("Deny") { _, _ -> }
                        .show()

            }
        } else {
            startServiceForScanWithPermissions()
        }
    }

    private fun startServiceForScanWithPermissions(){
        val i = Intent(context, ForegroundService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            Log.d(ContentValues.TAG, "startForegroundService")
            startForegroundService(i)
        } else {
            Log.d(ContentValues.TAG, "startService")
            startService(i)
        }
    }
    private fun requestLocationPermission() {
        ActivityCompat.requestPermissions(this,
                arrayOf(Manifest.permission.ACCESS_FINE_LOCATION),
                MY_PERMISSIONS_REQUEST_FOR_LOCATION)
    }
}