package com.dailyfit.data.repository

import com.dailyfit.data.DailyFitDatabase
import com.dailyfit.data.entity.WaterIntake
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class WaterIntakeRepository @Inject constructor(
    private val database: DailyFitDatabase
) {
    private val waterIntakeDao = database.waterIntakeDao()

    fun getWaterIntakeByDate(userId: Long, date: Long): Flow<List<WaterIntake>> {
        return waterIntakeDao.getWaterIntakeByDate(userId, date)
    }

    fun getTotalWaterIntakeForDate(userId: Long, date: Long): Flow<Int?> {
        return waterIntakeDao.getTotalWaterIntakeForDate(userId, date)
    }

    fun getRecentWaterIntake(userId: Long, limit: Int = 10): Flow<List<WaterIntake>> {
        return waterIntakeDao.getRecentWaterIntake(userId, limit)
    }

    suspend fun addWaterIntake(waterIntake: WaterIntake): Long {
        return waterIntakeDao.insertWaterIntake(waterIntake)
    }

    suspend fun updateWaterIntake(waterIntake: WaterIntake) {
        waterIntakeDao.updateWaterIntake(waterIntake)
    }

    suspend fun deleteWaterIntake(waterIntake: WaterIntake) {
        waterIntakeDao.deleteWaterIntake(waterIntake)
    }

    suspend fun deleteAllWaterIntakeForUser(userId: Long) {
        waterIntakeDao.deleteAllWaterIntakeForUser(userId)
    }
}