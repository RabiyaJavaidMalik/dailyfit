package com.dailyfit.data.repository

import com.dailyfit.data.DailyFitDatabase
import com.dailyfit.data.entity.Meal
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class MealRepository @Inject constructor(
    private val database: DailyFitDatabase
) {
    private val mealDao = database.mealDao()

    fun getMealsByDate(userId: Long, date: Long): Flow<List<Meal>> {
        return mealDao.getMealsByDate(userId, date)
    }

    fun getMealsByTypeAndDate(userId: Long, mealType: String, date: Long): Flow<List<Meal>> {
        return mealDao.getMealsByTypeAndDate(userId, mealType, date)
    }

    fun getTotalCaloriesForDate(userId: Long, date: Long): Flow<Int?> {
        return mealDao.getTotalCaloriesForDate(userId, date)
    }

    fun getRecentMeals(userId: Long, limit: Int = 10): Flow<List<Meal>> {
        return mealDao.getRecentMeals(userId, limit)
    }

    suspend fun addMeal(meal: Meal): Long {
        return mealDao.insertMeal(meal)
    }

    suspend fun updateMeal(meal: Meal) {
        mealDao.updateMeal(meal)
    }

    suspend fun deleteMeal(meal: Meal) {
        mealDao.deleteMeal(meal)
    }

    suspend fun deleteAllMealsForUser(userId: Long) {
        mealDao.deleteAllMealsForUser(userId)
    }
}