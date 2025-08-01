package com.dailyfit.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "users")
data class User(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,
    val name: String,
    val email: String? = null,
    val dailyWaterGoal: Int = 8, // glasses
    val dailySleepGoal: Int = 8, // hours
    val dailyWorkoutGoal: Int = 30, // minutes
    val isDarkMode: Boolean = false,
    val notificationsEnabled: Boolean = true,
    val waterReminderInterval: Int = 2, // hours
    val createdAt: Long = System.currentTimeMillis()
)