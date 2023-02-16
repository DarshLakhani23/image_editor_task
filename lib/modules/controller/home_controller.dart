import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_editor/helper/snackbar_helper.dart';
import 'package:image_editor/utils/app_colors.dart';
import 'package:image_editor/utils/strings_utils.dart';
import 'package:screenshot/screenshot.dart';

class HomeController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  List<TextEditingController> newTextEditingController = <TextEditingController>[];
  RxList<Offset> offSetList = <Offset>[].obs;
  RxList<bool> data = <bool>[].obs;
  RxInt selectedIndex = (-1).obs;
  ScreenshotController screenshotController = ScreenshotController();
  RxString text = ''.obs;

  ///
  RxString imagePath = ''.obs;
  File? value;

  ///pick image from gallery
  Future<void> pickImage() async {
    try {
      var result = (await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      ));

      if (result != null) {
        imagePath.value = result.files.single.path.toString();
        _cropImage(pickedFile: File(imagePath.value));
        update();
      } else {
        log('No image selected.');
      }
    } catch (e) {
      log("error in filePick image---->${e.toString()}");
    }
  }

  /// _cropImage
  Future<String> _cropImage({required File pickedFile}) async {
    if (kDebugMode) {
      print("pickedFile : ${pickedFile.path}");
    }
    if (pickedFile.path.isNotEmpty) {
      final croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
          ],
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              toolbarColor: AppColors.white,
              toolbarTitle: "genie cropper",
            ),
          ]);
      if (kDebugMode) {
        print("croppedFile?.path --> ${croppedFile?.path}");
      }
      imagePath.value = croppedFile?.path ?? '';
    }
    return '';
  }

  /// screenshotSaver
  Future<void> screenshotSaver({required BuildContext context}) async {
    await screenshotController.capture(delay: const Duration(microseconds: 50)).then(
      (capturedImage) async {
        if (capturedImage != null) {
          const screenshotDirectory = '/storage/emulated/0/DCIM/Screenshots';
          final imagepath =
              await File('$screenshotDirectory/image_${DateTime.now().millisecond}.png').create(recursive: true);

          await imagepath.writeAsBytes(capturedImage);

          imagePath.value = "";
          newTextEditingController.clear();

          AppSnackBar.showErrorSnackBar(
            message: AppString.imageMsg,
            title: AppString.imageSaved,
          );
        }
      },
    ).catchError((onError) {
      AppSnackBar.showErrorSnackBar(
        message: AppString.errorMsg,
        title: AppString.error,
        color: AppColors.red,
      );
    });
  }
}
