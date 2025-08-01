package com.dailyfit.ui.dashboard.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.dailyfit.data.DailyFitDatabase
import com.dailyfit.data.entity.User
import com.dailyfit.data.entity.WaterIntake
import com.dailyfit.utils.DateUtils
import kotlinx.coroutines.launch
import java.util.*

class DashboardViewModel(private val database: DailyFitDatabase) : ViewModel() {

    private val _dailySummary = MutableLiveData<DashboardFragment.DailySummary>()
    val dailySummary: LiveData<DashboardFragment.DailySummary> = _dailySummary

    private val _currentUser = MutableLiveData<User>()
    val currentUser: LiveData<User> = _currentUser

    init {
        loadCurrentUser()
        loadDailySummary()
    }

    private fun loadCurrentUser() {
        viewModelScope.launch {
            val user = database.userDao().getFirstUser().first()
            _currentUser.value = user
        }
    }

    private fun loadDailySummary() {
        viewModelScope.launch {
            val user = _currentUser.value ?: return@launch
            val today = DateUtils.getTodayStart()

            // Load water intake
            val waterIntake = database.waterIntakeDao()
                .getTotalWaterIntakeForDate(user.id, today).first() ?: 0

            // Load workout duration
            val workoutDuration = database.workoutDao()
                .getTotalWorkoutDurationForDate(user.id, today).first() ?: 0

            // Load sleep data
            val sleepData = database.sleepDao().getSleepByDate(user.id, today).first()
            val sleepDuration = sleepData.firstOrNull()?.duration ?: 0f

            // Load meals count
            val meals = database.mealDao().getMealsByDate(user.id, today).first()
            val mealsLogged = meals.size

            val summary = DashboardFragment.DailySummary(
                waterIntake = waterIntake,
                waterGoal = user.dailyWaterGoal * 250, // Convert glasses to ml
                workoutDuration = workoutDuration,
                workoutGoal = user.dailyWorkoutGoal,
                sleepDuration = sleepDuration,
                sleepGoal = user.dailySleepGoal.toFloat(),
                mealsLogged = mealsLogged
            )

            _dailySummary.value = summary
        }
    }

    fun addWaterIntake() {
        viewModelScope.launch {
            val user = _currentUser.value ?: return@launch
            
            val waterIntake = WaterIntake(
                userId = user.id,
                amount = 250 // One glass
            )
            
            database.waterIntakeDao().insertWaterIntake(waterIntake)
            loadDailySummary() // Refresh data
        }
    }

    fun refreshData() {
        loadDailySummary()
    }
}