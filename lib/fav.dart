
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:untitled2/models/favmodel.dart';

import 'package:untitled2/modules/login/cubit/shop-layout-cubit.dart';
import 'package:untitled2/modules/login/cubit/shop-layout-states.dart';
import 'package:untitled2/shared/components.dart';
class FavoritesScreen extends StatelessWidget
{  static int counter=0;
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {},

      builder: (context, state)
      {
        return Conditional.single(
          context: context,
          conditionBuilder: (BuildContext context) =>
         state is! ShopErrorGetFavoritesState &&ShopCubit.get(context).favoritesModel!=null,
          //  ShopCubit.get(context).favoritesModel.data.data.length %1==0,
          //false,
       //   ShopCubit.get(context).favoritesModel.data.data.length !=null,
        //  state is! ShopLoadingGetFavoritesState,
            widgetBuilder: (BuildContext context) => ListView.separated(
            itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favoritesModel.data.data[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:
            ShopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallbackBuilder: (context) => Center(child:noitem()),
      //    CircularProgressIndicator()),
        );
      },
    );
  }
Widget noitem()=>
Center(
  child:   Container(

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
//Icon(icon)
    Icon(
    Icons.add,
    color: Colors.grey,
    size: 90.0,
    semanticLabel: 'no fav items',
  ),

Text(
  'No Favourite Items',
  style: TextStyle(
    color: Colors.grey,
    fontSize: 30.0,
  ),

)




     //   IconButton(
        //  iconSize: 90.0,
         // onPressed: ()
         // {


        //  },
         // icon: CircleAvatar(
          //  radius: 70.0,

            //child: Icon(
             // Icons.add,
              //size: 60.0,
              //color: Colors.green,
           // ),
       //   ),
      //  ),



      ],
    ),
  ),
);













  Widget buildFavItem(FavoritesData model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:
            [
              Image(
                image: NetworkImage(model.product.image),
                width: 120.0,
                height: 120.0,
              ),
              if (model.product.discount != 0)
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
                  model.product.name,
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
                      model.product.price.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (model.product.discount != 0)
                      Text(
                        model.product.oldPrice.toString(),
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.product.id);

                        counter=ShopCubit.get(context).favoritesModel.data.data.length;


                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                        ShopCubit.get(context).favourites[model.product.id]==true
                            ? Colors.blueAccent
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
}





















