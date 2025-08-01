package com.dailyfit.ui.splash

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import androidx.appcompat.app.AppCompatActivity
import com.dailyfit.app.R
import com.dailyfit.ui.onboarding.OnboardingActivity
import com.dailyfit.ui.main.MainActivity
import com.dailyfit.data.DailyFitDatabase
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class SplashActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        // Check if user exists and navigate accordingly
        Handler(Looper.getMainLooper()).postDelayed({
            checkUserAndNavigate()
        }, 2000) // 2 seconds delay
    }

    private fun checkUserAndNavigate() {
        CoroutineScope(Dispatchers.IO).launch {
            val database = DailyFitDatabase.getDatabase(this@SplashActivity)
            val userDao = database.userDao()
            
            val user = userDao.getFirstUser().first()
            
            runOnUiThread {
                val intent = if (user != null) {
                    Intent(this@SplashActivity, MainActivity::class.java)
                } else {
                    Intent(this@SplashActivity, OnboardingActivity::class.java)
                }
                startActivity(intent)
                finish()
            }
        }
    }
}