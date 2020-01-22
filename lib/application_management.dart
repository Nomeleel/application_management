import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:platform/platform.dart';

const MethodChannel _channel = MethodChannel('application_management');

const Platform _platform = const LocalPlatform();

/// Open other app with special strings.
/// The [openKeyStr] for [Android] is package name, for [Ios] is url scheme.
void openApp(String openKeyStr) {
  Map<String, Object> argumentMap = {"openKeyStr": openKeyStr};
  _channel.invokeMethod('openApp', argumentMap);
}

/// Open the details page for the app in the [App Store] or [Market].
/// The [appKey] for [Android] is package name, for [Ios] is bundle id.
void openInAppStore(String appKey) async {
  Map<String, Object> argumentMap = {"appKey": appKey};
  await _channel.invokeMethod('openInAppStore', argumentMap);
}

/// Open the details page for the app in the Specify [Market].
/// The [packageName] is package name for [Android].
/// If Specify [Market] does not exist, the details page
/// for the specify [Market] will open in the system default app store.
void openInSpecifyAppStore(String packageName,
    String specifyAppStorePackageName, String specifyAppStoreClassName) async {
  if (_platform.isIOS) {
    throw UnsupportedError('Functionality not support on Ios');
  }

  Map<String, Object> argumentMap = {
    "packageName": packageName,
    "specifyAppStorePackageName": specifyAppStorePackageName,
    "specifyAppStoreClassName": specifyAppStoreClassName,
  };
  await _channel.invokeMethod('openInSpecifyAppStore', argumentMap);
}

/// For [Android] can get current device installed all app list.
/// This will only get app [package name] list.
Future<List<String>> getInstalledPackageNameList() async {
  if (_platform.isIOS) {
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
  Map<String, Object> argumentMap = {"appKey": appKey};

  final bool isInstalled = await _channel.invokeMethod<bool>('isInstalled', argumentMap);

  return isInstalled;
}

/// Can use this method if you want to check if multiple apps are installed at once.
/// For more information, see [isInstalled] function.
Future<Map<String, bool>> isInstalledList(List<String> appKeyList) async {
  Map<String, Object> argumentMap = {"appKeyList": appKeyList};

  final Map<String, bool> isInstalledMap =
      await _channel.invokeMapMethod<String, bool>('isInstalledMap', argumentMap);

  return isInstalledMap;
}
