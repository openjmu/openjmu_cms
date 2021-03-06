///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/07 22:08
///
import 'package:openjmu_cms/openjmu_cms.dart';

class RegisterController extends ResourceController {
  RegisterController(this.authServer, this.context);

  final AuthServer authServer;
  final ManagedContext context;

  @Operation.post()
  Future<Response> createUser(@Bind.body() User user) async {
    if (user?.username?.isNotEmpty != true ||
        user?.password?.isNotEmpty != true) {
      return Response.ok(
        BaseResponseModel<dynamic>(
          code: responseErrorCode,
          msg: 'username or password required',
        ),
      );
    }

    //判断用户是否存在
    final Query<User> query = Query<User>(context)
      ..where((User u) {
        return u.username;
      }).equalTo(user.username);
    if (await query.fetchOne() != null) {
      return Response.ok(
        BaseResponseModel<dynamic>(
          code: responseErrorCode,
          msg: 'user has already exist',
        ),
      );
    }

    //插入数据库
    user
      ..salt = AuthUtility.generateRandomSalt()
      ..hashedPassword = authServer.hashPassword(user.password, user.salt);

    final User result = await Query(context, values: user).insert();

    return Response.ok(
      BaseResponseModel<User>(
        code: responseSuccessCode,
        msg: '',
        data: result,
      ),
    );
  }
}
