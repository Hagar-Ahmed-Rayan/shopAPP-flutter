
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:untitled2/login.dart';
import 'package:untitled2/modules/login/cubit/shop-layout-cubit.dart';
import 'package:untitled2/modules/login/cubit/shop-layout-states.dart';
import 'package:untitled2/modules/regester/cubit-regester/cubit-regester.dart';
import 'package:untitled2/shared/components.dart';
import 'package:untitled2/shared/consts.dart';

class SettingsScreen extends StatelessWidget {
  //var formk = GlobalKey<FormState>();
  GlobalKey<FormState> formKe  = GlobalKey<FormState>(debugLabel: 'setting');
 var nameController = TextEditingController();
   var emailController = TextEditingController();

  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getUserData();

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {






      },
      builder: (context, state) {

        dynamic model = ShopCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;



               //ShopCubit.get(context).userModel.data.name;
         //    emailController.text = ShopCubit.get(context).userModel.data.email;
          //  phoneController.text = ShopCubit.get(context).userModel.data.phone;





        return Conditional.single(
          context: context,
            conditionBuilder: (BuildContext context) =>//true,
            ShopCubit.get(context).userModel != null,
          widgetBuilder: (BuildContext context) =>  Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKe,
              child: SingleChildScrollView(
                child: Column(
                  children:
                  [
                    if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),

                    TextFormField(

                      controller: nameController,
                      keyboardType: TextInputType.name,

                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(
                          Icons.person,

                        ),






                        border: OutlineInputBorder(),
                      ),







                      onFieldSubmitted: (String value) {
                        print(value);


                      },


                      //   suffixPressed: () {
                      //    ShopLoginCubit.get(context)
                      //     .changePasswordVisibility();
                      //  },
                      validator: ( value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
        return null;
        },



                    ),



                    SizedBox(
                      height: 20.0,
                    ),





                    TextFormField(

                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,

                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(
                          Icons.email,

                        ),




                        border: OutlineInputBorder(),
                      ),







                      onFieldSubmitted: (String value) {
                        print(value);


                      },


                      //   suffixPressed: () {
                      //    ShopLoginCubit.get(context)
                      //     .changePasswordVisibility();
                      //  },
                      validator: ( value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }

                        return null;
                      },


                    ),


                    SizedBox(
                      height: 20.0,
                    ),



                    TextFormField(

                      controller: phoneController,
                      keyboardType:  TextInputType.phone,


                      decoration: InputDecoration(



                        labelText: 'Phone',
                        prefixIcon: Icon(
                          Icons.phone,

                        ),




                        border: OutlineInputBorder(),
                      ),







                      onFieldSubmitted: (String value) {
                        print(value);


                      },


                      //   suffixPressed: () {
                      //    ShopLoginCubit.get(context)
                      //     .changePasswordVisibility();
                      //  },
                      validator: ( value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }

                        return null;
                      },


                    ),



















                    SizedBox(
                      height: 20.0,
                    ),


                    MaterialButton(
                      onPressed: () {


        if(formKe.currentState!.validate())
        {
          ShopCubit.get(context).updateUserData(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,

       );
          print('yes');
        }


                      },
                      child: Text(
                        'update',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),


                    SizedBox(
                      height: 20.0,
                    ),

                del(context,Login ()
                ),
                 /*   MaterialButton(
                      onPressed: () {
                      //  print("666666666666666666666666666666666666666666666666666666666");
                       // ShopCubit.get(context).userModel.data.email;

                    //    print("77777777777777777777777777777777777777777777");

                      },
                      child: Text(
                          'Logout',
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),

*/





                  ],
                ),
              ),
            ),
          ),
          fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
        );

















      },
    );
  }
}

