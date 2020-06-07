import 'package:openjmu_cms/openjmu_cms.dart';

Future<void> main() async {
  final Application<OpenjmuCmsChannel> app = Application<OpenjmuCmsChannel>()
      ..options.configurationFilePath = 'config.yaml'
      ..options.port = 8888;

  final int count = Platform.numberOfProcessors ~/ 2;
  await app.start(numberOfInstances: count > 0 ? count : 1);

  print('Application started on port: ${app.options.port}.');
  print('Use Ctrl-C (SIGINT) to stop running the application.');
}