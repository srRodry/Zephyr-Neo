package com.pixelcode.zephyrneo;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Gravity;
import android.widget.Button;
import android.widget.LinearLayout;

import com.rfandango.haku_x.LauncherActivity;
import com.rfandango.haku_x.R;

public final class ConsoleActivity extends Activity {
    @Override
    protected void onCreate(Bundle state) {
        super.onCreate(state);
        LinearLayout consoles = new LinearLayout(this);
        consoles.setOrientation(LinearLayout.VERTICAL);
        consoles.setGravity(Gravity.CENTER);
        int padding = Math.round(24 * getResources().getDisplayMetrics().density);
        consoles.setPadding(padding, padding, padding, padding);
        addConsole(consoles, R.string.neo_open_original, LauncherActivity.class);
        addConsole(consoles, R.string.neo_open_360, xendroid.compose.MainActivity.class);
        setContentView(consoles);
    }

    private void addConsole(LinearLayout consoles, int label, Class<? extends Activity> activity) {
        Button button = new Button(this);
        button.setText(label);
        button.setOnClickListener(view -> startActivity(new Intent(this, activity)));
        consoles.addView(button);
    }
}
