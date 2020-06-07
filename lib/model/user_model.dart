///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/06 15:54
///
import 'dart:convert';

import 'package:aqueduct/managed_auth.dart';
import 'package:openjmu_cms/openjmu_cms.dart';

class User extends ManagedObject<_User> implements _User, ManagedAuthResourceOwner<_User> {
  @Serialize(input: true, output: false)
  String password; // md5

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
      'tokens': tokens,
    };
  }

  @override
  String toString() {
    return const JsonEncoder.withIndent('  ').convert(toJson());
  }
}

class _User extends ResourceOwnerTableDefinition {

}