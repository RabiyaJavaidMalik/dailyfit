package com.dailyfit.data.dao

import androidx.room.*
import com.dailyfit.data.entity.Workout
import kotlinx.coroutines.flow.Flow
import java.util.*

@Dao
interface WorkoutDao {
    @Query("SELECT * FROM workouts WHERE userId = :userId AND date >= :startDate AND date <= :endDate ORDER BY date DESC")
    fun getWorkoutsByDateRange(userId: Long, startDate: Long, endDate: Long): Flow<List<Workout>>

    @Query("SELECT * FROM workouts WHERE userId = :userId AND date = :date ORDER BY createdAt DESC")
    fun getWorkoutsByDate(userId: Long, date: Long): Flow<List<Workout>>

    @Query("SELECT SUM(duration) FROM workouts WHERE userId = :userId AND date = :date")
    fun getTotalWorkoutDurationForDate(userId: Long, date: Long): Flow<Int?>

    @Query("SELECT * FROM workouts WHERE userId = :userId ORDER BY date DESC LIMIT :limit")
    fun getRecentWorkouts(userId: Long, limit: Int = 10): Flow<List<Workout>>

    @Insert
    suspend fun insertWorkout(workout: Workout): Long

    @Update
    suspend fun updateWorkout(workout: Workout)

    @Delete
    suspend fun deleteWorkout(workout: Workout)

    @Query("DELETE FROM workouts WHERE userId = :userId")
    suspend fun deleteAllWorkoutsForUser(userId: Long)
}