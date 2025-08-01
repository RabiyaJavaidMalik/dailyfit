package com.dailyfit.ui.dashboard

import android.app.Dialog
import android.os.Bundle
import androidx.fragment.app.DialogFragment
import com.dailyfit.app.R

class WorkoutDialogFragment : DialogFragment() {

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        return Dialog(requireContext()).apply {
            setContentView(R.layout.dialog_workout)
            setTitle(R.string.log_workout)
        }
    }
}