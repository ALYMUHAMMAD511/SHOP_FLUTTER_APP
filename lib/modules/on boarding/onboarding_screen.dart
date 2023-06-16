import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}
// ignore: must_be_immutable
class OnboardingScreen extends StatefulWidget
{
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
{
  var boardController = PageController();
  bool isLast = false;
  List <BoardingModel> boarding =
  [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    );
    navigateAndFinish(
      context,
      LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ShopCubit.get(context).isDark ? HexColor('333739') : Colors.white,
      appBar: AppBar(
        actions:
        [
          defaultTextButton(
              onPressed: ()
              {
                submit();
              },
              text: 'SKIP',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index)
                {
                  if (index == boarding.length - 1)
                    {
                      setState(()
                      {
                        isLast = true;
                      });
                      if (kDebugMode)
                      {
                        print('Last');
                      }
                    }
                  else
                    {
                      setState(()
                      {
                        isLast = false;
                      });
                      if (kDebugMode)
                      {
                        print('Not Last');
                      }
                    }
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children:
              [
                SmoothPageIndicator(
                  controller: boardController,
                  effect:  const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5.0,
                    expansionFactor: 4,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if (isLast)
                    {
                      submit();
                    }
                    else
                      {
                        boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                  },
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image: AssetImage(model.image),
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: TextStyle(
          fontSize: 26.0,
          color: ShopCubit.get(context).isDark ? Colors.white : Colors.black,
        ),
      ),
      Text(
        model.body,
        style: TextStyle(
          fontSize: 15.0,
          color : ShopCubit.get(context).isDark ? Colors.white : Colors.black,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
    ],
  );
}