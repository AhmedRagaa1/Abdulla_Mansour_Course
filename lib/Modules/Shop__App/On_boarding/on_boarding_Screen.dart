import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Modules/Shop__App/Login/ShopLogin_Screen.dart';
import 'package:flutter_app/shared/components/Components.dart';
import 'package:flutter_app/shared/network/Local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
});
}

class OnBoardingScreen extends StatefulWidget
{
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel > boarding=[
    BoardingModel(
      image: 'assets/images/onboarding1.jpg',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboarding1.jpg',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onboarding1.jpg',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  bool  islast =false;

  void Submit()
  {
    CachHelper.SaveData(key: 'onboarding', value: true,).then((value) {
      if(value)
      {
        NavigateAndFinish(context, ShopLoginScreen(),);

      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          TextButton(
              onPressed: ()
              {
                NavigateAndFinish(context, ShopLoginScreen(),);

              },
              child: Text(
                'SKIP',
              ),
          ),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index)
                {
                  if(index == boarding.length - 1)
                  {
                    setState(() {
                      islast =true;
                    });
                    print('last');
                  }else
                    {
                      print(' not last');
                      setState(() {
                        islast = false;
                      });
                    }
                },
                controller: boardController,
                  itemBuilder: (context , index) => buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children:
              [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(islast)
                      {
                        NavigateAndFinish(context, ShopLoginScreen(),);
                      }else
                        {
                          boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                    },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),

          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) =>  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      SizedBox(
        height: 15,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    ],
  );
}
