import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_view.dart';
import 'package:new_movie_flutter/screen/home/home_controller.dart';
import 'package:new_movie_flutter/widget/custom_app_bar.dart';

class HomePage extends BaseView<HomeController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: 'Repository details',
      isBackButtonEnabled: true,
    );
  }

  @override
  Widget body(BuildContext context) {
    return const Center(child: Text('HOMEPAGE'));
  }
}
