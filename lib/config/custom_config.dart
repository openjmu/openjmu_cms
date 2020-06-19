///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/06 16:49
///
import 'package:openjmu_cms/openjmu_cms.dart';

class CustomConfig extends Configuration {
  CustomConfig(String path) : super.fromFile(File(path));

  DatabaseConfiguration database; // Database configuration.
}
