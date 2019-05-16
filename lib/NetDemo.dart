import 'dart:convert';
import 'package:http/http.dart' as http;
import 'NetUtil.dart';


void NetworkLoading() async {
  // 将给定标头的HTTP GET请求发送到给定的URL，并注册回调，参数为HTTP响应
  var url = 'http://httpbin.org/';
  //向指定URL发送GET请求
  http.get(url).then((response) {
    print("响应状态： ${response.statusCode}");
    print("响应正文： ${response.body}");
  });

}