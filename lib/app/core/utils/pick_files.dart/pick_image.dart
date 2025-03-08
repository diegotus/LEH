import 'dart:math';
import 'dart:typed_data';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haiti_lotri/app/core/utils/app_string.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mime/mime.dart';
import 'package:sizing/sizing.dart';

import '../../../data/models/document_model.dart' show FileData;
import '../app_colors.dart';
import '../app_utility.dart' show horizontalSpaceMedium, verticalSpaceRegular;

enum ImageSources { camera, gallery, file }

class PickFile {
  static Future<FileData?> imageFile({
    bool crop = false,
    int? maxFileSizeInMb,
    bool cropOnlySquare = false,
    String cropperToolbarTitle = "Crop",
    Color cropperToolbarColor = const Color.fromARGB(255, 0, 0, 0),
    Color cropperToolbarWidgetsColor = const Color.fromARGB(255, 255, 255, 255),
    required ImageSources source,
    List<String>? allowedExtensions,
    FileType? type,
    int? imageQuality,
  }) async {
    XFile? image;
    if (source == ImageSources.camera) {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: imageQuality);
    } else if (source == ImageSources.gallery) {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: imageQuality);
    } else if (source == ImageSources.file) {
      var result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: type ?? FileType.image,
          withData: true,
          allowedExtensions: allowedExtensions,
          compressionQuality: imageQuality ?? 30);
      if (result != null && result.files.isNotEmpty) {
        var first = result.files.first;
        image = first.xFile;
      }
    }
    if (image != null) {
      Uint8List bytes = await image.readAsBytes();
      String filePath = image.path;
      String? mimeType =
          image.mimeType ?? lookupMimeType(image.path, headerBytes: bytes);

      if (crop && mimeType?.startsWith("image") == true) {
        var croppedImage = await _imageCrop(
          bytes: bytes,
          cropperToolbarTitle: cropperToolbarTitle,
          cropperToolbarColor: cropperToolbarColor,
          cropperToolbarWidgetsColor: cropperToolbarWidgetsColor,
        );
        if (croppedImage != null) {
          bytes = croppedImage;
        } else {
          return null;
        }
      }
      if (filePath.isNotEmpty) {
        if (maxFileSizeInMb != null &&
            bytes.lengthInBytes > maxFileSizeInMb * 1024 * 1024) {
          return Future.error("Image must me less then $maxFileSizeInMb Mb");
        }
        FileData fileData = FileData(
          hasFile: true,
          name: image.name,
          path: filePath,
          bytes: bytes,
          mimeType:
              image.mimeType ?? lookupMimeType(image.path, headerBytes: bytes)!,
        );
        return fileData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<FileData?> file({
    int? maxFileSizeInMb,
  }) async {
    XFile? image;
    var result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true);
    if (result != null && result.files.isNotEmpty) {
      var first = result.files.first;
      image = first.xFile;
    }

    if (image != null) {
      Uint8List bytes = await image.readAsBytes();
      String filePath = image.path;

      if (filePath.isNotEmpty) {
        if (maxFileSizeInMb != null && bytes.lengthInBytes > maxFileSizeInMb) {
          return Future.error("Image must me less then $maxFileSizeInMb Mb");
        }
        FileData fileData = FileData(
          hasFile: true,
          name: image.name,
          path: filePath,
          bytes: bytes,
          mimeType: image.mimeType!,
        );
        return fileData;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  /// function image cropper
  static Future<Uint8List?> _imageCrop({
    required String cropperToolbarTitle,
    required Color cropperToolbarColor,
    required Color cropperToolbarWidgetsColor,
    required Uint8List bytes,
  }) async {
    final controller = CustomImageCropController();

    var croppedImage = await Get.bottomSheet<Uint8List>(
      SizedBox(
        child: Column(children: [
          Expanded(
            child: CustomImageCrop(
              backgroundColor: Colors.white,
              cropController: controller,

              shape: CustomCropShape.Square,
              customProgressIndicator: LoadingAnimationWidget.fourRotatingDots(
                color: AppColors.PRIMARY1,
                size: 30.ss,
              ),
              image: MemoryImage(
                bytes,
              ), // Any Imageprovider will work, try with a NetworkImage for example...
            ),
          ),
          SizedBox(
            height: 0.1.sh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: controller.reset),
                IconButton(
                    icon: const Icon(Icons.zoom_in),
                    onPressed: () =>
                        controller.addTransition(CropImageData(scale: 1.1))),
                IconButton(
                    icon: const Icon(Icons.zoom_out),
                    onPressed: () =>
                        controller.addTransition(CropImageData(scale: 0.9))),
                IconButton(
                    icon: const Icon(Icons.rotate_left),
                    onPressed: () => controller
                        .addTransition(CropImageData(angle: -pi / 4))),
                IconButton(
                    icon: const Icon(Icons.rotate_right),
                    onPressed: () =>
                        controller.addTransition(CropImageData(angle: pi / 4))),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                child: const Text('Save'),
                onPressed: () async {
                  var image = await Get.showOverlay<MemoryImage?>(
                      asyncFunction: controller.onCropImage,
                      loadingWidget: Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                          color: AppColors.PRIMARY1,
                          size: 30.ss,
                        ),
                      ));

                  Get.backLegacy(result: image?.bytes);
                  // Delete file here
                },
              ),
              horizontalSpaceMedium,
              FilledButton(
                child: Text(AppStrings.CANCEL),
                onPressed: () => Get.close(),
              ),
            ],
          ),
          verticalSpaceRegular,
        ]),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      enableDrag: false,
    );
    return croppedImage;
  }
}
