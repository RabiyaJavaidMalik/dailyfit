package com.dailyfit.utils.workers

import android.content.Context
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import com.dailyfit.utils.NotificationUtils

class WaterReminderWorker(
    context: Context,
    params: WorkerParameters
) : CoroutineWorker(context, params) {

    override suspend fun doWork(): Result {
        NotificationUtils.showNotification(
            applicationContext,
            NotificationUtils.WATER_REMINDER_CHANNEL_ID,
            "Time to Hydrate! 💧",
            "Don't forget to drink a glass of water",
            1001
        )
        return Result.success()
    }
}