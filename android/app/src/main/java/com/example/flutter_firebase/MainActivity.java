package com.example.flutter_firebase;

import android.annotation.TargetApi;
import android.app.NotificationManager;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
//import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import org.json.JSONException;
import org.json.JSONObject;

import io.flutter.plugin.common.MethodChannel;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

import static android.content.ContentValues.TAG;

public class MainActivity extends FlutterActivity {
    public static MethodChannel methodChannel;
    private String CHANNEL = "flutter_push_notification/platform_channel";
    private static final String TAG1 = "MainActivity";
    Intent intent;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        Log.e(TAG1, "onCreate: ");
        intent = getIntent();
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getIntent")) {
                                if (intent != null) {
                                    JSONObject userDetails = new JSONObject();
                                    try {
                                        userDetails.put("payload", intent.getStringExtra("payload"));

                                    } catch (JSONException e) {
                                        e.printStackTrace();
                                    }
                                    result.success(userDetails.toString());
                                } else {
                                    android.util.Log.e(TAG, "onCreate: No Intent");
                                    result.success("false");
                                }
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }


    @Override
    protected void onStart() {
        super.onStart();
        Log.e(TAG1, "onStart: " + getIntent().hasExtra("type"));
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.e(TAG1, "onResume: " + getIntent().hasExtra("type"));
    }

    @Override
    public void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        Log.e(TAG1, "onNewIntent: " + intent.hasExtra("type"));

        if (intent != null) {

            JSONObject userDetails = new JSONObject();

            try {
                userDetails.put("payload", intent.getStringExtra("payload"));

                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        MainActivity.methodChannel.invokeMethod("notification", userDetails.toString());
                    }
                });

            } catch (JSONException e) {
                e.printStackTrace();
            }
        }


    }


    private void cancelAllNotifications() {
        NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        notificationManager.cancelAll();
    }

}
