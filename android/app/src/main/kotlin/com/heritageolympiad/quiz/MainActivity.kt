package com.heritageolympiad.quiz

import io.flutter.embedding.android.FlutterActivity
import android.content.Context
import androidx.multidex.MultiDex
//import io.flutter.plugins.GeneratedPluginRegistrant
class MainActivity: FlutterActivity() {
    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)
        MultiDex.install(this)
//        GeneratedPluginRegistrant.registerWith(this)
    }
}
