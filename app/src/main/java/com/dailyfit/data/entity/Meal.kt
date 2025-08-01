package com.dailyfit.data.entity

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "meals")
data class Meal(
    @PrimaryKey(autoGenerate = true)
    val id: Long = 0,
    val userId: Long,
    val type: String, // Breakfast, Lunch, Dinner, Snack
    val foodName: String,
    val quantity: String? = null,
    val calories: Int? = null,
    val photoPath: String? = null,
    val date: Long = System.currentTimeMillis(),
    val createdAt: Long = System.currentTimeMillis()
)