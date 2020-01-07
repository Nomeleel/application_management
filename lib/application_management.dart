import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:platform/platform.dart';

const MethodChannel _channel = MethodChannel('application_management');

const Platform _platform = const LocalPlatform();

///
///
void openApp(String key){
  Map<String, Object> argumentMap = {"appKey": key};
  _channel.invokeMethod('openApp', argumentMap);
}

///
///
void openInAppStore(String key) async{
  Map<String, Object> argumentMap = {"appKey": key};
  await _channel.invokeMethod('openInAppStore', argumentMap);
}

///
///
Future<List<String>> getInstalledPackageNameList() async {
  if (_platform.isIOS) {
    throw UnsupportedError('Functionality not support on Ios');
  }

  final List<String> packageNameList = await _channel.invokeListMethod('getInstalledPackageNameList');

  return packageNameList;
}

///
///
Future<bool> isInstalled(String packageName) async {
  if (_platform.isIOS) {
    throw UnsupportedError('Functionality not support on Ios');
  }

  Map<String, Object> argumentMap = {"packageName": packageName};

  final bool isInstalled = await _channel.invokeMethod<bool>('isInstalled');

  return isInstalled;
}