package com.example.application_management

import android.annotation.TargetApi
import android.app.Activity
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class ApplicationManagementPlugin(activity: Activity) : MethodCallHandler {

    private var activity = activity
    private var packageManager: PackageManager

    init {
        packageManager = this.activity.getPackageManager()
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "application_management")
            channel.setMethodCallHandler(ApplicationManagementPlugin(registrar.activity()))
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "openApp" -> result.success(openApp(call.argument<String>("openKeyStr")!!))
            "openInAppStore" -> result.success(openInAppStore(call.argument<String>("appKey")!!))
            "getInstalledPackageNameList" -> result.success(getInstalledPackageNameList())
            "isInstalled" -> result.success(isInstalled(call.argument<String>("appKey")!!))
            "isInstalledList" -> result.success(isInstalledList(call.argument<List<String>>("appKeyList")!!))
            else -> result.notImplemented()
        }
    }

    // TODO remove this annotation, set in config file.
    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    private fun openApp(appKey: String): Boolean {
        val intent = packageManager.getLaunchIntentForPackage(appKey)
        if (intent != null) {
            this.activity.startActivity(intent)
        }

        return true
    }

    private fun openInAppStore(appKey: String): Boolean {
        return true;
    }

    private fun getInstalledPackageNameList(): List<String> {
        var installAppList = packageManager.getInstalledPackages(PackageManager.GET_ACTIVITIES)
        return installAppList.map<PackageInfo, String> { it.packageName }
    }

    private fun isInstalled(packageName: String): Boolean {
        var installAppPackageNameList = getInstalledPackageNameList()
        return installAppPackageNameList.contains(packageName)
    }

    private fun isInstalledList(packageNameList: List<String>): List<Boolean> {
        var installAppPackageNameList = getInstalledPackageNameList();
        return packageNameList.map<String, Boolean> { installAppPackageNameList.contains(it) }
    }
}
