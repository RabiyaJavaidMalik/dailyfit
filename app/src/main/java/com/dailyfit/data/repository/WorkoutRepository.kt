package com.dailyfit.data.repository

import com.dailyfit.data.DailyFitDatabase
import com.dailyfit.data.entity.Workout
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class WorkoutRepository @Inject constructor(
    private val database: DailyFitDatabase
) {
    private val workoutDao = database.workoutDao()

    fun getWorkoutsByDateRange(userId: Long, startDate: Long, endDate: Long): Flow<List<Workout>> {
        return workoutDao.getWorkoutsByDateRange(userId, startDate, endDate)
    }

    fun getWorkoutsByDate(userId: Long, date: Long): Flow<List<Workout>> {
        return workoutDao.getWorkoutsByDate(userId, date)
    }

    fun getTotalWorkoutDurationForDate(userId: Long, date: Long): Flow<Int?> {
        return workoutDao.getTotalWorkoutDurationForDate(userId, date)
    }

    fun getRecentWorkouts(userId: Long, limit: Int = 10): Flow<List<Workout>> {
        return workoutDao.getRecentWorkouts(userId, limit)
    }

    suspend fun addWorkout(workout: Workout): Long {
        return workoutDao.insertWorkout(workout)
    }

    suspend fun updateWorkout(workout: Workout) {
        workoutDao.updateWorkout(workout)
    }

    suspend fun deleteWorkout(workout: Workout) {
        workoutDao.deleteWorkout(workout)
    }

    suspend fun deleteAllWorkoutsForUser(userId: Long) {
        workoutDao.deleteAllWorkoutsForUser(userId)
    }
}