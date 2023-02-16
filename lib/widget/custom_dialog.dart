import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_editor/utils/app_colors.dart';
import 'package:image_editor/utils/size_utils.dart';
import 'package:image_editor/utils/strings_utils.dart';
import 'package:image_editor/widget/app_text.dart';
import 'package:image_editor/widget/custom_button.dart';

Future<void> addTextDialog({
  Function()? updateButton,
  String? message,
  TextEditingController? textEditingController,
}) {
  return showDialog<void>(
    context: Get.context!,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: AppColors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 3)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: SizeUtils.horizontalBlockSize * 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5),
              child: Center(
                child: AppText(
                  text: message ?? "",
                  fontSize: SizeUtils.fSize_28(),
                  color: AppColors.white,
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: SizeUtils.horizontalBlockSize * 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5),
              child: Container(
                width: double.infinity,
                height: SizeUtils.horizontalBlockSize * 13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SizeUtils.horizontalBlockSize * 2),
                  color: AppColors.lightWhiteColor,
                ),
                child: Center(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: textEditingController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    cursorColor: AppColors.black,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: SizeUtils.fSize_15(),
                      fontWeight: FontWeight.w600,
                    ),
                    toolbarOptions: const ToolbarOptions(copy: true, paste: true),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: AppString.enterText,
                      hintStyle: TextStyle(
                        color: AppColors.grey,
                        fontSize: SizeUtils.fSize_14(),
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: AppColors.lightWhiteColor,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeUtils.horizontalBlockSize * 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    width: SizeUtils.screenWidth / 3,
                    buttonColor: AppColors.grey,
                    text: AppString.cancel,
                    textColor: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: SizeUtils.fSize_18(),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  CustomButton(
                    width: SizeUtils.screenWidth / 3,
                    buttonColor: AppColors.white,
                    text: AppString.update,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeUtils.fSize_18(),
                    onTap: updateButton ?? () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeUtils.horizontalBlockSize * 8),
          ],
        ),
      );
    },
  );
}
