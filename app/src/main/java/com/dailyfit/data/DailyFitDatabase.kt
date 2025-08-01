package com.dailyfit.data

import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import android.content.Context
import com.dailyfit.data.dao.*
import com.dailyfit.data.entity.*

@Database(
    entities = [
        User::class,
        Workout::class,
        WaterIntake::class,
        Meal::class,
        Sleep::class
    ],
    version = 1,
    exportSchema = false
)
abstract class DailyFitDatabase : RoomDatabase() {
    abstract fun userDao(): UserDao
    abstract fun workoutDao(): WorkoutDao
    abstract fun waterIntakeDao(): WaterIntakeDao
    abstract fun mealDao(): MealDao
    abstract fun sleepDao(): SleepDao

    companion object {
        @Volatile
        private var INSTANCE: DailyFitDatabase? = null

        fun getDatabase(context: Context): DailyFitDatabase {
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context.applicationContext,
                    DailyFitDatabase::class.java,
                    "dailyfit_database"
                ).build()
                INSTANCE = instance
                instance
            }
        }
    }
}