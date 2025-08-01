package com.dailyfit.ui.onboarding

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.viewpager2.widget.ViewPager2
import com.dailyfit.app.R
import com.dailyfit.data.DailyFitDatabase
import com.dailyfit.data.entity.User
import com.dailyfit.ui.main.MainActivity
import com.dailyfit.utils.NotificationUtils
import com.google.android.material.button.MaterialButton
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class OnboardingActivity : AppCompatActivity() {

    private lateinit var viewPager: ViewPager2
    private lateinit var tabLayout: TabLayout
    private lateinit var btnNext: MaterialButton
    private lateinit var btnSkip: MaterialButton

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_onboarding)

        initViews()
        setupViewPager()
        setupButtons()
    }

    private fun initViews() {
        viewPager = findViewById(R.id.viewPager)
        tabLayout = findViewById(R.id.tabLayout)
        btnNext = findViewById(R.id.btnNext)
        btnSkip = findViewById(R.id.btnSkip)
    }

    private fun setupViewPager() {
        val adapter = OnboardingAdapter()
        viewPager.adapter = adapter

        TabLayoutMediator(tabLayout, viewPager) { _, _ ->
            // Tab indicator dots
        }.attach()

        viewPager.registerOnPageChangeCallback(object : ViewPager2.OnPageChangeCallback() {
            override fun onPageSelected(position: Int) {
                updateButtonText(position)
            }
        })
    }

    private fun setupButtons() {
        btnNext.setOnClickListener {
            if (viewPager.currentItem == 2) { // Last page
                createUserAndNavigate()
            } else {
                viewPager.currentItem += 1
            }
        }

        btnSkip.setOnClickListener {
            createUserAndNavigate()
        }
    }

    private fun updateButtonText(position: Int) {
        btnNext.text = if (position == 2) getString(R.string.get_started) else getString(R.string.next)
    }

    private fun createUserAndNavigate() {
        CoroutineScope(Dispatchers.IO).launch {
            val database = DailyFitDatabase.getDatabase(this@OnboardingActivity)
            val userDao = database.userDao()

            // Create default user
            val user = User(
                name = "User",
                dailyWaterGoal = 8,
                dailySleepGoal = 8,
                dailyWorkoutGoal = 30
            )

            val userId = userDao.insertUser(user)

            // Schedule default reminders
            runOnUiThread {
                NotificationUtils.scheduleWaterReminder(this@OnboardingActivity, 2)
                NotificationUtils.scheduleMealReminder(this@OnboardingActivity, 8, 0, "Breakfast")
                NotificationUtils.scheduleMealReminder(this@OnboardingActivity, 12, 0, "Lunch")
                NotificationUtils.scheduleMealReminder(this@OnboardingActivity, 19, 0, "Dinner")
                NotificationUtils.scheduleSleepReminder(this@OnboardingActivity, 22, 0)
                NotificationUtils.scheduleWorkoutReminder(this@OnboardingActivity, 7, 0)

                val intent = Intent(this@OnboardingActivity, MainActivity::class.java)
                startActivity(intent)
                finish()
            }
        }
    }
}