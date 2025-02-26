import '../../../core/api_helper/core_service.dart';
import '../../../core/api_helper/urls.dart';
import '../../../core/utils/actions/try_catch.dart';
import '../../../data/models/server_response_model.dart';
import '../../../providers/default_provider.dart';

class ConnectionProvider extends DefaultProvider {
  Future<ServerResponseModel?> signIn(
      String email, String password, String? token) async {
    var response = await tryCatch(() async {
      var response = await post(
        Url.LOGIN,
        {
          'email': email,
          'password': password,
          "notification_token": token,
        },
        contentType: 'application/json',
      );
      var data = CoreService.returnResponse(response);
      return data;
    });
    return response;
  }

  Future<ServerResponseModel?> signup(
    String name,
    String phone,
    String email,
    String password,
  ) async {
    var response = await tryCatch(() async {
      var response = await post(
        Url.REGISTER,
        {
          'name': name,
          'phone': '509$phone',
          'email': email,
          'password': password,
        },
        contentType: 'application/json',
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> askForOtpApi(String email, String type) async {
    var response = await tryCatch(() async {
      var response = await post(
        Url.REQUEST_AUTH,
        {
          'email': email,
          'type': type,
        },
        contentType: 'application/json',
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> verifyOTP(
      String email, String otp, String type) async {
    var response = await tryCatch(() async {
      var response = await post(
        Url.VERIFY_AUTH,
        {
          'email': email,
          'otp': otp,
          'type': type,
        },
        contentType: 'application/json',
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> resetPassword(
      String email, String password) async {
    var response = await tryCatch(() async {
      var response = await put(
        Url.RESET_PASSWORD,
        {'email': email, "password": password},
        contentType: 'application/json',
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }
}
