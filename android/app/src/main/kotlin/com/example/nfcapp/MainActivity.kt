package com.example.nfcapp

import android.nfc.NfcAdapter
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import android.util.Log

class MainActivity : FlutterActivity() {
    private var nfcAdapter: NfcAdapter? = null
    private val TAG = "NfcApp"
    private val channel = "com.example.nfcapp/nfc"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        nfcAdapter = NfcAdapter.getDefaultAdapter(this)
        if (nfcAdapter == null) {
            Log.e(TAG, "NFC adapter not available on this device")
        }
        intent?.let { handleNfcIntent(it) }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            if (call.method == "checkNfcIntent") {
                result.success(intent?.action)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onResume() {
        super.onResume()
        nfcAdapter?.let { adapter ->
            val intent = intent
            val pendingIntent = android.app.PendingIntent.getActivity(
                this, 0, intent, android.app.PendingIntent.FLAG_UPDATE_CURRENT or android.app.PendingIntent.FLAG_MUTABLE
            )
            val intentFilters = arrayOf(
                android.content.IntentFilter(NfcAdapter.ACTION_NDEF_DISCOVERED).apply {
                    addDataType("text/plain")
                },
                android.content.IntentFilter(NfcAdapter.ACTION_TECH_DISCOVERED),
                android.content.IntentFilter(NfcAdapter.ACTION_TAG_DISCOVERED)
            )
            adapter.enableForegroundDispatch(this, pendingIntent, intentFilters, null)
            Log.d(TAG, "Foreground dispatch enabled")
        }
    }

    override fun onPause() {
        super.onPause()
        nfcAdapter?.disableForegroundDispatch(this)
        Log.d(TAG, "Foreground dispatch disabled")
    }

    override fun onNewIntent(intent: android.content.Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        handleNfcIntent(intent)
    }

    private fun handleNfcIntent(intent: android.content.Intent) {
        val action = intent.action
        Log.d(TAG, "Received NFC intent: $action")
        if (NfcAdapter.ACTION_NDEF_DISCOVERED == action ||
            NfcAdapter.ACTION_TECH_DISCOVERED == action ||
            NfcAdapter.ACTION_TAG_DISCOVERED == action) {
            Log.d(TAG, "NFC intent processed, letting flutter_nfc_kit handle polling")
        }
    }
}