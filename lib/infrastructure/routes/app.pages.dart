import 'package:get/get.dart';
import 'package:movie_app/presentation/pages/home/bindings/home.binding.dart';
import 'package:movie_app/presentation/pages/home/views/home.view.dart';

part 'app.routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
