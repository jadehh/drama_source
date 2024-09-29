package com.example.drama_source_app

import android.os.Handler
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File




class MainActivity: FlutterActivity() {
    companion object {
        private const val CHANNEL = "com.example.drama_source_app/spider"
        private const val METHOD_init= "init"
        private const val METHOD_homeContent = "homeContent"
        private const val METHOD_homeVideoContent = "homeVideoContent"
    }

    private val handler: Handler = Handler()
    private var pendingResult: MethodChannel.Result? = null
    private lateinit var channel: MethodChannel

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { methodCall: MethodCall, result: MethodChannel.Result ->
            val ext = methodCall.argument<String>("ext").toString()
            val api = methodCall.argument<String>("api").toString()
            val path = methodCall.argument<String>("path").toString()
            val spider = JarSpider(ext,api,this,path)
            if (methodCall.method == METHOD_init){
                result.success("初始化成功")
            }
            else if (methodCall.method == METHOD_homeContent) {
                val filter = methodCall.argument<Boolean>("filter")!!
                Thread({
                    result.success(spider.homeContent(filter))
                }).start()
            }
            else if (methodCall.method == METHOD_homeVideoContent) {
                Thread({
                    result.success(spider.homeVideoContent())
                }).start()
            }

            else result.notImplemented()
        }
    }
}
