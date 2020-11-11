package com.example.covivre

import android.Manifest
import android.annotation.SuppressLint
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

    val TAG = "Covivre"
    private val MY_PERMISSIONS_REQUEST_FOR_LOCATION = 1
    var myService: ForegroundService? = null
    var isBound = false
    private lateinit var flutterEngine1: FlutterEngine

    val PARAM_TASK = "task"
    val PARAM_SCAN = "scan"
    val ACTION_FIND_SICK = "device"
    val PARAM_SICK = "SICK"
    val ACTION_METERS = "METERS"
    private val work = false
    val TASK_CODE = 1
    val FOUND_SICK = 1
    val GET_METERS = 2
    var SCAN_CODE = 0
    val BROADCAST_ACTION = "covivre.p096111servicebackbroadcast"
    var br: BroadcastReceiver? = null

    companion object {
        lateinit var instance: MainActivity
    }

    init {
        instance = this
    }

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
        createListener()
    }

    private fun createListener(){
        br = object : BroadcastReceiver() {
            // действия при получении сообщений
            override fun onReceive(context: Context?, intent: Intent) {
                val status = intent.getIntExtra(ACTION_FIND_SICK, 0)
                Log.d(TAG, "STATUS = = = $status")
                // Ловим сообщения о старте задач
                if (FOUND_SICK == status) {
                    val people_sick = intent.getStringExtra(PARAM_SICK)
//                    view.setText(people_sick)
                    // TODO: send people_sick to front
                } else if (status == 3) {
                    // TODO: send meters and people sick 0 to front
                }
                if (status == GET_METERS) {
                    val meter = intent.getDoubleExtra(ACTION_METERS, 0.0)
                    val roundMeter = String.format("%.1f", meter)
                    Log.d(TAG, "Meters:$roundMeter")
                    // TODO: send meters to front
                }
            }
        }
        // создаем фильтр для BroadcastReceiver
        val intFilt = IntentFilter(BROADCAST_ACTION)
        // регистрируем (включаем) BroadcastReceiver
        registerReceiver(br, intFilt)

        val sharedPreferences = getSharedPreferences("save", MODE_PRIVATE)
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(br)
        if(isBound){
            unbindService(myConnection)
        }
    }

    override fun onPause() {
        super.onPause()
        Log.d(TAG, "onPause")
    }

    override fun onRestart() {
        super.onRestart()
        Log.d(TAG, "onRestart")
    }


    override fun onResume() {
        Log.d(TAG, "onResume ")
        super.onResume()
    }


    override fun onStop() {
        super.onStop()
        Log.d(TAG, "onStop")
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