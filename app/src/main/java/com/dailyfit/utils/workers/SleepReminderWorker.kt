package com.dailyfit.utils.workers

import android.content.Context
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import com.dailyfit.utils.NotificationUtils

class SleepReminderWorker(
    context: Context,
    params: WorkerParameters
) : CoroutineWorker(context, params) {

    override suspend fun doWork(): Result {
        NotificationUtils.showNotification(
            applicationContext,
            NotificationUtils.SLEEP_REMINDER_CHANNEL_ID,
            "Time for Bed! 😴",
            "Don't forget to log your sleep time",
            1003
        )
        return Result.success()
    }
}