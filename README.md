# flutter_gridnine

[![pub version][pub-image]][pub-url] [![][discord-image]][discord-url]

[pub-image]: https://img.shields.io/pub/v/local_notifier.svg
[pub-url]: https://pub.dev/packages/flutter_serialport

Flutter GridNine plugin.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [flutter_gridnine](#flutter_gridnine)
  - [Platform Support](#platform-support)
  - [Quick Start](#quick-start)
    - [Installation](#installation)
    - [Usage](#usage)
  - [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Platform Support

| All |
| :---: |
|   ✔️  |

## Quick Start

### Installation
Add this to your package's pubspec.yaml file:
```dart
dependencies:
  ...
  flutter_gridnine:
    git: 'https://github.com/mingyouzhu/flutter_gridnine.git'
```
- Or
```dart
dependencies:
  ...
  flutter_gridnine: ^0.0.1
```

### Usage
- simpleModel.dart:
```
import 'package:flutter_gridnine/gridnine_model.dart';

class SimpleModel extends GNModel{
  final String url;
  final String iconUrl;
  final String title;
  final String description;

  SimpleModel({this.url,this.iconUrl,this.title,this.description});

  @override
  String getTitle() => title;

  @override
  String getIconUrl() => iconUrl;

  @override
  String getSubTitle() => description;

  @override
  String getUrl() => url;
}
```

- main.dart:
```
import 'package:flutter/material.dart';
import 'package:flutter_gridnine/flutter_gridnine.dart';

import 'simpleModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var models = List<GNModel>();
    for (int i = 0; i < 4; i++) {
      models.add(
        SimpleModel(
            iconUrl:
                'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1567702065868&di=3b7a93083a7a10270c187ea395bf353a&imgtype=0&src=http%3A%2F%2Fpic32.nipic.com%2F20130808%2F13243996_132446704147_2.jpg',
            title: '标题1',
            description: null),
      );
    }
    return Scaffold(
      backgroundColor:Colors.black12,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child:GridNine(
          axisCount:4,
          color:Colors.white,
          collection: models,
          indicatorShow: true,
          indicatorActiveColor: Colors.blue,
          onTap: (GNModel item) {
            print(item.getTitle());
          },
        ),
      ),
    );
  }
}
```

> Please see the example app of this plugin for a full example.

# Preview
![Demo](./screenshots/1.png)

## License

[MIT](./LICENSE)
