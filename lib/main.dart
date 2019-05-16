import 'package:flutter/material.dart';
import 'NavigationIconView.dart';
import 'AchievementView.dart';
import 'NetDemo.dart';
import 'ReadAndWrite.dart';
import 'LinearProgressIndicator.dart';
import 'ScrollableTabsDemo.dart';
import 'CarcTabsDemo.dart';
import 'BottomSheetDemo.dart';
import 'DynamicBottomSheetDemo.dart';
import 'FormFieldDemo.dart';

// 创建类，自定义图标，继承StatelessWidget（无状态的控件）
class CustomIcon extends StatelessWidget {
  // 覆盖此函数以构建依赖于动画的当前状态的控件
  @override
  Widget build(BuildContext context) {
    // 获取当前图标主题，创建与此图标主题相同的图标主题
    final IconThemeData iconTheme = IconTheme.of(context);
    // 返回值，创建一个容器控件
    return new Container(
      // 围绕子控件的填充：每个边都偏移4.0
        margin: const EdgeInsets.all(4.0),
        // 容器宽度：图标主题的宽度减8.0
        width: iconTheme.size - 8.0,
        // 容器高度：图标主题的高度减8.0
        height: iconTheme.size - 8.0,
        // 子控件的装饰：创建一个装饰
        decoration: new BoxDecoration(
          // 背景颜色：图标主题的颜色
            color: iconTheme.color
        )
    );
  }
}
// 创建类，菜单演示，继承StatefulWidget（有状态的控件）
class MenusDemo extends StatefulWidget {
  /*
   * 覆盖具有相同名称的超类成员
   * createState方法在树中的给定位置为此控件创建可变状态
   *  子类应重写此方法以返回其关联的State子类新创建的实例
   */
  @override
  _MenusDemoState createState() => new _MenusDemoState();
}
/*
 * 关联State子类的实例
 * 继承State：StatefulWidget（有状态的控件）逻辑和内部状态
 * 继承TickerProviderStateMixin，提供Ticker对象
 */
