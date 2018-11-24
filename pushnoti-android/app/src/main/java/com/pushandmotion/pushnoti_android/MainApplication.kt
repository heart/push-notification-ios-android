package com.pushandmotion.pushnoti_android

import android.app.Application
import com.google.firebase.messaging.FirebaseMessaging

class MainApplication: Application() {

    companion object{
        lateinit var instance: MainApplication
            private set
    }

    override fun onCreate() {
        super.onCreate()

        FirebaseMessaging.getInstance().isAutoInitEnabled = true
        instance = this

    }



}