package com.dailyfit.data.repository

import com.dailyfit.data.DailyFitDatabase
import com.dailyfit.data.entity.Sleep
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class SleepRepository @Inject constructor(
    private val database: DailyFitDatabase
) {
    private val sleepDao = database.sleepDao()

    fun getSleepByDate(userId: Long, date: Long): Flow<List<Sleep>> {
        return sleepDao.getSleepByDate(userId, date)
    }

    fun getRecentSleep(userId: Long, limit: Int = 10): Flow<List<Sleep>> {
        return sleepDao.getRecentSleep(userId, limit)
    }

    fun getAverageSleepDuration(userId: Long, startDate: Long, endDate: Long): Flow<Float?> {
        return sleepDao.getAverageSleepDuration(userId, startDate, endDate)
    }

    suspend fun addSleep(sleep: Sleep): Long {
        return sleepDao.insertSleep(sleep)
    }

    suspend fun updateSleep(sleep: Sleep) {
        sleepDao.updateSleep(sleep)
    }

    suspend fun deleteSleep(sleep: Sleep) {
        sleepDao.deleteSleep(sleep)
    }

    suspend fun deleteAllSleepForUser(userId: Long) {
        sleepDao.deleteAllSleepForUser(userId)
    }
}