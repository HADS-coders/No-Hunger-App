import 'package:NoHunger/constants.dart';
import 'package:NoHunger/screens/homescreen.dart';
import 'package:NoHunger/screens/loginscreen.dart';
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
          'No Hunger aims to provide food for the needy\n across the globe so that they dont have\n to sleep empty stomach',
      'img': 'assets/images/img1.jpg'
    },
    {
      'title': 'assets/images/logo01.png',
      'text':
          'Food provided by us is well nurished with all nutrients so that everyone can live a healty life.',
      'img': 'assets/images/img2.png'
    },
    {
      'title': 'assets/images/logo01.png',
      'text': 'Each of your donation are fully utilised to help needy. ',
      'img': 'assets/images/img3.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(boardings[index]['title']),
                      Text(
                        boardings[index]['text'],
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Image.asset(
                          boardings[index]['img'],
                          width: screenWidth(context) - 20,
                        ),
                      ),
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
                  TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.white)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'Login',
                      ),
                    ),
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
                                      ? pColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(20)),
                            )),
                  ),
                  TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.white)),
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
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Text(
                          '${currentIndex <= 1 ? 'Next' : 'Done'}',
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
