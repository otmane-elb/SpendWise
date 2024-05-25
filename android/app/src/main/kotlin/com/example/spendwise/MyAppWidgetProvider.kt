package com.example.spendwise

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.widget.RemoteViews

class MyAppWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(context: Context?, appWidgetManager: AppWidgetManager?, appWidgetIds: IntArray?) {
        val thisWidget = ComponentName(context!!, MyAppWidgetProvider::class.java)
        val allWidgetIds = appWidgetManager?.getAppWidgetIds(thisWidget)
        
        val remoteViews = RemoteViews(context.packageName, R.layout.widget_layout)
        // Update the widget with your data
        remoteViews.setTextViewText(R.id.widget_balance_label, "Total Balance ^")
        remoteViews.setTextViewText(R.id.widget_balance, "-$165.63")
        remoteViews.setTextViewText(R.id.widget_income_label, "Income")
        remoteViews.setTextViewText(R.id.widget_income, "$0.00")
        remoteViews.setTextViewText(R.id.widget_expense_label, "Expenses")
        remoteViews.setTextViewText(R.id.widget_expense, "$165.63")

        if (allWidgetIds != null) {
            for (widgetId in allWidgetIds) {
                appWidgetManager.updateAppWidget(widgetId, remoteViews)
            }
        }
    }
}
