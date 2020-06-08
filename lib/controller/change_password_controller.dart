///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/08 11:28
///
import 'package:openjmu_cms/openjmu_cms.dart';

class ChangePasswordController extends ResourceController {
  ChangePasswordController(this.authServer, this.context);

  final AuthServer authServer;
  final ManagedContext context;

  @Operation.post()
  Future<Response> changePassword(
      @Bind.body() ChangePasswordModel model) async {
    String msg = 'user not exist.';

    // Request the current user's hash and salt.
    final Query<User> userQuery = Query<User>(context)
      ..where((User u) => u.id).equalTo(request.authorization.ownerID)
      // Add [returningProperties] to quaranty the column.
      ..returningProperties((User u) {
        return <dynamic>[u.hashedPassword, u.salt];
      });
    final User user =
        await userQuery.fetchOne(); // Because you only have one of yourself :)

    if (user != null) {
      final String lastSalt = user.salt;
      final String hashedPassword = user.hashedPassword;
      final String lastPassword =
          authServer.hashPassword(model.lastPassword, lastSalt);
      // Check if the last password matched.
      if (hashedPassword == lastPassword) {
        // Generate new salt and hashed password.
        final String newSalt = AuthUtility.generateRandomSalt();
        final String newHashPassword =
            authServer.hashPassword(model.newPassword, lastSalt);

        // Using query to update properties.
        final Query<User> newUserQuery = Query<User>(context)
          ..values.salt = newSalt
          ..values.hashedPassword = newHashPassword
          ..where((User u) => u.id).equalTo(request.authorization.ownerID);
        final User newUser = await newUserQuery.updateOne();
        return Response.ok(
          BaseResponseModel<User>(
            code: responseSuccessCode,
            msg: '',
            data: newUser,
          ),
        );
      } else {
        msg = 'password not match.';
      }
    }

    return Response.ok(
      BaseResponseModel<dynamic>(
        code: responseErrorCode,
        msg: msg,
      ),
    );
  }
}
