package com.dailyfit.data.dao

import androidx.room.*
import com.dailyfit.data.entity.WaterIntake
import kotlinx.coroutines.flow.Flow

@Dao
interface WaterIntakeDao {
    @Query("SELECT * FROM water_intake WHERE userId = :userId AND date = :date ORDER BY createdAt DESC")
    fun getWaterIntakeByDate(userId: Long, date: Long): Flow<List<WaterIntake>>

    @Query("SELECT SUM(amount) FROM water_intake WHERE userId = :userId AND date = :date")
    fun getTotalWaterIntakeForDate(userId: Long, date: Long): Flow<Int?>

    @Query("SELECT * FROM water_intake WHERE userId = :userId ORDER BY date DESC LIMIT :limit")
    fun getRecentWaterIntake(userId: Long, limit: Int = 10): Flow<List<WaterIntake>>

    @Insert
    suspend fun insertWaterIntake(waterIntake: WaterIntake): Long

    @Update
    suspend fun updateWaterIntake(waterIntake: WaterIntake)

    @Delete
    suspend fun deleteWaterIntake(waterIntake: WaterIntake)

    @Query("DELETE FROM water_intake WHERE userId = :userId")
    suspend fun deleteAllWaterIntakeForUser(userId: Long)
}