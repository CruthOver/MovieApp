import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:movie_app/presentation/pages/home/controllers/home.controller.dart';
import 'package:movie_app/presentation/pages/home/views/widgets/main.widget.dart';
import 'package:movie_app/presentation/pages/home/views/widgets/search.widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: () async {
            if (controller.onSearch.value) {
              controller.changeSearch();
              return false;
            }
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              leading: controller.onSearch.value
                  ? IconButton(
                      onPressed: () => controller.changeSearch(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )
                  : null,
              title: controller.onSearch.value
                  ? TextField(
                      controller: controller.searchController.value,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Search Title",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 16.0,
                        ),
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    )
                  : Text(
                      "PlixMovie",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white),
                    ),
              actions: [
                controller.onSearch.value
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () {
                          controller.onSearch.toggle();
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ))
              ],
            ),
            body: !controller.onSearch.value
                ? const MainWidget()
                : const SearchWidget(),
          ),
        ));
  }
}
