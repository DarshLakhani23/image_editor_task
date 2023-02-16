import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_editor/utils/navigation/routes.dart';

class ImageEditorApp extends StatelessWidget {
  const ImageEditorApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.home,
      getPages: Routes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