class _MenusDemoState extends State<MenusDemo> with TickerProviderStateMixin {
  // 类成员，存储底部导航栏的当前选择
  int _currentIndex = 2;
  // 类成员，存储底部导航栏的布局和行为：在点击时会变大
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  // 类成员，存储NavigationIconView类的列表
  List<NavigationIconView> _navigationViews;
  /*
   * 在对象插入到树中时调用
   * 框架将为它创建的每个State（状态）对象调用此方法一次
   * 覆盖此方法可以实现此对象被插入到树中的位置的初始化
   * 或用于配置此对象上的控件的位置的初始化
   */
  @override
  void initState() {
    // 调用父类的内容
    super.initState();
    // 在存储NavigationIconView类的列表里添加内容
    _navigationViews = <NavigationIconView>[
      /*
       * 创建NavigationIconView类的实例
       *  传递图标参数
       *  传递标题参数
       *  传递颜色参数
       *  传递Ticker对象
       */
      new NavigationIconView(
        icon: new Icon(Icons.access_alarm),
        title: new Text('成就'),
        color: Colors.deepPurple[500],
        vsync: this,
      ),
      new NavigationIconView(
        icon: new CustomIcon(),
        title: new Text('行动'),
        color: Colors.deepOrange[500],
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.cloud),
        title: new Text('人物'),
        color: Colors.teal[500],
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.favorite),
        title: new Text('财产'),
        color: Colors.indigo[500],
        vsync: this,
      ),
      new NavigationIconView(
        icon: new Icon(Icons.event_available),
        title: new Text('设置'),
        color: Colors.pink[500],
        vsync: this,
      ),
    ];
    // 循环调用存储NavigationIconView类的列表的值
    for (NavigationIconView view in _navigationViews)
      // 每次动画控制器的值更改时调用侦听器
      view.controller.addListener(_rebuild);
    // 底部导航栏当前选择的动画控制器的值为1.0
    _navigationViews[_currentIndex].controller.value = 1.0;
  }
  // 释放此对象使用的资源
  @override
  void dispose() {
    // 调用父类的内容
    super.dispose();
    // 循环调用存储NavigationIconView类的列表中的项
    for (NavigationIconView view in _navigationViews)
      // 调用此方法后，对象不再可用
      view.controller.dispose();
  }
  // 动画控制器的值更改时的操作
  void _rebuild() {
    // 通知框架此对象的内部状态已更改
    setState((){
      // 重建，以便为视图创建动画
    });
  }
  // 建立过渡堆栈
  Widget _buildTransitionsStack() {
    // 局部变量，存储不透明度转换的列表
    final List<FadeTransition> transitions = <FadeTransition>[];
    // 循环调用存储NavigationIconView类的列表的值
    for (NavigationIconView view in _navigationViews)
      // 在存储不透明度转换的列表中添加transition函数的返回值
      transitions.add(view.transition(_type, context));
    // 对存储不透明度转换的列表进行排序
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      // aValue：a的动画值
      double aValue = aAnimation.value;
      // bValue：b的动画值
      double bValue = bAnimation.value;
      /*
       * 将aValue与bValue进行比较
       *  返回一个负整数，aValue排序在bValue之前
       *  返回一个正整数，aValue排序在bValue之后
       */
      return aValue.compareTo(bValue);
    });
    // 返回值，创建层叠布局控件
    return new Stack(children: transitions);
  }
  // 覆盖此函数以构建依赖于动画的当前状态的控件
  @override
  Widget build(BuildContext context) {
    // 局部变量，创建底部导航栏
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      /*
       * 在底部导航栏中布置的交互项：迭代存储NavigationIconView类的列表
       *  返回此迭代的每个元素的底部导航栏项目
       *  创建包含此迭代的元素的列表
       */
        items: _navigationViews
            .map((NavigationIconView navigationView) => navigationView.item)
            .toList(),
        // 当前活动项的索引：存储底部导航栏的当前选择
        currentIndex: _currentIndex,
        // 底部导航栏的布局和行为：存储底部导航栏的布局和行为
        type: _type,
        // 当点击项目时调用的回调
        onTap: (int index) {
          // 通知框架此对象的内部状态已更改
          setState((){
            // 当前选择的底部导航栏项目，开始反向运行此动画
            _navigationViews[_currentIndex].controller.reverse();
            // 更新存储底部导航栏的当前选择
            _currentIndex = index;
            // 当前选择的底部导航栏项目，开始向前运行此动画
            _navigationViews[_currentIndex].controller.forward();
          });
        }
    );
    // 实现基本的质感设计视觉布局结构
    return new Scaffold(
      // 质感设计应用栏
      appBar: new AppBar(
        // 应用栏中显示的主要控件，包含程序当前内容描述的文本
          title: new Text('底部导航演示'),
          // 在标题控件后显示的控件
          actions: <Widget> [
            // 创建一个显示弹出式菜单的按钮
            new PopupMenuButton<BottomNavigationBarType>(
              // 当用户从此按钮创建的弹出菜单中选择一个值时调用
                onSelected: (BottomNavigationBarType value) {
                  // 通知框架此对象的内部状态已更改
                  setState((){
                    // 存储底部导航栏的布局和行为：选择值
                    _type = value;
                  });
                },
                // 点击弹出菜单中显示的项目时调用
                itemBuilder: (BuildContext context) => <PopupMenuItem<BottomNavigationBarType>> [
                  /*
               * 弹出菜单中的显示项目
               *  返回值：底部导航栏的布局和行为
               *  子控件：文本控件
               */
                  new PopupMenuItem<BottomNavigationBarType>(
                      value: BottomNavigationBarType.fixed,
                      child: new Text('Fixed')
                  ),
                  new PopupMenuItem<BottomNavigationBarType>(
                      value: BottomNavigationBarType.shifting,
                      child: new Text('Shifting')
                  )
                ]
            )
          ]
      ),
      // 主要内容
      body: new Center(
        // 主要内容：_buildTransitionsStack函数的返回值
          child: _buildTransitionsStack()
      ),
      // 水平的按钮数组，沿着程序的底部显示
      bottomNavigationBar: botNavBar,
    );
  }
}



// 程序入口
void main() {
  // 创建质感设计程序，并放置到主屏幕
  runApp(new MaterialApp(
    // 在窗口管理器中使用此应用程序的单行描述
    title: 'Flutter',
    // 程序的默认路由的控件
    home: new FormFieldDemo(),
  ));
}

