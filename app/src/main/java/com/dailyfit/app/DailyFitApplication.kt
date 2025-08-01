package com.dailyfit.app

import android.app.Application
import androidx.work.Configuration
import com.dailyfit.utils.NotificationUtils

class DailyFitApplication : Application(), Configuration.Provider {

    override fun onCreate() {
        super.onCreate()
        NotificationUtils.createNotificationChannels(this)
    }

    override fun getWorkManagerConfiguration(): Configuration {
        return Configuration.Builder()
            .setMinimumLoggingLevel(android.util.Log.INFO)
            .build()
    }
}