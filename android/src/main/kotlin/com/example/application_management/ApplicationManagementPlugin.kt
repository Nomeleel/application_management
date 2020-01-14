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
import android.content.Intent
import android.net.Uri


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
            "openInSpecifyAppStore" -> result.success(openInSpecifyAppStore(
                    call.argument<String>("packageName")!!,
                    call.argument<String>("specifyAppStorePackageName")!!,
                    call.argument<String>("specifyAppStoreClassName")!!))
            "getInstalledPackageNameList" -> result.success(getInstalledPackageNameList())
            "isInstalled" -> result.success(isInstalled(call.argument<String>("appKey")!!))
            "isInstalledList" -> result.success(isInstalledList(call.argument<List<String>>("appKeyList")!!))
            else -> result.notImplemented()
        }
    }

    // TODO remove this annotation, set in config file.
    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    private fun openApp(packageName: String): Boolean {
        val intent = packageManager.getLaunchIntentForPackage(packageName)
        if (intent != null) {
            this.activity.startActivity(intent)
        }

        return true
    }

    private fun openInAppStore(packageName: String): Boolean {
        val uri = Uri.parse("market://details?id=$packageName")
        val marketIntent = Intent(Intent.ACTION_VIEW, uri)
        marketIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        this.activity.startActivity(marketIntent)
        return true;
    }

    private fun openInSpecifyAppStore(packageName: String, specifyAppStorePackageName: String,
                                      specifyAppStoreClassName: String): Boolean {
        var isInstalledSpecifyAppStore = isInstalled(specifyAppStorePackageName);
        val uri = Uri.parse(String.format("market://details?id=" +
                "${if(isInstalledSpecifyAppStore) packageName else specifyAppStorePackageName}"))
        val marketIntent = Intent(Intent.ACTION_VIEW, uri)
        if (isInstalledSpecifyAppStore) {
            marketIntent.setClassName(specifyAppStorePackageName, specifyAppStoreClassName);
        }
        marketIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        this.activity.startActivity(marketIntent)
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
