import 'package:get/get.dart';
import 'package:movie_app/presentation/pages/home/controllers/home.controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}