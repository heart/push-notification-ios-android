package com.pushandmotion.pushnoti_android

import android.Manifest
import android.content.ClipData
import android.content.ClipboardManager
import android.content.Context
import android.content.pm.PackageManager
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.app.ActivityCompat
import android.support.v4.content.ContextCompat
import android.view.View
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import com.google.firebase.iid.FirebaseInstanceId
import com.google.firebase.messaging.FirebaseMessaging

class MainActivity : AppCompatActivity() {

    val REQUEST_NOTI_CODE = 99988899

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        FirebaseMessaging.getInstance().isAutoInitEnabled = true

        val btn = findViewById<Button>(R.id.copy_push_key)

        btn.setOnClickListener(object : View.OnClickListener {
                override fun onClick(v: View?) {
                    val token = SharedPrefsUtils.getStringPreference(MainApplication.instance,"push_key")
                    val t = token ?: return

                    val myClipboard: ClipboardManager? = getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager?

                    val myClip = ClipData.newPlainText("text", t);
                    myClipboard?.setPrimaryClip(myClip);

                    Toast.makeText(MainApplication.instance, "Push key Copied!", Toast.LENGTH_SHORT).show();

                }
        })

        showPushKey()
        requestNotificationPermission()

    }

    private fun requestNotificationPermission(){

        if( ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_NOTIFICATION_POLICY ) ==
            PackageManager.PERMISSION_GRANTED ){
            return
        }

        if (ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.permission.ACCESS_NOTIFICATION_POLICY)) {

        }

        ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_NOTIFICATION_POLICY), REQUEST_NOTI_CODE )

    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        if(requestCode == REQUEST_NOTI_CODE){
            showPushKey()
        }
    }

    private fun showPushKey(){
        val token = SharedPrefsUtils.getStringPreference(MainApplication.instance,"push_key")
        val t = token ?: return
        findViewById<TextView>(R.id.push_key).text = t


    }


}
