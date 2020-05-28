# Application Management

[![Pub Package](https://img.shields.io/pub/v/application_management.svg)](https://pub.dev/packages/application_management) [![Support Platforms](https://img.shields.io/badge/flutter-android%20%7C%20ios-green.svg)](https://github.com/Nomeleel/application_management) [![Flutter Sample](https://img.shields.io/badge/flutter-sample-purple.svg)](https://github.com/Nomeleel/wang_card_assistant) [![Star on GitHub](https://img.shields.io/github/stars/Nomeleel/application_management.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/Nomeleel/application_management)

Supports the operation of native applications in the form of plugins.

## Features now supported

| API Name | Description | Android | Ios | Note
| :------: | :------ | :------: | :------: | :------: |
| openApp | Open app with special key. | ✔ | ✔ |
| openInAppStore | Open the details page for the app in the Apple App Store] or Android Market. | ✔ | ✔ |
| openInSpecifyAppStore | Open the details page for the app in the specify Android Market. | ✔ |  |
| getInstalledPackageNameList | For Android can get current device installed all app list. | ✔ |  |
| isInstalled | Check the current device whether installed special app. | ✔ | ✔ |
| isInstalledMap | Can use this method if you want to check if multiple apps are installed at once. | ✔ | ✔ |

## Installing

How to use this library.

### 1. Depend it

Add this to your package's **pubspec.yaml** file:

```
// by git
dependencies:
  application_management:
    git: git@github.com:Nomeleel/application_management.git

-----------------------------------------------------------------

// by pub.dev/packages
dependencies:
  application_management: ^0.0.1
```

### 2. Load it

After the first step is saved, the library will be obtained automatically, or you can try to obtain it manually.

with Flutter:

```
flutter pub get
```

### 3. Import it

Now in your Dart code, you can use:

```
import 'package:application_management/application_management.dart';
```

### 4. Use it

```
RaisedButton(
    child: Text('Open'),
    onPressed: () {
        // for android.
        openApp("com.tencent.mobileqq");
        // for ios.
        openApp("mqq://");
    }
}
```

## Note

In the course of use, because of platform limitations, we must do some other operations. For example: permission request.

### For ios

Most of the APIs currently supported in iOS depend on the ***Url Scheme***. To actually use it, you must configure it in the project.

#### How to use url scheme

1. Open the following path in the project:

```
project_name\ios\Runner\Info.plist
```

2. Add url scheme list to this file.

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <!-- add here -->
        <key>LSApplicationQueriesSchemes</key>
        <array>
            <!-- You can add up to 50 here. -->
            <string>weixin</string>
            <string>tenvideo</string>
            <string>qqmusic</string>
        </array>
        <!-- end -->
    </dict>
</plist>
```

3. Add ': \/\/' suffix when using.

```
// only for ios.
openApp("weixin://");
isInstalled("tenvideo://");
```