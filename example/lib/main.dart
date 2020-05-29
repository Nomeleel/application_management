import 'dart:io';

import 'package:application_management/application_management.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _controller.text = 'com.android.chrome';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin fun test app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controller,
              ),
              RaisedButton(
                child: const Text('Test'),
                onPressed: () async {
                  // android test.
                  if (Platform.isAndroid) {
                    openApp(_controller.text);

                    openInAppStore(_controller.text);

                    openInSpecifyAppStore(_controller.text, 'com.tencent.android.qqdownloader',
                      'com.tencent.pangu.link.LinkProxyActivity');

                    final List<String> list = await getInstalledPackageNameList();
                    list.forEach(print);

                    final bool isAppInstalled = await isInstalled(_controller.text);
                    print(isAppInstalled);

                    final Map<String, bool> isAppListInstalledMap = await isInstalledMap(
                      <String> [_controller.text, 'test', 'com.tencent.qqlive']);
                    isAppListInstalledMap.forEach((String key, bool value) {
                      print('key: $key value: $value');
                    });
                  } 
                  else if (Platform.isIOS){
                    // ios test.
                    openApp('weixin://');

                    // weixin bundle id.
                    openInAppStore('414478124');

                    final bool isAppInstalled = await isInstalled('weixin://');
                    print(isAppInstalled);
                    
                    final Map<String, bool> isAppListInstalledMap = await isInstalledMap(
                      <String> ['weixin://', 'test://', 'tenvideo://']);
                    isAppListInstalledMap.forEach((String key, bool value) {
                      print('key: $key value: $value');
                    });
                  }
                  else {
                    print('Not support on ${Platform.operatingSystem}');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
