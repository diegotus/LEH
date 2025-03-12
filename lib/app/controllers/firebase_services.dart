import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/enums.dart';
import 'package:haiti_lotri/app/data/models/storage_box_model.dart';
import 'package:haiti_lotri/app/routes/app_pages.dart';

import '../../firebase_options.dart';
import '../core/utils/web_js_function.dart';

class FirebaseServices extends GetxService {
  FirebaseServices._onInit({this.token});
  String? token;
  String get currentSubscriveTopic => StorageBox.currentSubscriveTopic.val;
  void onFcmTokenInitialize(String? value) {
    StorageBox.fmcToken.val = value ?? '';
    token = value ?? '';
  }

  void onFcmTokenUpdate(String value) {
    StorageBox.fmcToken.val = value;
    token = value;
  }

  static RemoteMessage messageModifier(RemoteMessage message) {
    return message;
  }

  bool shouldHandleNotification(RemoteMessage message) {
    var data = TransactionType.exist(message.data['type'])
        ? TransactionType.fromMap(message.data['type'])
        : null;
    if (data != null) {
      var currentPage = Get.searchDelegate(null).pageSettings?.name;
      if (data == TransactionType.lotoPlay &&
          currentPage?.startsWith(Routes.TRANSACTION_DETAILS) == true) {
        return false;
      }
    }
    return true;
  }

  void onOpenNotificationArrive(NotificationInfo notif, {bool taped = false}) {
    print("notif is opend");
    switch (notif.appState) {
      case AppState.terminated:
      case AppState.background:
        continue openNotif;
      openNotif:
      case AppState.open:
        print("notif is opend");
        if (taped) onMessage(notif.payload);
        break;
    }
  }

  void onMessage(Map<String, dynamic> message) {
    print("the new no data $message");
    var data = TransactionType.exist(message['type'])
        ? TransactionType.fromMap(message['type'])
        : null;
    switch (data) {
      case TransactionType.transfer:
      case TransactionType.lotoPlay:
      case TransactionType.lotoWin:
      case TransactionType.cash:
      case TransactionType.payment:
        Get.toNamed(Routes.TRANSACTION_DETAILS,
            parameters: {"id": message['transaction_id']});
        break;
      case null:
        break;
    }
  }

  static Future<FirebaseServices> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (!kIsWeb) {
      await FirebaseMessaging.instance.requestPermission();
      if (Platform.isAndroid) await _createChanel();
    }
    return FirebaseServices._onInit(token: '');
  }

  static Future<void> _createChanel() async {
    var channels =
        await FirebaseNotificationsHandler.getAndroidNotificationChannels();
    if (channels == null || channels.isEmpty) {
      await FirebaseNotificationsHandler
          .createAndroidNotificationChannels(const [
        AndroidNotificationChannel(
          'default',
          'Default',
          importance: Importance.high,
        ),
        AndroidNotificationChannel(
          'transfer',
          'transfer',
          importance: Importance.high,
        ),
        AndroidNotificationChannel(
          'lotoPlay',
          'lotoPlay',
          importance: Importance.low,
        ),
        AndroidNotificationChannel(
          'lotoWin',
          'lotoWin',
          importance: Importance.high,
        ),
        AndroidNotificationChannel(
          'cash',
          'cash',
          importance: Importance.high,
        ),
        AndroidNotificationChannel(
          'payment',
          'payment',
          importance: Importance.high,
        ),
      ]);
    }
  }

  Future<void> subscribeToTopic(int id) async {
    String newTopic = "_${Get.locale!.languageCode}_$id";
    if (newTopic != currentSubscriveTopic) {
      StorageBox.currentSubscriveTopic.val = newTopic;
      if (kIsWeb) {
        callServiceWorkerFunction("loterie$currentSubscriveTopic");
      } else {
        await FirebaseMessaging.instance
            .subscribeToTopic("loterie$currentSubscriveTopic");
      }
    }
  }

  Future<void> unsubscribeFromTopics() async {
    if (!kIsWeb && currentSubscriveTopic.isNotEmpty) {
      await FirebaseMessaging.instance
          .unsubscribeFromTopic("loterie$currentSubscriveTopic");
      StorageBox.currentSubscriveTopic.val = '';
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  static void _handleMessage(RemoteMessage message) {
    print("the message${message.toMap()}");
  }
}
