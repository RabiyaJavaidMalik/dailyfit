package com.dailyfit.data.dao

import androidx.room.*
import com.dailyfit.data.entity.Meal
import kotlinx.coroutines.flow.Flow

@Dao
interface MealDao {
    @Query("SELECT * FROM meals WHERE userId = :userId AND date = :date ORDER BY createdAt DESC")
    fun getMealsByDate(userId: Long, date: Long): Flow<List<Meal>>

    @Query("SELECT * FROM meals WHERE userId = :userId AND type = :mealType AND date = :date ORDER BY createdAt DESC")
    fun getMealsByTypeAndDate(userId: Long, mealType: String, date: Long): Flow<List<Meal>>

    @Query("SELECT SUM(calories) FROM meals WHERE userId = :userId AND date = :date")
    fun getTotalCaloriesForDate(userId: Long, date: Long): Flow<Int?>

    @Query("SELECT * FROM meals WHERE userId = :userId ORDER BY date DESC LIMIT :limit")
    fun getRecentMeals(userId: Long, limit: Int = 10): Flow<List<Meal>>

    @Insert
    suspend fun insertMeal(meal: Meal): Long

    @Update
    suspend fun updateMeal(meal: Meal)

    @Delete
    suspend fun deleteMeal(meal: Meal)

    @Query("DELETE FROM meals WHERE userId = :userId")
    suspend fun deleteAllMealsForUser(userId: Long)
}