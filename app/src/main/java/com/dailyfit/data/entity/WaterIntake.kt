package com.dailyfit.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "water_intake")
data class WaterIntake(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,
    val userId: Long,
    val amount: Int, // ml
    val date: Long = System.currentTimeMillis(),
    val createdAt: Long = System.currentTimeMillis()
)