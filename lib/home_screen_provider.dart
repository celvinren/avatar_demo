import 'dart:convert';

import 'people.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenProvider extends ChangeNotifier {
  List<People> list = List<People>();

  Future<void> getDataFromAPI(BuildContext context) async {
    APIHelper hlp = APIHelper();
    var response =
        await hlp.postData("webservices/users_closest", context: context);
    if (response.isSuccess == true && response.data != null) {
      for (var item in response.data["data"]) {
        list.add(People.fromJson(item as Map<String, dynamic>));
      }
    }
    notifyListeners();
  }

  List<People> get getPeopleList => list;
}

class APIHelper {
  static const String API = "http://3.25.202.202/";
  String lastError = "";

  Future<HttpResponse> postData(String url,
      {bool hasAuth = false, @required BuildContext context}) async {
    String endpoint = API + url;
    Map<String, String> headers;
    if (hasAuth) {
      headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };
    }

    Map<String, dynamic> data = {
      "user_id": 20,
      "token": "AAA",
      "latitude": -27.4159513,
      "longitude": 152.9923712,
    };

    print("init get request");

    final response = await http.post(
      endpoint,
      body: json.encode(data),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return HttpResponse(true, data);
    }

    if (response.statusCode == 401) {
      return HttpResponse(false, null);
    } else {
      return HttpResponse(false, null);
    }
  }
}

class HttpResponse {
  HttpResponse(this.isSuccess, this.data);
  bool isSuccess;
  dynamic data;
}
