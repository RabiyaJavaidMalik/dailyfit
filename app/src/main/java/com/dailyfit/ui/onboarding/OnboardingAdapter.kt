package com.dailyfit.ui.onboarding

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.dailyfit.app.R

class OnboardingAdapter : RecyclerView.Adapter<OnboardingAdapter.OnboardingViewHolder>() {

    private val onboardingItems = listOf(
        OnboardingItem(
            R.drawable.ic_workout,
            "Track Your Fitness",
            "Log your workouts, track progress, and stay motivated with your fitness journey."
        ),
        OnboardingItem(
            R.drawable.ic_water,
            "Stay Hydrated",
            "Monitor your daily water intake and get reminders to stay hydrated throughout the day."
        ),
        OnboardingItem(
            R.drawable.ic_sleep,
            "Monitor Wellness",
            "Track your meals, sleep patterns, and overall wellness to build healthy habits."
        )
    )

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): OnboardingViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_onboarding, parent, false)
        return OnboardingViewHolder(view)
    }

    override fun onBindViewHolder(holder: OnboardingViewHolder, position: Int) {
        holder.bind(onboardingItems[position])
    }

    override fun getItemCount(): Int = onboardingItems.size

    class OnboardingViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        private val ivIcon: ImageView = itemView.findViewById(R.id.ivIcon)
        private val tvTitle: TextView = itemView.findViewById(R.id.tvTitle)
        private val tvDescription: TextView = itemView.findViewById(R.id.tvDescription)

        fun bind(item: OnboardingItem) {
            ivIcon.setImageResource(item.iconRes)
            tvTitle.text = item.title
            tvDescription.text = item.description
        }
    }

    data class OnboardingItem(
        val iconRes: Int,
        val title: String,
        val description: String
    )
}