import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'http.dart';
import 'common.dart';
import 'routes/index.dart';
import 'widgets/index.dart';

void main() async {
  dio.interceptors..add(CookieManager(CookieJar()))..add(LogInterceptor());
  runApp(MyApp());
  cameras = await availableCameras();
  PaintingBinding.instance.imageCache.maximumSize = 2000;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 200 << 20;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MaterialApp(
    //   onGenerateTitle: (context) {
    //     return DemoLocalizations.of(context).title;
    //   },
    //   localizationsDelegates: [
    //     GlobalMaterialLocalizations.delegate,
    //     GlobalWidgetsLocalizations.delegate,
    //     DemoLocalizationsDelegate(),
    //   ],
    // );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   DemoLocalizationsDelegate(),
      // ],
      // supportedLocales: [
      //   const Locale('en', 'US'),
      //   const Locale('zh', 'CN'),
      // ],
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == 'tip') {
          return MaterialPageRoute(builder: (context) {
            return TipRoute(text: settings.arguments);
          });
        }
        return null;
      },
      routes: {
        'tip2': (context) {
          return TipRoute(text: ModalRoute.of(context).settings.arguments);
        },
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    void _openPage(BuildContext context, PageInfo page) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          if (!page.withScaffold) {
            return page.build(context);
          }
          return PageScaffold(
            title: page.title,
            body: page.build(context),
            padding: page.padding,
          );
        },
      ));
    }

    List<Widget> _generateItem(BuildContext context, List<PageInfo> children) {
      return children.map<Widget>((page) {
        return ListTile(
          title: Text(page.title),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () => _openPage(context, page),
        );
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Examples'),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text('First Flutter App'),
            children: _generateItem(context, [
              PageInfo('route info', (ctx) => RouterTestRoute()),
            ]),
          ),
        ],
      ),
    );
  }
}
