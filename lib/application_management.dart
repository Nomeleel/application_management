import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('application_management');

/// Open other app with special strings.
/// The [openKeyStr] for [Android] is package name, for [Ios] is url scheme.
Future<bool> openApp(String openKeyStr) async {
  if (openKeyStr == null || openKeyStr.isEmpty) {
    return false;
  }

  final bool isOpenApp = await _channel.invokeMethod('openApp', openKeyStr);
  return isOpenApp;
}

/// Open the details page for the app in the [App Store] or [Market].
/// The [appKey] for [Android] is package name, for [Ios] is bundle id.
Future<bool> openInAppStore(String appKey) async {
  if (appKey == null || appKey.isEmpty) {
    return false;
  }

  final bool isOpenInAppStore = await _channel.invokeMethod('openInAppStore', appKey);
  return isOpenInAppStore;
}

/// Open the details page for the app in the Specify [Market].
/// The [packageName] is package name for [Android].
/// If Specify [Market] does not exist, the details page
/// for the specify [Market] will open in the system default app store.
Future<bool> openInSpecifyAppStore(String packageName,
    String specifyAppStorePackageName, String specifyAppStoreClassName) async {
  if (Platform.isIOS) {
    throw UnsupportedError('Functionality not support on Ios');
  }

  Map<String, Object> argumentMap = {
    "packageName": packageName,
    "specifyAppStorePackageName": specifyAppStorePackageName,
    "specifyAppStoreClassName": specifyAppStoreClassName,
  };
  final bool isOpenInSpecifyAppStore = await _channel.invokeMethod('openInSpecifyAppStore', argumentMap);
  return isOpenInSpecifyAppStore;
}

/// For [Android] can get current device installed all app list.
/// This will only get app [package name] list.
Future<List<String>> getInstalledPackageNameList() async {
  if (Platform.isIOS) {
    throw UnsupportedError('Functionality not support on Ios');
  }

  final List<String> packageNameList =
      await _channel.invokeListMethod('getInstalledPackageNameList');

  return packageNameList;
}

/// Check the current device whether installed special app.
/// The [appKey] for [Android] is package name.
/// Note: for [Ios] is url scheme.
Future<bool> isInstalled(String appKey) async {
  if (appKey == null || appKey.isEmpty) {
    return false;
  }

  final bool isInstalled = await _channel.invokeMethod<bool>('isInstalled', appKey);

  return isInstalled;
}

/// Can use this method if you want to check if multiple apps are installed at once.
/// For more information, see [isInstalled] function.
Future<Map<String, bool>> isInstalledMap(List<String> appKeyList) async {
  final Map<String, bool> isInstalledMap =
      await _channel.invokeMapMethod<String, bool>('isInstalledMap', appKeyList);

  return isInstalledMap;
}
