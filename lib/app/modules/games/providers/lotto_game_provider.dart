import 'dart:convert';

import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/formatters/extension.dart';
import 'package:haiti_lotri/app/providers/default_with_auth_provider.dart';
import 'package:intl/intl.dart';

import '../../../core/api_helper/core_service.dart';
import '../../../core/api_helper/urls.dart';
import '../../../core/utils/actions/try_catch.dart';
import '../../../data/models/server_response_model.dart';

class LottoGameProvider extends DefaultWithAuthProvider {
  Future<ServerResponseModel?> getNextTirageApi() async {
    var response = await tryCatch(() async {
      var response = await get<ServerResponseModel>(
        Url.NEXT_TIRAGE_API,
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> jweGameApi(List<Map> list) async {
    var response = await tryCatch(() async {
      var response = await post<ServerResponseModel>(Url.JWE_GAME, list);
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> getTicketsApi(
      {required Map<String, dynamic> params}) async {
    var query = {"pagination": jsonEncode(params)};
    var response = await tryCatch(() async {
      var response = await get<ServerResponseModel>(Url.tickets, query: query);
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> getTicketDetailApi(int idTicket) async {
    var response = await tryCatch(() async {
      var response =
          await get<ServerResponseModel>("${Url.ticketDetail}/$idTicket");
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> resultTirajApi(String name) async {
    var response = await tryCatch(() async {
      var response =
          await get<ServerResponseModel>("${Url.TIRAGE_RESULTS}/$name");
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> ticketReceiptApi(int id) async {
    var response = await tryCatch(() async {
      var response =
          await get<ServerResponseModel>("${Url.TICKET_RECEIPT}/$id");
      return CoreService.returnResponse(response);
    });
    return response;
  }
}
