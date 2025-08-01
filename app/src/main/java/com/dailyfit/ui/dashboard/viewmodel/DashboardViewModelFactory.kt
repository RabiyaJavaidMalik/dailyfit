package com.dailyfit.ui.dashboard.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.dailyfit.data.DailyFitDatabase

class DashboardViewModelFactory(private val database: DailyFitDatabase) : ViewModelProvider.Factory {
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(DashboardViewModel::class.java)) {
            @Suppress("UNCHECKED_CAST")
            return DashboardViewModel(database) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}