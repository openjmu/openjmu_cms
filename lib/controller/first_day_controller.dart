///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020/06/07 22:11
///
import 'package:openjmu_cms/openjmu_cms.dart';

class FirstDayController extends ResourceController {
  FirstDayController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getFirstDate(@Bind.query('type') String type) async {
    final Query<FirstDayModel> query = Query<FirstDayModel>(context);
    dynamic result;
    if (type == 'all') {
      result = await query.fetch();
    } else {
      result = await query.fetchOne();
    }
    return Response.ok(
      BaseResponseModel<dynamic>(
        code: 1,
        msg: '',
        data: result,
      ),
    );
  }

  @Operation.post()
  Future<Response> updateFirstData(@Bind.body() FirstDayModel model) async {
    try {
      final int id = request.authorization.ownerID;
      model.modifiedByUserId = id;
      final Query<FirstDayModel> query = Query<FirstDayModel>(context)
        ..values = model;
      final FirstDayModel insertedModel = await query.insert();
      return Response.ok(
        BaseResponseModel<dynamic>(
          code: responseSuccessCode,
          msg: '',
          data: insertedModel,
        ),
      );
    } catch (e) {
      return Response.ok(
        BaseResponseModel<dynamic>(
          code: responseErrorCode,
          msg: 'server error',
        ),
      );
    }
  }
}
