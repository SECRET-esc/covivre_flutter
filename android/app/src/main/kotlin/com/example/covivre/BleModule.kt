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
    private val TAG: String = "debug"


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
    private val uuidIllAndOld = UUID.fromString("10000000-0000-0000-0000-000000000003")
    private val uuidIll = UUID.fromString("10000000-0000-0000-0000-000000000001")
    private val uuidOld = UUID.fromString("10000000-0000-0000-0000-000000000002")

    var old = mutableListOf<String>()
    val ill = mutableListOf<String>()
    var turnScanOn = false
    var lastScanResults: Long = 0

    companion object {
        lateinit var instance: BleModule
    }

    init {
        instance = this
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun scanLeDevice() {
        turnScanOn = !turnScanOn

        Log.d(TAG, "turnScanOn: $turnScanOn")
        if (turnScanOn) {
            createPeriodicScan()
        } else {
            stopScan()
        }
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun createPeriodicScan() {
        if (!turnScanOn)
            return
        btLeScanner.startScan(buildFilters(), buildSettings(), callBack)
        this.isScan = true
        if (!this::handler.isInitialized) {
            handler = Handler()
        }
        handler.postDelayed(Runnable() {
            btLeScanner.stopScan(callBack)
            this.isScan = false
        }, scanPeriod)
        handler.postDelayed(Runnable() {
            createPeriodicScan()
        }, scanPeriod * 2)
        checkIfNeedClearing()
    }

    fun checkIfNeedClearing(){
        if (lastScanResults-(System.currentTimeMillis() / 1000)>15){
            context.sendResult(mapOf("ill" to 0, "old" to 0))
        }
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun stopScan() {
        btLeScanner.stopScan(callBack)
        this.isScan = false
        advertiser!!.stopAdvertising(mAdvertiseCallback)
    }

    fun buildSettings(): ScanSettings? {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            return ScanSettings.Builder().setScanMode(ScanSettings.SCAN_MODE_LOW_POWER).build()
        }
        return null
    }

    fun buildFilters(): List<ScanFilter>? {
        val builder = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            ScanFilter.Builder()
        } else {
            TODO("VERSION.SDK_INT < LOLLIPOP")
        }
        val builder1 = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            ScanFilter.Builder()
        } else {
            TODO("VERSION.SDK_INT < LOLLIPOP")
        }
// use if not working
//        val manufacturerData = ByteBuffer.allocate(23)
//        val manufacturerDataMask = ByteBuffer.allocate(23)
//        val uuidBytes = getByteArrayFromGuid(uuidIll())!!
//
//        for (i in 2..17) {
//            manufacturerData.put(i, uuidBytes[i - 2])
//            manufacturerDataMask.put(i, 0x01)
//        }

        builder.setManufacturerData(0x004C, null, null)
        builder1.setManufacturerData(0x004C, null, null)
        val serviceUuidMaskString = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF"
        var parcelUuid = ParcelUuid(uuidIll)
        val parcelUuidMask = ParcelUuid.fromString(serviceUuidMaskString)
        builder.setServiceUuid(parcelUuid, parcelUuidMask)
        parcelUuid = ParcelUuid(uuidOld)
        builder1.setServiceUuid(parcelUuid, parcelUuidMask)
        return listOf(builder.build(), builder1.build())
    }

    // LOLLIPOP - android 5.1.1
    private val callBack: ScanCallback = @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    object : ScanCallback() {
        @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
        override fun onScanResult(callbackType: Int, result: ScanResult) {
            super.onScanResult(callbackType, result)
            lastScanResults = System.currentTimeMillis() / 1000
            context.sendResult(getServiceUUIDsList(result))
            Log.d(TAG, "rssi: " + result.getRssi() + "address: " + result.device.toString());

//            btLeScanner.startScan(buildFilters(), buildSettings(), callBackStop)

        }
    }


    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    private fun getServiceUUIDsList(scanResult: ScanResult): Map<String, Int> {
        val parcelUuids = scanResult.scanRecord!!.serviceUuids
        for (i in parcelUuids.indices) {
            val serviceUUID = parcelUuids[i].uuid
            val uuidString = serviceUUID.toString()
            if (serviceUUID.toString() == uuidIll.toString()) {
                ill.add(uuidString)
            } else if (serviceUUID.toString() == uuidOld.toString()) {
                old.add(uuidString);
            }
        }
        val resp = mapOf("ill" to ill.distinct().size, "old" to old.distinct().size)
        Log.d(TAG, "resp: $resp")
        return resp
    }

    private val callBackStop: ScanCallback = @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    object : ScanCallback() {
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
    fun getResult(name: String) {
        Log.d(TAG, "In result")
    }


    fun startScan(context: ForegroundService) {
        Log.d(TAG, "In startScan")
        this.context = context
        checkLocationPermission()
    }

    private fun checkLocationPermission() {
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
        if (!ForegroundService.instance.positive!! && !ForegroundService.instance.closeContact!! && !ForegroundService.instance.risk!!) {
            Log.d("App", "Failed to create advertiser - no need")
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
                .setIncludeDeviceName(false)
                .setIncludeTxPowerLevel(false)
//                .addManufacturerData(0x004C, null)
        if (ForegroundService.instance.positive!! || ForegroundService.instance.closeContact!!) {
            data.addServiceUuid(ParcelUuid(uuidIll))
        } else if (ForegroundService.instance.risk!!) {
            data.addServiceUuid(ParcelUuid(uuidOld))
        }

        advertiser!!
                .startAdvertising(settings, data.build(), mAdvertiseCallback)
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

    fun cancelDiscovery() {
        btAdapter.cancelDiscovery()
    }


}
