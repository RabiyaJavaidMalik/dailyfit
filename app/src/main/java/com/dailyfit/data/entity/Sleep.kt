package com.dailyfit.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "sleep")
data class Sleep(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,
    val userId: Long,
    val sleepTime: Long, // timestamp
    val wakeTime: Long, // timestamp
    val duration: Float, // hours
    val quality: Int? = null, // 1-5 rating
    val notes: String? = null,
    val date: Long = System.currentTimeMillis(),
    val createdAt: Long = System.currentTimeMillis()
)