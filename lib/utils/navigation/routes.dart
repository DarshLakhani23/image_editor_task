import 'package:get/get.dart';
import 'package:image_editor/modules/screen/home_page.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  static const String home = '/home';

  static List<GetPage<dynamic>> pages = [
    GetPage<dynamic>(
      name: home,
      page: () => HomePage(),
      transition: defaultTransition,
    ),
  ];
}
