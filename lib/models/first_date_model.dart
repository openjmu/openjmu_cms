///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/07 22:03
///
import 'package:openjmu_cms/openjmu_cms.dart';

class FirstDateModel extends CustomManagedObject<_FirstDateModel> implements _FirstDateModel {
  FirstDateModel();

  factory FirstDateModel.fromJson(Map<String, dynamic> json) {
    return FirstDateModel()
    ..value = json['value']?.toString() ?? ''
    ..modifiedByUserId = json['user'] as int;
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'modified_by_user_id': modifiedByUserId,
    };
  }
}

class _FirstDateModel {
  @primaryKey
  int id;

  @Column(nullable: false)
  String value;

  @Column(nullable: false)
  int modifiedByUserId;
}
