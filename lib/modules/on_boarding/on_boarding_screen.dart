import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/componants.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;
  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

var boardController = PageController();

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> boarding = [
    OnBoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    OnBoardingModel(
      image: 'assets/images/onboard_2.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    OnBoardingModel(
      image: 'assets/images/onboard_3.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  bool last = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: () {
              submit();
            },
            text: 'SKIP',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      last = true;
                    });
                  } else {
                    setState(() {
                      last = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (last) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 800,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_outlined),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateToAndReplace(context, LoginScreen());
      }
    });
  }

  Widget buildBoardingItem(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          const SizedBox(
            height: 20,
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            model.body,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );
}
