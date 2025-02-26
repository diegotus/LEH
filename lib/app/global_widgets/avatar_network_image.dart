import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/utils.dart';
import 'package:sizing/sizing_extension.dart';

import '../core/api_helper/urls.dart';
import '../core/utils/app_utility.dart';
import '../data/models/storage_box_model.dart';

CachedNetworkImageProvider avatarImageProvider(String id, token) {
  return CachedNetworkImageProvider("${Url.BASE_URL}files?id=$id",
      headers: {"Authorization": "Bearer $token"}, errorListener: (error) {
    Get.log("the list eror $error", isError: true);
  });
}

CachedNetworkImage avatarImage(
  String? id, {
  required Widget Function(BuildContext, ImageProvider) imageBuilder,
  required Widget placeHolder,
  CacheManager? cacheManager,
}) {
  var imageUrl = id == null ? '' : "${Url.BASE_URL}files?id=$id";
  var token = StorageBox.token.val;
  return CachedNetworkImage(
    cacheManager: cacheManager,
    imageUrl: imageUrl,
    httpHeaders: {"Authorization": "Bearer $token", "Connection": "Keep-Alive"},
    imageBuilder: imageBuilder,
    progressIndicatorBuilder: (context, url, progress) {
      // if (progress.progress == 1) return SizedBox.shrink();
      return Stack(
        alignment: Alignment.center,
        children: [
          placeHolder,
          loadingAnimation(size: 20.ss),
        ],
      );
    },
    errorWidget: (context, url, error) {
      return placeHolder;
    },
    errorListener: (error) {
      Get.log("the list eror $error", isError: true);
    },
  );
}

CachedNetworkImage avatarImageExternal(
  String? url, {
  required Widget Function(BuildContext, ImageProvider) imageBuilder,
  required Widget placeHolder,
  CacheManager? cacheManager,
}) {
  var imageUrl = url ?? '';

  return CachedNetworkImage(
    cacheManager: cacheManager,
    imageUrl: imageUrl,
    imageBuilder: imageBuilder,
    progressIndicatorBuilder: (context, url, progress) {
      // if (progress.progress == 1) return SizedBox.shrink();
      return Stack(
        alignment: Alignment.center,
        children: [
          placeHolder,
          loadingAnimation(size: 20.ss),
        ],
      );
    },
    errorWidget: (context, url, error) {
      if (url.isEmpty) return placeHolder;
      return const SizedBox.shrink();
    },
    errorListener: (error) {
      Get.log("the list eror $error", isError: true);
    },
  );
}
