///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/19 11:45
///
import 'package:openjmu_cms/openjmu_cms.dart';

class RefreshTokenModel extends Serializable {
  @Serialize()
  String token;

  @override
  Map<String, dynamic> asMap() {
    return <String, dynamic>{'token': token};
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    token = object['token']?.toString();
  }
}
