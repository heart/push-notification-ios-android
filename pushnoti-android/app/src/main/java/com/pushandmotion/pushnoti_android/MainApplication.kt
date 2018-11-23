package com.pushandmotion.pushnoti_android

import android.app.Application
import com.google.firebase.messaging.FirebaseMessaging

class MainApplication: Application() {

    override fun onCreate() {
        super.onCreate()

        FirebaseMessaging.getInstance().isAutoInitEnabled = true
    }
}