///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/07 22:08
///
import 'package:openjmu_cms/openjmu_cms.dart';

class AnnouncementModel extends CustomManagedObject<_AnnouncementModel>
    implements _AnnouncementModel {}

class _AnnouncementModel {
  @primaryKey
  int id;

  @Column(nullable: false)
  bool isActive;

  String title;

  String content;

  @Column(nullable: false, indexed: true)
  int modifiedByUserId;

  @Column(nullable: false)
  DateTime modifiedDateTime;
}
