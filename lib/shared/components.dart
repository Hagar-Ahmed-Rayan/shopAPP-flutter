


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled2/login.dart';
import 'package:untitled2/modules/login/cubit/shop-layout-cubit.dart';
import 'package:untitled2/shared/network/local/cache-helper.dart';
import 'package:untitled2/shared/styles/color.dart';
//import 'package:marketapp/login.dart';
//import 'package:marketapp/shared/network/local/cache-helper.dart';

void submit( context){
  CacheHelper.saveData(key: 'onBoarding', value: true,)
      .then((value) {
    if(value){

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );








    }
  });


}



void delete(context){


  TextButton(
    onPressed: () {
      print('مسحنااااااااااااااااااااااااا');
      CacheHelper.removeData(key: 'token',).then((value){

        if(value){











          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login ()),
          );

        }


      });
    },






    child: Text(
      'sign up',
    ),
  );







}


Widget del(context,widget)=>


  TextButton(
    onPressed: () {
      print('مسحنااااااااااااااااااااااااا');
      CacheHelper.removeData(key: 'token',).then((value){

        if(value){





          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => widget,
            ),
                (route) {
              return false;
            },
          );












       //   Navigator.push(
         //   context,
        //    MaterialPageRoute(builder: (context) => Login ()),
         // );

        }


      },
      );
    },






    child: Text(
      'sign up',
    ),
  );



void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );








void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastColor(ToastStates state)
{
  Color color;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildListProduct(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                        //  ShopCubit.get(context).favourites[model.id]==true  ?Colors.blueAccent:Colors.grey,
                          ShopCubit.get(context).favourites[model.id]==true
                              ? defaultColor
                              : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
