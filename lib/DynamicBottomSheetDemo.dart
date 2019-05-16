import 'package:flutter/material.dart';

class DynamicBottomSheetDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text('底部面板')
        ),
        body: new Center(
            child: new RaisedButton(
                child: new Text('显示底部面板'),
                onPressed: () {
                  // showModalBottomSheet<T>：显示模态质感设计底部面板
                  showModalBottomSheet<Null>(context:context, builder:(BuildContext context) {
                    return new Container(
                        child: new Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: new Text(
                                '这是模态底部面板，点击任意位置即可关闭',
                                textAlign: TextAlign.center,
                                style: new TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 24.0
                                )
                            )
                        )
                    );
                  });
                }
            )
        )
    );
  }
}