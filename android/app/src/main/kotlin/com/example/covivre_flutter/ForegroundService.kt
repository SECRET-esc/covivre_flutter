package com.example.covivre_flutter

import android.R
import android.app.*
import android.app.Service.START_NOT_STICKY
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat.getSystemService


class ForegroundService : Service() {
    private val CHANNEL_ID: String = "my_chanel"

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        val input = intent.getStringExtra("inputExtra")
        createNotificationChannel()
        val pendingIntent = PendingIntent.getActivity(this, 0, Intent(this, MainActivity::class.java), 0)
        val notification: Notification = NotificationCompat.Builder(this, CHANNEL_ID)
                .setContentTitle("Covivre protection is active")
                .setContentText(input)
                .setSmallIcon(R.drawable.ic_dialog_alert)
                .setContentIntent(pendingIntent)
                .build()
        startForeground(1, notification)

        val bleModule = BleModule()
        bleModule.startScan("start", MainActivity().activity as MainActivity)
        return START_NOT_STICKY
    }

    override fun onBind(p0: Intent?): IBinder? {
        TODO("Not yet implemented")
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