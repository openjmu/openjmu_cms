///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/08 11:45
///
import 'package:openjmu_cms/openjmu_cms.dart';

class ChangePasswordModel extends Serializable {
  @Serialize(input: true, output: false)
  String lastPassword;

  @Serialize(input: true, output: false)
  String newPassword;

  @override
  Map<String, dynamic> asMap() {
    return <String, dynamic>{
      'last_password': lastPassword,
      'new_password': newPassword,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    lastPassword = object['last_password']?.toString();
    newPassword = object['new_password']?.toString();
  }
}