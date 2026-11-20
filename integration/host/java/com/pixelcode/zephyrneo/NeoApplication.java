package com.pixelcode.zephyrneo;

import com.rfandango.haku_x.data.Logs;

public final class NeoApplication extends xendroid.compose.Application {
    @Override
    public void onCreate() {
        // The original Xbox core has a separate process and its own Vulkan driver.
        if (getProcessName().equals(getPackageName() + ":native")) {
            return;
        }
        super.onCreate();
        if (getProcessName().equals(getPackageName())) {
            Logs.INSTANCE.startApp(this);
        }
    }
}
