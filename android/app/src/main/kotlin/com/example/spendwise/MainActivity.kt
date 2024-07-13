package com.otmane.spendwise

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.widget.RemoteViews
import androidx.core.content.ContextCompat

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.otmane.spendwise/widget"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "updateWidget") {
                val balance = call.argument<Double>("balance")
                val income = call.argument<Double>("income")
                val expense = call.argument<Double>("expense")

                val context = applicationContext
                val appWidgetManager = AppWidgetManager.getInstance(context)

                val appWidgetIds = appWidgetManager.getAppWidgetIds(
                    ComponentName(context, MyAppWidgetProvider::class.java)
                )

                for (appWidgetId in appWidgetIds) {
                    val views = RemoteViews(context.packageName, R.layout.widget_layout)
                    views.setTextViewText(R.id.widget_balance, "$${String.format("%.2f", balance)}")
                    views.setTextViewText(R.id.widget_income, "$${String.format("%.2f", income)}")
                    views.setTextViewText(R.id.widget_expense, "$${String.format("%.2f", expense)}")

                    // Set text color based on balance
                    val balanceColor = if (balance != null && balance > 0) {
                        ContextCompat.getColor(context, android.R.color.white)
                    } else {
                        ContextCompat.getColor(context, R.color.red_color)
                    }
                    views.setTextColor(R.id.widget_balance, balanceColor)

                    appWidgetManager.updateAppWidget(appWidgetId, views)
                }

                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }
}
