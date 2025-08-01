package com.dailyfit.data.dao

import androidx.room.*
import com.dailyfit.data.entity.Sleep
import kotlinx.coroutines.flow.Flow

@Dao
interface SleepDao {
    @Query("SELECT * FROM sleep WHERE userId = :userId AND date = :date ORDER BY createdAt DESC")
    fun getSleepByDate(userId: Long, date: Long): Flow<List<Sleep>>

    @Query("SELECT * FROM sleep WHERE userId = :userId ORDER BY date DESC LIMIT :limit")
    fun getRecentSleep(userId: Long, limit: Int = 10): Flow<List<Sleep>>

    @Query("SELECT AVG(duration) FROM sleep WHERE userId = :userId AND date >= :startDate AND date <= :endDate")
    fun getAverageSleepDuration(userId: Long, startDate: Long, endDate: Long): Flow<Float?>

    @Insert
    suspend fun insertSleep(sleep: Sleep): Long

    @Update
    suspend fun updateSleep(sleep: Sleep)

    @Delete
    suspend fun deleteSleep(sleep: Sleep)

    @Query("DELETE FROM sleep WHERE userId = :userId")
    suspend fun deleteAllSleepForUser(userId: Long)
}