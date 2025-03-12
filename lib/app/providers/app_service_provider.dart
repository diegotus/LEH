import 'package:get/get.dart';

import '../core/api_helper/core_service.dart';
import '../core/api_helper/urls.dart';
import '../core/utils/actions/try_catch.dart';
import '../data/models/document_model.dart';
import '../data/models/server_response_model.dart';
import '../data/models/user_profil_update_model.dart';
import 'default_with_auth_provider.dart';

class AppServiceProvider extends DefaultWithAuthProvider {
  Future<ServerResponseModel?> getUserDetails() async {
    var response = await tryCatch(() async {
      var response = await get<ServerResponseModel>(
        Url.GET_PROFILE_DETAILS,
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> updateUserProfile(
      {required UserProfilUpdate profil}) async {
    var response = await tryCatch(() async {
      var response = await patch<ServerResponseModel>(
        Url.UPDATE_PROFILE,
        profil.toMap(),
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> updateUserInfo(
      {String? locale, String? dob}) async {
    if (locale == null && dob == null) return null;
    Map<String, String> param = {};
    param.addIf(locale != null, 'locale', locale ?? '');
    param.addIf(dob != null, 'dob', dob ?? '');

    var response = await tryCatch(() async {
      var response =
          await patch<ServerResponseModel>(Url.UPDATE_USERINFO, param);
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> getUserBalance() async {
    var response = await tryCatch(() async {
      var response = await get<ServerResponseModel>(
        Url.BALANCE,
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> uploadProfilPicture(FileData document,
      {dynamic Function(double)? uploadProgress}) async {
    var data = FormData({
      "file": MultipartFile(
        document.bytes,
        filename: document.name,
        contentType: document.mimeType,
      )
    });
    var response = await tryCatch(() async {
      var response = await post<ServerResponseModel>(
        Url.UPLOAD_PROFILE_IMAGE,
        data,
        contentType: 'multipart/form-data',
        uploadProgress: uploadProgress,
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }

  Future<ServerResponseModel?> updateFMCToken({required String token}) async {
    var response = await tryCatch(() async {
      var response = await patch<ServerResponseModel>(
        Url.UPDATE_PROFILE,
        {'token': token},
      );
      return CoreService.returnResponse(response);
    });
    return response;
  }
}
