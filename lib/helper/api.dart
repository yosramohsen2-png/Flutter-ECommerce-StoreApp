// import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  // دالة GET
  Future<dynamic> get({required String url, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }
    http.Response response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'E/Api: there\'s a problem with status code ${response.statusCode} from URL: $url',
      );
    }
  }

  // دالة POST (بافتراض أن الـbody سيأتي Map وسيتم تشفيره هنا إذا كان dynamic)
  Future<dynamic> post({
    required String url,
    dynamic body, // يفضل أن يكون Map<String, dynamic> لو كان هيتم تشفيره هنا
    String? token,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/json'});

    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }

    http.Response response = await http.post(
      Uri.parse(url),
      body:
          body, // الـBody لو Map الـhttp package بيشفره، لو String بيبعته زي ما هو
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'E/Api: Problem with status code ${response.statusCode}. Response body: ${jsonDecode(response.body)}',
      );
    }
  }

  // دالة PUT (المصححة لضمان استقبال JSON String)
  Future<dynamic> put({
    required String url,
    String?
    body, // ✅ تصحيح النوع لـString? لاستقبال الـJSON المشفر من الـService
    String? token,
  }) async {
    Map<String, String> headers = {};
    // ✅ نؤكد إننا بنبعت JSON
    headers.addAll({'Content-Type': 'application/json'});

    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }

    // رسالة تتبع لتأكيد وصول البيانات
    print('I/Api: PUT URL=$url, Body Length=${body?.length ?? 0}');

    http.Response response = await http.put(
      Uri.parse(url),
      body: body, // الـBody الآن هو String JSON
      headers: headers,
    );

    if (response.statusCode == 200) {
      print('I/Api: PUT successful. Status: 200');
      return jsonDecode(response.body);
    } else {
      // ✅ نضمن ظهور الـError بوضوح
      String errorMessage =
          'E/Api: PUT failed with status code ${response.statusCode}';
      try {
        var errorBody = jsonDecode(response.body);
        errorMessage += ' - Details: $errorBody';
      } catch (_) {
        errorMessage += ' - Raw Body: ${response.body}';
      }
      print(errorMessage);
      throw Exception(errorMessage);
    }
  }
}
