import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_editor/helper/snackbar_helper.dart';
import 'package:image_editor/modules/controller/home_controller.dart';
import 'package:image_editor/utils/app_colors.dart';
import 'package:image_editor/utils/size_utils.dart';
import 'package:image_editor/utils/strings_utils.dart';
import 'package:image_editor/widget/app_text.dart';
import 'package:image_editor/widget/custom_appBar.dart';
import 'package:image_editor/widget/custom_button.dart';
import 'package:image_editor/widget/custom_dialog.dart';
import 'package:image_editor/widget/mybehavior.dart';
import 'package:screenshot/screenshot.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());

  /// screenshotSaver

  @override
  Widget build(BuildContext context) {
    SizeUtils().init(context);
    return Scaffold(
      appBar: CustomAppBar(
        backGroundColor: AppColors.black,
        automaticallyImplyLeading: false,
        title: AppText(
          text: AppString.home,
          color: AppColors.white,
        ),
        action: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: SizeUtils.horizontalBlockSize * 3),
            child: CustomButton(
              onTap: () {
                if (homeController.imagePath.value.isEmpty) {
                  AppSnackBar.showErrorSnackBar(
                    message: AppString.error,
                    title: AppString.pleaseSelectedImage,
                  );
                } else {
                  homeController.screenshotSaver(context: context);
                }
              },
              text: AppString.save,
              buttonColor: AppColors.white,
              textColor: AppColors.black,
            ),
          ),
          SizedBox(
            width: SizeUtils.horizontalBlockSize * 5,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.transparent,
        backgroundColor: AppColors.black,
        onPressed: () async {
          await addTextDialog(
            message: AppString.addText,
            updateButton: () {
              homeController.text.value = homeController.textEditingController.text;
              homeController.newTextEditingController.add(
                TextEditingController(
                  text: homeController.text.value,
                ),
              );
              Get.back();
              homeController.textEditingController.clear();
            },
            textEditingController: homeController.textEditingController,
          );
        },
        child: Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
      body: Obx(
        () => ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                homeController.imagePath.value.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeUtils.horizontalBlockSize * 5,
                          vertical: SizeUtils.horizontalBlockSize * 5,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.black,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              SizeUtils.horizontalBlockSize * 30,
                            ),
                            child: CustomButton(
                              width: SizeUtils.horizontalBlockSize * 40,
                              onTap: () async {
                                await homeController.pickImage();
                              },
                              text: AppString.addImage,
                              buttonColor: AppColors.black,
                              textColor: AppColors.white,
                            ),
                          ),
                        ),
                      )
                    : imageFile(
                        imagePath: homeController.imagePath.value,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// imageFile
  Widget imageFile({required String imagePath}) {
    return Stack(
      children: [
        Screenshot(
          controller: homeController.screenshotController,
          child: Stack(
            children: [
              Image.file(
                File(imagePath),
              ),
              NHomePage()
            ],
          ),
        ),
        Positioned(
          right: SizeUtils.horizontalBlockSize * 5,
          top: SizeUtils.horizontalBlockSize * 3,
          child: GestureDetector(
            onTap: () {
              homeController.imagePath.value = "";
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.close,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class NHomePage extends StatelessWidget {
  final HomeController homeController = Get.find();

  NHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    homeController.offSetList.add(const Offset(10, 10));
    return GestureDetector(
        onTap: () {
          homeController.selectedIndex.value = 10000000000;
        },
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.height / 2,
                child: Stack(
                  children: [
                    for (var index = 1; index < homeController.newTextEditingController.length; index++)
                      Obx(
                        () => Positioned(
                          left: homeController.offSetList[index].dx,
                          top: homeController.offSetList[index].dy,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              homeController.offSetList[index] = Offset(
                                  homeController.offSetList[index].dx + details.delta.dx,
                                  homeController.offSetList[index].dy + details.delta.dy);
                            },
                            onTap: () {
                              homeController.selectedIndex.value = index;
                            },
                            onLongPress: () async {
                              await addTextDialog(
                                message: AppString.addText,
                                updateButton: () {
                                  homeController.text.value = homeController.textEditingController.text;
                                  homeController.newTextEditingController.add(
                                    TextEditingController(
                                      text: homeController.text.value,
                                    ),
                                  );
                                  Get.back();
                                  homeController.textEditingController.clear();
                                },
                                textEditingController: homeController.textEditingController,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: homeController.selectedIndex.value == index
                                      ? AppColors.white
                                      : Colors.transparent,
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AppText(
                                    text: homeController.newTextEditingController[index].text,
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.normal,
                                    fontSize: SizeUtils.fSize_20(),
                                    color: AppColors.black,
                                    // textScaleFactor: homeController.scaleFactor.value,
                                  )),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ), // child: Stack(
            ),
          ),
        ));
  }
}
