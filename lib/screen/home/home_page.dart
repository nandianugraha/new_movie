import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_movie_flutter/core/base/base_view.dart';
import 'package:new_movie_flutter/core/base/page_state.dart';
import 'package:new_movie_flutter/core/values/app_colors.dart';
import 'package:new_movie_flutter/data/model/upcoming_response.dart';
import 'package:new_movie_flutter/screen/home/home_controller.dart';
import 'package:new_movie_flutter/util/constant.dart';
import 'package:new_movie_flutter/widget/custom_app_bar.dart';

class HomePage extends BaseView<HomeController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: 'HOMEPAGE',
      isBackButtonEnabled: true,
    );
  }

  Widget _buildScreen() {
    return controller.pageState == PageState.LOADING
        ? Container()
        : GridView.count(
            crossAxisCount: 2,
            children: List.generate(controller.mListResult!.length, (index) {
              return _content(controller.mListResult![index]);
            }));
  }

  Widget _content(Results model) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          child: Card(
            child: Column(
              children: [
                Image.network(
                  '$BASE_IMAGE${model.backdropPath}',
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: 5),
                Text('${model.title}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${model.releaseDate}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(
            maxRadius: 20,
            backgroundColor: AppColors.appBarColor,
            foregroundColor: Colors.white,
            child: Text('${model.voteAverage}',
                style: const TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      body: Obx(() => _buildScreen()),
    );
  }
}
