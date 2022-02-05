
/*import 'package:marketapp/login.dart';
import 'package:marketapp/shared/components.dart';
import 'package:marketapp/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; */

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled2/shared/components.dart';
import 'package:untitled2/shared/styles/color.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}





class OnBording extends StatefulWidget {
  //const OnBording({Key? key}) : super(key: key);
  @override
  _OnBordingState createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  var boardController = PageController();

  bool isLast = false;
  int indexx =0;
  List<BoardingModel> boarding = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('log in'),
        actions: [
          TextButton(
            onPressed: () {
              submit(context);

              //   Navigator.push(
              //   context,
              //     MaterialPageRoute(builder: (context) => Login()),
              //   );







            },
            child: Text(
              'skip',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],

      ),
      body:Column(


        children: [
          Expanded(
            child: PageView.builder(

              onPageChanged: (i) {

                if (i == boarding.length - 1) {
                  setState(() {

                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },













              itemBuilder:(context,index) => bulidbordingitem(boarding[index]),
              controller:boardController ,
              itemCount:boarding.length,
              physics: BouncingScrollPhysics(),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            children: [
              //  Text('indicator'),
              SmoothPageIndicator(

                controller: boardController,

                onDotClicked:(int index) {
                  print('hhhhhhhhhhhhhhhhh');
                  print(index);
                  if (indexx == boarding.length - 1) {
                    setState(() {

                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },






                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: defaultColor,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5.0,

                ),
                count: boarding.length,
              ),

















              Spacer(),
              FloatingActionButton(onPressed: (){

                if(isLast){
                  print('uuuuuuuuuuuuuuuuuuuuuuu');
                  submit(context);
                }
                else {

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
              )


            ],
          )
        ],


      ),
    );
  }

  Widget bulidbordingitem(BoardingModel model)=>Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Image(image: AssetImage('${model.image}')),
      SizedBox(height: 30,),
      Text('${model.title}',style: TextStyle(
        fontSize: 24.0,
        fontWeight:FontWeight.bold,

      )),
      SizedBox(height: 15,),
      Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight:FontWeight.bold,

          )),


    ],


  );
}
