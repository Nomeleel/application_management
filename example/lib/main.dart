import 'package:flutter/material.dart';

import 'package:application_management/application_management.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controller;

  bool _result = false;

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
                child: Text('Test'),
                onPressed: () async {
                  // android test.
                  //openApp(_controller.text);
                  //openInSpecifyAppStore(_controller.text, "com.tencent.android.qqdownloader",
                    //"com.tencent.pangu.link.LinkProxyActivity");
                  // weixin bundle id.

                  // ios test.
                  //openApp('weixin://');
                  //openInAppStore('414478124');
                  // var isAppInstalled = await isInstalled('weixin://');
                  // print(isAppInstalled);
                  // var isAppListInstalledMap = await isInstalledMap(['weixin://', 'test://', 'tenvideo://']);
                  // isAppListInstalledMap.forEach((key, value) {
                  //   print('key: $key value: $value');
                  // });
                },
              ),
              Text('result: $_result\n'),
            ],
          ),
        ),
      ),
    );
  }
}
