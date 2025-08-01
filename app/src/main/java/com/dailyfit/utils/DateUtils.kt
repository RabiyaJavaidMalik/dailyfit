package com.dailyfit.utils

import java.text.SimpleDateFormat
import java.util.*

object DateUtils {
    private val dateFormat = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
    private val timeFormat = SimpleDateFormat("HH:mm", Locale.getDefault())
    private val dateTimeFormat = SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.getDefault())

    fun getStartOfDay(timestamp: Long): Long {
        val calendar = Calendar.getInstance()
        calendar.timeInMillis = timestamp
        calendar.set(Calendar.HOUR_OF_DAY, 0)
        calendar.set(Calendar.MINUTE, 0)
        calendar.set(Calendar.SECOND, 0)
        calendar.set(Calendar.MILLISECOND, 0)
        return calendar.timeInMillis
    }

    fun getEndOfDay(timestamp: Long): Long {
        val calendar = Calendar.getInstance()
        calendar.timeInMillis = timestamp
        calendar.set(Calendar.HOUR_OF_DAY, 23)
        calendar.set(Calendar.MINUTE, 59)
        calendar.set(Calendar.SECOND, 59)
        calendar.set(Calendar.MILLISECOND, 999)
        return calendar.timeInMillis
    }

    fun getTodayStart(): Long {
        return getStartOfDay(System.currentTimeMillis())
    }

    fun getTodayEnd(): Long {
        return getEndOfDay(System.currentTimeMillis())
    }

    fun getDateString(timestamp: Long): String {
        return dateFormat.format(Date(timestamp))
    }

    fun getTimeString(timestamp: Long): String {
        return timeFormat.format(Date(timestamp))
    }

    fun getDateTimeString(timestamp: Long): String {
        return dateTimeFormat.format(Date(timestamp))
    }

    fun getDaysAgo(days: Int): Long {
        val calendar = Calendar.getInstance()
        calendar.add(Calendar.DAY_OF_YEAR, -days)
        return getStartOfDay(calendar.timeInMillis)
    }

    fun getWeeksAgo(weeks: Int): Long {
        val calendar = Calendar.getInstance()
        calendar.add(Calendar.WEEK_OF_YEAR, -weeks)
        return getStartOfDay(calendar.timeInMillis)
    }

    fun getMonthsAgo(months: Int): Long {
        val calendar = Calendar.getInstance()
        calendar.add(Calendar.MONTH, -months)
        return getStartOfDay(calendar.timeInMillis)
    }

    fun isToday(timestamp: Long): Boolean {
        val today = getTodayStart()
        val dayStart = getStartOfDay(timestamp)
        return today == dayStart
    }

    fun isYesterday(timestamp: Long): Boolean {
        val yesterday = getDaysAgo(1)
        val dayStart = getStartOfDay(timestamp)
        return yesterday == dayStart
    }

    fun formatDuration(minutes: Int): String {
        val hours = minutes / 60
        val mins = minutes % 60
        return if (hours > 0) {
            "$hours hr ${mins} min"
        } else {
            "${mins} min"
        }
    }

    fun calculateSleepDuration(sleepTime: Long, wakeTime: Long): Float {
        val durationMs = wakeTime - sleepTime
        return durationMs / (1000f * 60f * 60f) // Convert to hours
    }
}