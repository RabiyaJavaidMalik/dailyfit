package com.dailyfit.ui.dashboard

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModelProvider
import com.dailyfit.app.R
import com.dailyfit.data.DailyFitDatabase
import com.dailyfit.ui.dashboard.viewmodel.DashboardViewModel
import com.dailyfit.ui.dashboard.viewmodel.DashboardViewModelFactory
import com.google.android.material.card.MaterialCardView

class DashboardFragment : Fragment() {

    private lateinit var viewModel: DashboardViewModel

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_dashboard, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val database = DailyFitDatabase.getDatabase(requireContext())
        val factory = DashboardViewModelFactory(database)
        viewModel = ViewModelProvider(this, factory)[DashboardViewModel::class.java]

        setupQuickActions()
        observeData()
    }

    private fun setupQuickActions() {
        view?.findViewById<MaterialCardView>(R.id.cardWorkout)?.setOnClickListener {
            // Navigate to workout logging
            showWorkoutDialog()
        }

        view?.findViewById<MaterialCardView>(R.id.cardWater)?.setOnClickListener {
            // Add water intake
            viewModel.addWaterIntake()
        }

        view?.findViewById<MaterialCardView>(R.id.cardMeal)?.setOnClickListener {
            // Navigate to meal logging
            showMealDialog()
        }

        view?.findViewById<MaterialCardView>(R.id.cardSleep)?.setOnClickListener {
            // Navigate to sleep logging
            showSleepDialog()
        }
    }

    private fun observeData() {
        viewModel.dailySummary.observe(viewLifecycleOwner) { summary ->
            // Update UI with daily summary
            updateDailySummary(summary)
        }
    }

    private fun updateDailySummary(summary: DailySummary) {
        // Update progress bars and text views
        view?.findViewById<android.widget.ProgressBar>(R.id.progressWater)?.progress = 
            ((summary.waterIntake / summary.waterGoal.toFloat()) * 100).toInt()
        
        view?.findViewById<android.widget.ProgressBar>(R.id.progressWorkout)?.progress = 
            ((summary.workoutDuration / summary.workoutGoal.toFloat()) * 100).toInt()
        
        view?.findViewById<android.widget.ProgressBar>(R.id.progressSleep)?.progress = 
            ((summary.sleepDuration / summary.sleepGoal.toFloat()) * 100).toInt()
    }

    private fun showWorkoutDialog() {
        // Show workout logging dialog
        WorkoutDialogFragment().show(childFragmentManager, "workout_dialog")
    }

    private fun showMealDialog() {
        // Show meal logging dialog
        MealDialogFragment().show(childFragmentManager, "meal_dialog")
    }

    private fun showSleepDialog() {
        // Show sleep logging dialog
        SleepDialogFragment().show(childFragmentManager, "sleep_dialog")
    }

    data class DailySummary(
        val waterIntake: Int,
        val waterGoal: Int,
        val workoutDuration: Int,
        val workoutGoal: Int,
        val sleepDuration: Float,
        val sleepGoal: Float,
        val mealsLogged: Int
    )
}