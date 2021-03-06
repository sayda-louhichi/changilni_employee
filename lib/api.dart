import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Api {
  String baseurl = "http://192.168.1.8:3000";
  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();
  Future get( String url) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    // /user/register
    var response =  await http.get(
      url,
      headers: {"Authorization": "Bearer $token",
       "Content-type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }
  

  Future<http.Response> patch(String url, Map<String, String> body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }


  Future<http.Response> post1(String url, var body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }
 Future<http.Response> post2(String url, Map<String, dynamic> body) async {
  
  url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {
        "Content-type": "application/json",},
    
      body: json.encode(body),
    );
    return response;
  }
  Future<http.StreamedResponse> patchImage(String url, String filepath) async {
    url = formater(url);
    String token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response = request.send();
    return response;
  }

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName) {
    String url = formater("/uploads//$imageName.jpg");
    return NetworkImage(url);
  }
 NetworkImage getImagee(String imageName) {
    String url = formater("/uploadsReleve//$imageName.jpg");
    return NetworkImage(url);
  }
 Future<http.Response> delete(String url, var body) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.delete(
      url,
      headers: {
        "Content-type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    return response;
  }
 
/*sendNotify(String title,String body,String id)async{
    await http.post(
    'https://fcm.googleapis.com/fcm/send',
     headers: <String, String>{
       'Content-Type': 'application/json',
       'Authorization': 'key=$serverToken',
     },
     body: jsonEncode(
     <String, dynamic>{
       'notification': <String, dynamic>{
         'body': body.toString(),
         'title': title.toString()
       },
       'priority': 'high',
       'data': <String, dynamic>{
         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
         'id': '1',
         'status': 'done',
         "name":"sayda"
       },
       'to': await FirebaseMessaging.instance.getToken(),
     },
    ),
  );
  }
   getMessage(){
  FirebaseMessaging.onMessage.listen((message){
    print(message.notification.title);
  });
  }*/
  
}