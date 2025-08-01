package com.dailyfit.utils.workers

import android.content.Context
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import com.dailyfit.utils.NotificationUtils

class MealReminderWorker(
    context: Context,
    params: WorkerParameters
) : CoroutineWorker(context, params) {

    override suspend fun doWork(): Result {
        val mealType = inputData.getString("meal_type") ?: "meal"
        val title = when (mealType.lowercase()) {
            "breakfast" -> "Breakfast Time! 🍳"
            "lunch" -> "Lunch Time! 🍽️"
            "dinner" -> "Dinner Time! 🍴"
            "snack" -> "Snack Time! 🍎"
            else -> "Meal Time! 🍽️"
        }
        
        val message = when (mealType.lowercase()) {
            "breakfast" -> "Time to fuel your day with a healthy breakfast"
            "lunch" -> "Don't forget to log your lunch"
            "dinner" -> "Time for dinner - remember to log your meal"
            "snack" -> "Time for a healthy snack"
            else -> "Don't forget to log your meal"
        }

        NotificationUtils.showNotification(
            applicationContext,
            NotificationUtils.MEAL_REMINDER_CHANNEL_ID,
            title,
            message,
            1002
        )
        return Result.success()
    }
}