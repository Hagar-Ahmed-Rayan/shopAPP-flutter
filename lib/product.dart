
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:untitled2/models/categorries.dart';
import 'package:untitled2/models/home-model.dart';
import 'package:untitled2/models/login-model.dart';
import 'package:untitled2/modules/login/cubit/shop-layout-cubit.dart';
import 'package:untitled2/modules/login/cubit/shop-layout-states.dart';
import 'package:untitled2/shared/components.dart';
/*import 'package:marketapp/models/categories.dart';
import 'package:marketapp/models/home-odel.dart';
import 'package:marketapp/modules/login/cubit/shoplayout-cubit.dart';
import 'package:marketapp/modules/login/cubit/shoplayout-state.dart';
import 'package:marketapp/shared/components.dart';*/
class ProductsScreen extends StatelessWidget
{
  bool flag=false;
  @override
  Widget build(BuildContext context) {

    //  var color= flag?Colors.grey;
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {
        if(state is  ShopSuccessChangeFavoritesState){
          print("finnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
          if(!state.model.status){
            showToast( text:state.model.message, state:ToastStates.ERROR );




          }
        }







      },
      builder: (context, state) {

        return  Conditional.single(
//
          context: context,

          conditionBuilder: (BuildContext context) =>ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel!= null,

          widgetBuilder: (BuildContext context) =>builderWidget(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context,flag),
          fallbackBuilder: (BuildContext context) =>Center(child: CircularProgressIndicator()
          ),




        );
      },
    );
  }




  Widget builderWidget(HomeModel model,CategoriesModel categoriesModel,context,bool flag) => SingleChildScrollView(

    physics: BouncingScrollPhysics(),
    child: Column(
      children:
      [
        CarouselSlider(
          items: model.data.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
          ),).toList(),
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(height: 10,),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data.data[index]),
                  separatorBuilder: (context, index) => SizedBox(

                    width: 10.0,
                  ),
                  itemCount: categoriesModel.data.data.length,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),









        Container(

          color:Colors.grey[300],

          child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),

              crossAxisCount:2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1/1.75,
              children:List.generate(
                  model.data.products.length,
                      (index) => bulidGridProduct( model.data.products[index],context, flag) )

          ),
        )
      ],
    ),
  );





  Widget buildCategoryItem( DataModel  model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image(
        image: NetworkImage(model.image),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8,),
        width: 100.0,
        child: Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );



  Widget bulidGridProduct(ProductModel model,context, bool flag) =>

      Container(

        color:Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(image: NetworkImage(model.image),
                  width:double.infinity,
                  height: 200,

                ),
                if(model.discount !=0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0,),
                    child: Text(
                      'discount',
                      style:TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,

                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
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
                  Row(


                    children: [


                      Text(
                        '${ model.price.round()}',



                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if(model.discount !=0)
                        Text(
                          '${ model.oldPrice.round()}',



                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),

                      //if (ShopCubit.get(context).favourite [model.id]==true )
                      // flag= true;
//  else
                      //flag= false;

                      IconButton(




                        icon: CircleAvatar(
                          radius:15,
                          backgroundColor:// flag?Colors.blueAccent:Colors.grey,
                          ShopCubit.get(context).favourites[model.id]==true  ?Colors.blueAccent:Colors.grey,





  child:Icon(

                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                             ShopCubit.get(context).changeFavorites(model.id);
                            print("666666666666666666666666666666666666666666666666666666666");
                             ShopCubit.get(context).userModel.data.email;

                             print("77777777777777777777777777777777777777777777");

                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],

        ),
      );




}

