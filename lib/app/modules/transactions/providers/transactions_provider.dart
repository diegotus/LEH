import 'dart:convert';

import '../../../core/api_helper/core_service.dart';
import '../../../core/api_helper/urls.dart';
import '../../../core/utils/actions/try_catch.dart';
import '../../../core/utils/enums.dart';
import '../../../data/models/server_response_model.dart';
import '../../../providers/default_with_auth_provider.dart';

class TransactionsProvider extends DefaultWithAuthProvider {
  Future<ServerResponseModel?> getvalidationInfo(
      {required String phone, required double amount}) async {
    var params = {'phone_number': phone, 'amount': '$amount'};
    var response = await tryCatch(() async {
      var response = await get<ServerResponseModel>(
        Url.GET_VALIDATION_INFO,
        query: params,
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> sendMoney(
      {required int transactionID, required String pin}) async {
    var body = {
      "transaction_id": transactionID,
      'pin': pin,
    };
    var response = await tryCatch(() async {
      var response = await post<ServerResponseModel>(Url.TRANSFER_MONEY, body);
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> getTransactions(
      {required int page, required int perPage}) async {
    var params = {
      "pagination": jsonEncode({'page': page + 1, 'limit': '$perPage'}),
      "options": jsonEncode({
        "orderBy": {
          "created_at": 'desc',
        }
      })
    };
    var response = await tryCatch(() async {
      var response =
          await get<ServerResponseModel>(Url.TRANSACTIONS, query: params);
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> getTransactionDetailAPI(
      {required int id}) async {
    var response = await tryCatch(() async {
      var response =
          await get<ServerResponseModel>(Url.TRANSACTIONS + id.toString());
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> getLedgerDetailAPI({required String id}) async {
    var response = await tryCatch(() async {
      var response = await get<ServerResponseModel>(Url.CASH_DETAIL + id);
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> getLedgerDetailAPI2(
      {required String id, required TransactionMethod method}) async {
    var response = await tryCatch(() async {
      var response = await get<ServerResponseModel>(
          Url.CASH_DETAIL + method.name,
          query: {"transactionId": id});
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> ticketApi(int id) async {
    var response = await tryCatch(() async {
      var response =
          await get<ServerResponseModel>("${Url.GET_BILLET_TRANS_DETAILS}/$id");
      return CoreService.returnResponse(response);
    });
    return response;
  }
}
