package com.dailyfit.utils.workers

import android.content.Context
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import com.dailyfit.utils.NotificationUtils

class WorkoutReminderWorker(
    context: Context,
    params: WorkerParameters
) : CoroutineWorker(context, params) {

    override suspend fun doWork(): Result {
        NotificationUtils.showNotification(
            applicationContext,
            NotificationUtils.WORKOUT_REMINDER_CHANNEL_ID,
            "Workout Time! 💪",
            "Time to get moving and log your workout",
            1004
        )
        return Result.success()
    }
}