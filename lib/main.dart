import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage_pro/get_storage_pro.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sizing/sizing.dart';

import 'app/controllers/app_services_controller.dart';
import 'app/core/utils/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';
import 'ht_localisations/delegates.dart';
import 'main.reflectable.dart';

Future<void> _onInit() async {
  initializeReflectable();

  initializeDateFormatting("fr");
  // Initialize GetStoragePro (call this before using any GetStoragePro functionality)
  await GetStoragePro.init();
  await GetStorage.init("appKeys");
  Bind.put<AppServicesController>(AppServicesController());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _onInit();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizingBuilder(
        baseSize: const Size(430, 932),
        builder: () {
          return GetMaterialApp(
            title: "Loterie de l'etat Haïtien",
            theme: theme,
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            scrollBehavior: MyCustomScrollBehavior(),
            locale: const Locale('fr'),
            supportedLocales: const <Locale>[Locale('fr'), Locale('ht')],
            fallbackLocale: const Locale("fr"),
            // defaultTransition: Transition.fade,
            translationsKeys: AppTranslation.translations,
            localizationsDelegates: [
              ...GlobalMaterialLocalizations.delegates,
              ...HTLocalizations.delegates
            ],
          );
        });
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
