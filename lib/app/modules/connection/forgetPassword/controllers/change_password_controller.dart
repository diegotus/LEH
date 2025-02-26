// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:KIWOO/app/modules/connection/providers/connection_provider.dart';
// import 'package:get/get.dart';

// import '../../../../core/utils/app_utility.dart';
// import '../../../../data/models/server_response_model.dart';
// import '../../bindings/otp_binding.dart';
// import '../../views/otp_view.dart';

// class ChangePasswordController extends GetxController {
//   final provider = ConnectionProvider();

//   String newPassword = "";
//   Timer? timer;
//   final enableResend = RxBool(false);
//   final isLoading = RxBool(false);

//   int remainingSecoends = 1;
//   final time = '00:00'.obs;

//   get formKey => null;

//   void startTimer(int secoends) {
//     debugPrint("In Timer");
//     const duration = Duration(seconds: 1);
//     remainingSecoends = secoends;
//     timer = Timer.periodic(duration, (Timer timer) {
//       if (remainingSecoends == 0) {
//         enableResend.value = true;
//         timer.cancel();
//       } else {
//         int minute = remainingSecoends ~/ 60;
//         minute = minute % 60;
//         int secoends = remainingSecoends % 60;
//         time.value =
//             "${minute.toString().padLeft(2, "0")}:${secoends.toString().padLeft(2, "0")}";
//         remainingSecoends--;
//       }
//     });
//   }

//   Future<void> forgotPassword() async {
//     isLoading.value = true;
//     var result = await forgotPasswordApiCall();
//     isLoading.value = false;
//     if (result?.isSuccess == true) {
//       Get.to(
//         () => OTPView(
//           onAuthentificated: () {},
//         ),
//         binding: OTPBinding.forgotPassword(email),
//         opaque: false,
//       );
//     } else {
//       showMsg(
//         (result?.message ?? []).isNotEmpty ? result!.message[0] : 'Error',
//         color: Colors.red,
//       );
//     }
//   }

//   Future<ServerResponseModel?> forgotPasswordApiCall() async {
//     var result = await provider.forgotPassword(email);
//     return result;
//   }

//   @override
//   void onClose() {
//     timer?.cancel();
//     super.onClose();
//   }
// }
