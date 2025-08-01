package com.dailyfit.utils

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.work.*
import com.dailyfit.app.R
import com.dailyfit.ui.main.MainActivity
import java.util.concurrent.TimeUnit

object NotificationUtils {
    const val WATER_REMINDER_CHANNEL_ID = "water_reminder"
    const val MEAL_REMINDER_CHANNEL_ID = "meal_reminder"
    const val SLEEP_REMINDER_CHANNEL_ID = "sleep_reminder"
    const val WORKOUT_REMINDER_CHANNEL_ID = "workout_reminder"

    fun createNotificationChannels(context: Context) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val notificationManager = context.getSystemService(NotificationManager::class.java)

            val waterChannel = NotificationChannel(
                WATER_REMINDER_CHANNEL_ID,
                "Water Reminders",
                NotificationManager.IMPORTANCE_DEFAULT
            ).apply {
                description = "Reminders to drink water"
            }

            val mealChannel = NotificationChannel(
                MEAL_REMINDER_CHANNEL_ID,
                "Meal Reminders",
                NotificationManager.IMPORTANCE_DEFAULT
            ).apply {
                description = "Reminders for meals"
            }

            val sleepChannel = NotificationChannel(
                SLEEP_REMINDER_CHANNEL_ID,
                "Sleep Reminders",
                NotificationManager.IMPORTANCE_DEFAULT
            ).apply {
                description = "Reminders for sleep"
            }

            val workoutChannel = NotificationChannel(
                WORKOUT_REMINDER_CHANNEL_ID,
                "Workout Reminders",
                NotificationManager.IMPORTANCE_DEFAULT
            ).apply {
                description = "Reminders for workouts"
            }

            notificationManager.createNotificationChannels(
                listOf(waterChannel, mealChannel, sleepChannel, workoutChannel)
            )
        }
    }

    fun scheduleWaterReminder(context: Context, intervalHours: Int = 2) {
        val waterWorkRequest = PeriodicWorkRequestBuilder<WaterReminderWorker>(
            intervalHours.toLong(), TimeUnit.HOURS
        ).build()

        WorkManager.getInstance(context).enqueueUniquePeriodicWork(
            "water_reminder",
            ExistingPeriodicWorkPolicy.REPLACE,
            waterWorkRequest
        )
    }

    fun scheduleMealReminder(context: Context, hour: Int, minute: Int, mealType: String) {
        val mealWorkRequest = OneTimeWorkRequestBuilder<MealReminderWorker>()
            .setInputData(workDataOf("meal_type" to mealType))
            .setInitialDelay(calculateDelay(hour, minute), TimeUnit.MILLISECONDS)
            .build()

        WorkManager.getInstance(context).enqueueUniqueWork(
            "meal_reminder_$mealType",
            ExistingWorkPolicy.REPLACE,
            mealWorkRequest
        )
    }

    fun scheduleSleepReminder(context: Context, hour: Int, minute: Int) {
        val sleepWorkRequest = OneTimeWorkRequestBuilder<SleepReminderWorker>()
            .setInitialDelay(calculateDelay(hour, minute), TimeUnit.MILLISECONDS)
            .build()

        WorkManager.getInstance(context).enqueueUniqueWork(
            "sleep_reminder",
            ExistingWorkPolicy.REPLACE,
            sleepWorkRequest
        )
    }

    fun scheduleWorkoutReminder(context: Context, hour: Int, minute: Int) {
        val workoutWorkRequest = OneTimeWorkRequestBuilder<WorkoutReminderWorker>()
            .setInitialDelay(calculateDelay(hour, minute), TimeUnit.MILLISECONDS)
            .build()

        WorkManager.getInstance(context).enqueueUniqueWork(
            "workout_reminder",
            ExistingWorkPolicy.REPLACE,
            workoutWorkRequest
        )
    }

    private fun calculateDelay(hour: Int, minute: Int): Long {
        val calendar = java.util.Calendar.getInstance()
        val now = calendar.timeInMillis

        calendar.set(java.util.Calendar.HOUR_OF_DAY, hour)
        calendar.set(java.util.Calendar.MINUTE, minute)
        calendar.set(java.util.Calendar.SECOND, 0)

        var targetTime = calendar.timeInMillis
        if (targetTime <= now) {
            targetTime += 24 * 60 * 60 * 1000 // Add 24 hours
        }

        return targetTime - now
    }

    fun showNotification(
        context: Context,
        channelId: String,
        title: String,
        message: String,
        notificationId: Int
    ) {
        val intent = Intent(context, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            context,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val notification = NotificationCompat.Builder(context, channelId)
            .setContentTitle(title)
            .setContentText(message)
            .setSmallIcon(R.drawable.ic_notification)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .build()

        val notificationManager = context.getSystemService(NotificationManager::class.java)
        notificationManager.notify(notificationId, notification)
    }
}