import 'dart:io';
import 'dart:convert';

get(String url) async {
  var httpClient = new HttpClient();
  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  var responseBody = await response.transform(utf8.decoder).join();

  return responseBody;
}