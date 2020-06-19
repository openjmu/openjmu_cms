///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/07 22:48
///
import 'package:openjmu_cms/openjmu_cms.dart';

abstract class CustomManagedObject<T> extends ManagedObject<T> {
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return const JsonEncoder().convert(toJson());
  }
}
