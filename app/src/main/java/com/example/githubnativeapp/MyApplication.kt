package com.example.githubnativeapp

import android.app.Application
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MyApplication : Application() {

    companion object {
        const val FLUTTER_ENGINE_ID = "flutter_engine"
    }

    override fun onCreate() {
        super.onCreate()

        val flutterEngine = FlutterEngine(this)

        flutterEngine.navigationChannel.setInitialRoute("/repos")

        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        FlutterEngineCache.getInstance().put(FLUTTER_ENGINE_ID, flutterEngine)
    }
}
