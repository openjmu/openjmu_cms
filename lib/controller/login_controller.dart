///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/06 16:08
///
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:openjmu_cms/openjmu_cms.dart';

class LoginController extends ResourceController {
  LoginController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> methodNotAllowed() async {
    return Response.notFound();
  }

  @Operation.post()
  Future<Response> login(@Bind.body() User user) async {
    String msg = '登录异常';
    // Search for user.
    final Query<User> query = Query<User>(context)
      ..where(
        (User u) => u.username,
      ).equalTo(user.username);
    final User result = await query.fetchOne();

    if (result == null) {
      msg = '用户不存在';
    } else {
      // Return token if exist.
      const String clientId = 'com.openjmu.auth';
      const String clientSecret = 'openjmusecret#2020';
      final String body =
          'username=${user.username}'
          '&password=${user.password}'
          '&grant_type=password';
      final String clientCredentials = const Base64Encoder().convert(
        '$clientId:$clientSecret'.codeUnits,
      );

      final http.Response response = await http.post(
        'http://127.0.0.1:8888/auth/token',
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic $clientCredentials'
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> map = json.decode(response.body) as Map<String, dynamic>;

        return Response.ok(
          BaseResponseModel<Map<String, dynamic>>(
            code: 1,
            msg: '登录成功',
            data: <String, dynamic>{
              'access_token': map['access_token'],
              'username': result.username,
              'user_id': result.id,
            },
          ),
        );
      }
    }

    return Response.ok(
      BaseResponseModel<dynamic>(
        code: 1,
        msg: msg,
      ),
    );
  }
}
