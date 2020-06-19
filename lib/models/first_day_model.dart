///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/07 22:03
///
import 'package:openjmu_cms/openjmu_cms.dart';

class FirstDayModel extends CustomManagedObject<_FirstDayModel>
    implements _FirstDayModel {
  FirstDayModel();

  factory FirstDayModel.fromJson(Map<String, dynamic> json) {
    return FirstDayModel()
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

class _FirstDayModel {
  @primaryKey
  int id;

  @Column(nullable: false)
  String value;

  @Column(nullable: false)
  int modifiedByUserId;
}
