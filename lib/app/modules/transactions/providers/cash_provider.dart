import '../../../core/api_helper/core_service.dart';
import '../../../core/api_helper/urls.dart';
import '../../../core/utils/actions/try_catch.dart';
import '../../../data/models/server_response_model.dart';
import '../../../providers/default_with_auth_provider.dart';

class CashProvider extends DefaultWithAuthProvider {
  Future<ServerResponseModel?> getFeeApi(
      {required double amount,
      required String method,
      required String type}) async {
    var response = await tryCatch(() async {
      var response = await get(
        Url.CASH_FEE,
        query: {
          "amount": amount.toString(),
          "method": method,
          "direction": type
        },
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> cashInApi({
    required double amount,
    required String method,
    required String currency,
  }) async {
    var response = await tryCatch(() async {
      var response = await post(
        Url.CASH_IN,
        {"amount": amount, "method": method, 'currency': currency},
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }
}
