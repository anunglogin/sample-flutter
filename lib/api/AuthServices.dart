import 'dart:convert';

import 'package:flutter_navigation_3/config/app_constants.dart';
import 'package:flutter_navigation_3/model/AuthModel.dart';
import 'package:http/http.dart' as http;

class AuthServices {

  Future<AuthModel> login(String dataUsername, String dataPassword) async {
    var url = Uri.parse('${AppConstants.baseUrl}/auth/signin');

    var response = await http.post(url, body: {
      'username' : dataUsername,
      'password' : dataPassword
    });

    var data = jsonDecode(response.body);

    try {
      if (data['access_token'] != null) {
        return AuthModel.fromJson(data);
      } else {
        throw Exception('Unauthorized');
      }
    } catch (e) {
      rethrow;
    }
    
  }
  
}