package com.pushandmotion.pushnoti_android

import android.content.Context
import android.content.SharedPreferences
import android.util.Log
import com.google.firebase.messaging.FirebaseMessagingService

class MyFirebaseMessagingService: FirebaseMessagingService(){

    val TAG = "MyFirebaseMessagingService"

    /**
     * Called if InstanceID token is updated. This may occur if the security of
     * the previous token had been compromised. Note that this is called when the InstanceID token
     * is initially generated so this is where you would retrieve the token.
     */
    override fun onNewToken(token: String?) {
        Log.d(TAG, "Refreshed token: $token")

        val t = token ?: return
        SharedPrefsUtils.setStringPreference(MainApplication.instance,"push_key", t)

    }



}