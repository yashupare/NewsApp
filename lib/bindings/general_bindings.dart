import 'package:get/get.dart';
import 'package:inbrief/utils/helpers/network_manager.dart';

import '../screens/profile/widgets/theme_controller.dart';

class GeneralBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => ThemeController());
    Get.put(NetworkManager());

  }
}