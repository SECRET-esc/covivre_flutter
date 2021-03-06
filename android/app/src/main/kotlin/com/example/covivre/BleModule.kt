package com.example.covivre


import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.bluetooth.le.*
import android.content.ContentValues
import android.content.Context
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
    var timestampLast: Long = 0
    private var REQUEST_LOCATION_PERMISSION = 1
    private var REQUEST_ENABLE_BT = 1
    var scanPeriod: Long = 5000
    var strengthThreshold = -60
    private lateinit var context: ForegroundService
    var btManager: BluetoothManager? = null
    var advertiser: BluetoothLeAdvertiser? = null
    var idChannel = "my_channel_01"
    private val uuidIll = UUID.fromString("10000000-0000-0000-0000-000000000002")
    private val uuidOld = UUID.fromString("10000000-0000-0000-0000-000000000003")
    private val uuidNormal = UUID.fromString("10000000-0000-0000-0000-000000000001")
    private val uuidContact = UUID.fromString("10000000-0000-0000-0000-000000000004")

    var old = mutableListOf<String>()
    var oldGraph = mutableListOf<String>()
    var oldGraphDay = mutableListOf<String>()
    var ill = mutableListOf<String>()
    var illGraph = mutableListOf<String>()
    var illGraphDay = mutableListOf<String>()
    var normal = mutableListOf<String>()
    var normalGraph = mutableListOf<String>()
    var normalGraphDay = mutableListOf<String>()
    var contact = mutableListOf<String>()
    var contactGraph = mutableListOf<String>()
    var contactGraphDay = mutableListOf<String>()
    var turnScanOn = true
    var lastScanResults: Long = 0
    var dayGraphOld = mutableMapOf<Int, MutableList<String>>()
    var dayGraphIll = mutableMapOf<Int, MutableList<String>>()
    var dayGraphNormal = mutableMapOf<Int, MutableList<String>>()
    var dayGraphContact = mutableMapOf<Int, MutableList<String>>()
    var hourGraphOld = mutableMapOf<Int, MutableList<String>>()
    var hourGraphIll = mutableMapOf<Int, MutableList<String>>()
    var hourGraphNormal = mutableMapOf<Int, MutableList<String>>()
    var hourGraphContact = mutableMapOf<Int, MutableList<String>>()
    val c = Calendar.getInstance()
    var clearHoursData = false
    var clearDayData = false

    companion object {
        lateinit var instance: BleModule
    }

    init {
        instance = this
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun scanLeDevice() {

        Log.d(TAG, "turnScanOn: $turnScanOn")
        if (turnScanOn) {
            createPeriodicScan()
        } else {
//            stopScan()
        }
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun createPeriodicScan() {
        if (!turnScanOn)
            return
        initBLEModule()
        if (btAdapter.isEnabled) {
            btLeScanner.startScan(buildFilters(), buildSettings(), callBack)
        }
        this.isScan = true
        this.timestampLast = ((System.currentTimeMillis()))
        Log.d(TAG, "timestampLast = $timestampLast")
        context.sendData(mapOf("timestampLast" to timestampLast))
        if (!this::handler.isInitialized) {
            handler = Handler()
        }
        handler.postDelayed(Runnable() {
            if (btAdapter.isEnabled) {
                btLeScanner.stopScan(callBack)
            }
            this.isScan = false
            turnScanOn = true
        }, scanPeriod)
        handler.postDelayed(Runnable() {
            createPeriodicScan()
        }, scanPeriod * 2)
        checkIfNeedClearing()
    }

    fun checkIfNeedClearing() {
        val time = (System.currentTimeMillis() / 1000) - lastScanResults
        if ( time > 15) {
            context.sendResult(mapOf("ill" to 0, "old" to 0, "normal" to 0, "contact" to 0))
            old = mutableListOf<String>()
            ill = mutableListOf<String>()
            normal = mutableListOf<String>()
            contact = mutableListOf<String>()
        }
        Log.d(TAG, "checkIfNeedClearing time = $time")
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    fun stopScan() {
        btLeScanner.stopScan(callBack)
        this.isScan = false

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
        val builder2 = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            ScanFilter.Builder()
        } else {
            TODO("VERSION.SDK_INT < LOLLIPOP")
        }
        val builder3 = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
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
        builder2.setManufacturerData(0x004C, null, null)
        builder3.setManufacturerData(0x004C, null, null)
        val serviceUuidMaskString = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF"
        var parcelUuid = ParcelUuid(uuidIll)
        val parcelUuidMask = ParcelUuid.fromString(serviceUuidMaskString)
        builder.setServiceUuid(parcelUuid, parcelUuidMask)
        parcelUuid = ParcelUuid(uuidOld)
        builder1.setServiceUuid(parcelUuid, parcelUuidMask)
        parcelUuid = ParcelUuid(uuidNormal)
        builder2.setServiceUuid(parcelUuid, parcelUuidMask)
        parcelUuid = ParcelUuid(uuidContact)
        builder3.setServiceUuid(parcelUuid, parcelUuidMask)
        return listOf(builder.build(), builder1.build(), builder2.build(), builder3.build())
    }

    // LOLLIPOP - android 5.1.1
    private val callBack: ScanCallback = @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    object : ScanCallback() {
        @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
        override fun onScanResult(callbackType: Int, result: ScanResult) {
            super.onScanResult(callbackType, result)
            var resultSent = false;
            if (ForegroundService.instance.stateDistance == true
                    &&result.getRssi()>-69
                    ||ForegroundService.instance.stateDistance == false) {
                context.sendResult(getServiceUUIDsList(result))
                resultSent = true;
            }
            Log.d(TAG, "result sent: " +resultSent+ ""+ (result.getRssi()>-69) + (ForegroundService.instance.stateDistance)+ " rssi: " + result.getRssi() + " address: " + result.device.toString() + " lastScanResults: " + lastScanResults);

//            btLeScanner.startScan(buildFilters(), buildSettings(), callBackStop)

        }
    }
    private fun checkClear(){
        val cal = Calendar.getInstance()
        cal.time = Date(lastScanResults * 1000)
        if (c.get(Calendar.HOUR_OF_DAY)!=cal.get(Calendar.HOUR_OF_DAY)){
            illGraph = mutableListOf<String>()
            oldGraph = mutableListOf<String>()
            normalGraph = mutableListOf<String>()
            contactGraph = mutableListOf<String>()
        }
        if (c.get(Calendar.DAY_OF_YEAR)!=cal.get(Calendar.DAY_OF_YEAR)){
            illGraphDay = mutableListOf<String>()
            oldGraphDay = mutableListOf<String>()
            normalGraphDay = mutableListOf<String>()
            contactGraphDay = mutableListOf<String>()
        }

        lastScanResults = System.currentTimeMillis() / 1000
    }

    @RequiresApi(Build.VERSION_CODES.LOLLIPOP)
    private fun getServiceUUIDsList(scanResult: ScanResult): Map<String, Int> {
        checkClear()
        val parcelUuids = scanResult.scanRecord!!.serviceUuids
        ill = mutableListOf<String>()
        old = mutableListOf<String>()
        normal = mutableListOf<String>()
        contact = mutableListOf<String>()
        for (i in parcelUuids.indices) {
            val serviceUUID = parcelUuids[i].uuid
            val uuidString = serviceUUID.toString()
            if (serviceUUID.toString() == uuidIll.toString()) {
                ill.add(uuidString)
                illGraph.add(uuidString)
                illGraphDay.add(uuidString)
            } else if (serviceUUID.toString() == uuidOld.toString()) {
                old.add(uuidString);
                oldGraph.add(uuidString)
                oldGraphDay.add(uuidString)
            } else if (serviceUUID.toString() == uuidContact.toString()) {
                contact.add(uuidString);
                contactGraph.add(uuidString)
                contactGraphDay.add(uuidString)
            } else if (serviceUUID.toString() == uuidNormal.toString()) {
                normal.add(uuidString);
                normalGraph.add(uuidString)
                normalGraphDay.add(uuidString)
            }
        }
        val hour = c.get(Calendar.HOUR_OF_DAY)
        val day = c.get(Calendar.DAY_OF_YEAR)
        dayGraphIll.put(day, illGraphDay)
        dayGraphOld.put(day, oldGraphDay)
        dayGraphNormal.put(day, normalGraphDay)
        dayGraphContact.put(day, contactGraphDay)
        hourGraphOld.put(hour, oldGraph)
        hourGraphIll.put(hour, illGraph)
        hourGraphOld.put(hour, normalGraph)
        hourGraphIll.put(hour, contactGraph)
        context.sendDataGraph(mapOf(
                "dayIll" to dayGraphIll, "dayOld" to dayGraphOld, "dayNormal" to dayGraphNormal, "dayContact" to dayGraphContact,
                "hourIll" to hourGraphIll, "hourOld" to hourGraphOld, "hourNormal" to hourGraphNormal, "hourContact" to hourGraphContact
        ))
        val resp = mapOf("ill" to ill.distinct().size, "old" to old.distinct().size, "normal" to normal.distinct().size, "contact" to contact.distinct().size)
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
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            initBLEModule()
        }
        if (btAdapter.isEnabled) {
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
                scanLeDevice()
            }
        }
    }

    fun startAdvertise(context: ForegroundService) {
        Log.d(TAG, "In startAdvertise")
        this.context = context
            initBLEModule()
        if (btAdapter.isEnabled) {
            startAdvertising()
        }

    }

    fun stopAdvertise() {
        Log.d(TAG, "In stopAdvertise")
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            advertiser!!.stopAdvertising(mAdvertiseCallback)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_ENABLE_BT){
            startScan(this.context)
            startAdvertise(this.context)
        }

    }

    /***After receive the Location Permission, the Application need to initialize the
     * BLE Module and BLE Service*/
    private fun initBLEModule() {
        try {
            btAdapter = BluetoothAdapter.getDefaultAdapter()
        }catch (e: Exception){
            val btManager = if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.JELLY_BEAN_MR2) {
                getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
            } else {
                TODO("VERSION.SDK_INT < JELLY_BEAN_MR2")
            }
            btAdapter = btManager.adapter;
        }
        if (!btAdapter.isEnabled) {
            val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
            MainActivity.instance.startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT)
            return
        }
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            btLeScanner = btAdapter.getBluetoothLeScanner()
            advertiser = btAdapter.getBluetoothLeAdvertiser();
            Log.d(TAG, "Start service");
            btLeScanner = btAdapter.bluetoothLeScanner
        };



    }

    fun startAdvertising() {

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
        if (ForegroundService.instance.positive!!) {
            data.addServiceUuid(ParcelUuid(uuidIll))
        } else if (ForegroundService.instance.closeContact!!) {
            data.addServiceUuid(ParcelUuid(uuidContact))
        } else if (ForegroundService.instance.risk!!) {
            data.addServiceUuid(ParcelUuid(uuidOld))
        } else  {
            data.addServiceUuid(ParcelUuid(uuidNormal))
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
