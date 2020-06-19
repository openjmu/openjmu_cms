///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/06 15:56
///
import 'package:openjmu_cms/openjmu_cms.dart';

/// Base Response Model.
class BaseResponseModel<T> {
  BaseResponseModel({
    @required this.code,
    @required this.msg,
    this.data,
  });

  int code;
  String msg;
  T data;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'code': code,
      'msg': msg,
      'data': data,
    };
  }
}
