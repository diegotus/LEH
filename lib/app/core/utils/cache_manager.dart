import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static CacheManager profilCacheManager = CacheManager(
    Config(
      "profil_picture",
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 1,
    ),
  );
  static CacheManager peopleCacheManager = CacheManager(
    Config(
      "people_picture",
      stalePeriod: const Duration(days: 1),
      maxNrOfCacheObjects: 50,
    ),
  );
  static cleanCache() async {
    await profilCacheManager.emptyCache();
    await peopleCacheManager.emptyCache();
  }
}
