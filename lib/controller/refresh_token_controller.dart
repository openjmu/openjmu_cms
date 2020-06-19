///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/19 11:33
///
import 'package:http/http.dart' as http;

import 'package:openjmu_cms/openjmu_cms.dart';

class RefreshTokenController extends ResourceController {
  RefreshTokenController(this.authServer, this.context);

  final AuthServer authServer;
  final ManagedContext context;

  @Operation.post()
  Future<Response> refresh(@Bind.body() RefreshTokenModel model) async {
    String msg = 'Token Invalid';

    try {
      final AuthToken token = await authServer.refresh(
        model.token,
        clientId,
        clientSecret,
      );
      msg = 'Token refreshed';
      return Response.ok(
        BaseResponseModel<dynamic>(
          code: responseSuccessCode,
          msg: msg,
          data: <String, dynamic>{
            'access_token': token.accessToken,
            'refresh_token': token.refreshToken,
          },
        ),
      );
    } catch (e) {
      print('Error when refresh token: $e');
    }

    return Response.ok(
      BaseResponseModel<dynamic>(
        code: responseErrorCode,
        msg: msg,
      ),
    );
  }
}
