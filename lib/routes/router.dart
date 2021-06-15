import 'package:flutter/material.dart';

class RouterTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('打开提示页面'),
        onPressed: () async {
          var result = Navigator.push(
            context,
            MeterialPageRoute(
              builder: (context) {
                return TipRoute(
                  text: '我是提示XXXX',
                );
              },
            ),
          );
          print('路由返回值: $result');
        },
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({Key key, @required this.text}): super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scoffold(
      appBar: AppBar(
        title: Text('提示'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                child: Text('返回'),
                onPressed: () => Navigator.pop(context, '我是返回值'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}