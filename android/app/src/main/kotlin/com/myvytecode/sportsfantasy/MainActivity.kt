package com.myvytecode.sportsfantasy

import android.annotation.TargetApi
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.content.pm.PackageManager
import android.widget.Toast
import androidx.lifecycle.LifecycleRegistry
import androidx.core.content.ContextCompat.getSystemService
import androidx.lifecycle.Lifecycle
import com.google.android.gms.common.util.AndroidUtilsLight


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.mybytecode.Wp-Blog/share"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            val data: String? = call.argument<String>("data")
            if (call.method == "system") {
                systemShare(data)
            } else if (call.method == "whatsapp") {
                sendWhatsAppIntent(data)
            } else if (call.method == "twitter") {
                sendTwitterIntent(data)
            } else if (call.method == "facebook") {
                sendTOFacebook(data)
            }
        }
    }

    private fun systemShare(data: String?) {
        val sendIntent = Intent()
        sendIntent.action = Intent.ACTION_SEND
        sendIntent.putExtra(Intent.EXTRA_TEXT, data)
        sendIntent.type = "text/plain"
        startActivity(sendIntent)
    }

    @TargetApi(Build.VERSION_CODES.DONUT)
    private fun sendWhatsAppIntent(data: String?) {

        if (appInstalledOrNot("com.whatsapp")) {
            val sendIntent = Intent()
            sendIntent.action = Intent.ACTION_SEND
            sendIntent.putExtra(Intent.EXTRA_TEXT, data)
            sendIntent.type = "text/plain"
            sendIntent.setPackage("com.whatsapp")
            startActivity(sendIntent)

        } else {
            Toast.makeText(context, "WhatsApp is not installed", Toast.LENGTH_LONG).show()
        }
    }

    private fun sendTwitterIntent(data: String?) {
        if (appInstalledOrNot("com.twitter.android")) {
            val url = "http://www.twitter.com/intent/tweet?url=&text=$data"
            val i = Intent(Intent.ACTION_VIEW)
            i.data = Uri.parse(url)
            startActivity(i)
        } else {
            Toast.makeText(context, "Twitter is not installed", Toast.LENGTH_LONG).show()
        }
    }


        private fun sendTOFacebook(data: String?) {
            if (appInstalledOrNot("com.facebook.katana")) {
                val share = Intent(Intent.ACTION_SEND)
                share.type = "text/plain"
                share.putExtra(Intent.EXTRA_TEXT, data)
                share.setPackage("com.facebook.katana") //Facebook App package
                startActivity(Intent.createChooser(share, "Facebook"))
            } else {
                Toast.makeText(context, "Facebook is not installed", Toast.LENGTH_LONG).show()
            }
        }

    private fun appInstalledOrNot(uri: String): Boolean {
        val pm = packageManager
        try {
            pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES)
            return true
        } catch (e: PackageManager.NameNotFoundException) {
        }

        return false
    }
}