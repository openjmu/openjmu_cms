///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/19 13:41
///
import 'package:openjmu_cms/openjmu_cms.dart';

class CheckTokenValidController extends ResourceController {
  @Operation.get()
  Future<Response> check() async {
    return Response.ok(
      BaseResponseModel(
        code: responseSuccessCode,
        msg: 'valid'
      ),
    );
  }
}