///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/06 15:56
///

/// Base Response Model.
class BaseResponseModel<T> {
  BaseResponseModel({
    this.code,
    this.msg,
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