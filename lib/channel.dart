///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/06 16:50
///
import 'package:aqueduct/managed_auth.dart';

import 'package:openjmu_cms/openjmu_cms.dart';

class OpenjmuCmsChannel extends ApplicationChannel {
  ManagedContext context;
  AuthServer authServer;

  @override
  Future<void> prepare() async {
    logger.onRecord.listen(
      (LogRecord rec) =>
          print('$rec ${rec.error ?? ''} ${rec.stackTrace ?? ''}'),
    );

    final CustomConfig config = CustomConfig(options.configurationFilePath);
    final ManagedDataModel dateModel =
        ManagedDataModel.fromCurrentMirrorSystem();
    final PostgreSQLPersistentStore persistentStore =
        PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName,
    );

    context = ManagedContext(dateModel, persistentStore);

    final ManagedAuthDelegate<User> delegate =
        ManagedAuthDelegate<User>(context);
    authServer = AuthServer(delegate);
  }

  @override
  Controller get entryPoint {
    final Router router = Router();

    router.route('/auth/token').link(() => AuthController(authServer));

    router.route('/login').link(() => LoginController(context));

    router
        .route('/register')
        .link(() => RegisterController(authServer, context));

    router.route('/files/*').link(() => FileController('public/'));

    router
        .route('/first-date')
        .link(() => Authorizer.bearer(authServer))
        .link(() => FirstDateController(context));

    return router;
  }
}
