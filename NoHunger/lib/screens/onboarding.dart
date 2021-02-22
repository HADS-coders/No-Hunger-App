import 'package:NoHunger/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var currentIndex = 0;
  var controller = PageController();
  var boardings = [
    {
      'title': 'assets/images/logo01.png',
      'text':
          'No Hunger aims to provide food for the needy\n across the globe so that they dont have\n to sleep empty stomach'
    },
    {
      'title': 'assets/images/logo.png',
      'text': 'No Hunger aims to provide food for the needy'
    },
    {
      'title': 'assets/images/logo.png',
      'text': 'No Hunger aims to provide food for the needy across the globe'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                width: double.infinity,
                child: PageView.builder(
                  controller: controller,
                  onPageChanged: (index) {
                    currentIndex = index;
                    setState(() {});
                  },
                  itemCount: boardings.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Image.asset(boardings[index]['title']),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Text(
                        boardings[index]['text'],
                        textAlign: TextAlign.center,
                      ),
                      // Image.network(
                      //     'https://image.shutterstock.com/image-vector/volunteer-help-people-idea-charity-260nw-1620633370.jpg'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () {},
                    child: Text('Login'),
                  ),
                  Row(
                    children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                              duration: Duration(milliseconds: 250),
                              margin: EdgeInsets.all(2),
                              height: 8,
                              width: index == currentIndex ? 20 : 8,
                              decoration: BoxDecoration(
                                  color: index == currentIndex
                                      ? Colors.orange
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(20)),
                            )),
                  ),
                  FlatButton(
                      splashColor: Colors.transparent,
                      onPressed: () async {
                        if (currentIndex <= 1) {
                          controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.linear);
                        } else {
                          SharedPreferences _pref =
                              await SharedPreferences.getInstance();
                          await _pref.setBool('visited', true);
                          //navigate to home screen
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                      },
                      child: Text('${currentIndex <= 1 ? 'Next' : 'Done'}'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
