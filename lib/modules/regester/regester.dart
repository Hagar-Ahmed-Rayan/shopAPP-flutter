import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled2/modules/regester/cubit-regester/cubit-regester.dart';
import 'package:untitled2/modules/regester/cubit-regester/states-regester.dart';
import 'package:untitled2/shared/components.dart';
import 'package:untitled2/shared/consts.dart';
import 'package:untitled2/shared/network/local/cache-helper.dart';
import 'package:untitled2/shop-layout.dart';

class ShopRegisterScreen extends StatelessWidget
{

  GlobalKey<FormState> formKey  = GlobalKey<FormState>(debugLabel: 'regester');
//  var formKey = GlobalKey<FormState>();
  //var formKey = RIKeys.form1;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
 var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state)
        {
          if (state is ShopRegisterSuccessState)
         {print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
            if (state.loginModel.status)
            {
              print(state.loginModel.data.email);
              print(state.loginModel.data.name);
              showToast(text: state.loginModel.message, state:ToastStates.SUCCESS);
print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiisuccss");
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value)
              {
                token = state.loginModel.data.token;

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => shop()),
                );

              });
            } else {
              print(state.loginModel.message);
              showToast(text: state.loginModel.message, state:ToastStates.WARNING);
              print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiifall");
            }
         }

















          else if (state is ShopRegisterErrorState)  {
            print("in ERORRRRRRRRRRRR STATE");

         //   showToast(text: ShopRegisterCubit., state:ToastStates.ERROR );





          }



        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(

                    key:
                 //   RIKeys.form1,
                    formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
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
                          height: 15.0,
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
                          height: 15.0,
                        ),






                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText:   ShopRegisterCubit.get(context).isPassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                            ),



                            suffixIcon: IconButton(
                              icon: Icon(
                                ShopRegisterCubit.get(context).suffix,
                                // Icons.panorama_fish_eye,
                              ),
                              onPressed: () {

                                ShopRegisterCubit.get(context)
                                    .changePasswordVisibility();

                              },
                            ),


                            border: OutlineInputBorder(),
                          ),







                          onFieldSubmitted: (String value) {
                            print(value);

                            //   if (formKey.currentState!.validate()) {
                            //     ShopLoginCubit.get(context).userLogin(
                            //   email: emailController.text,
                            //    password: passwordController.text,
                            //   );
                            //  }

                          },





                          //   suffixPressed: () {
                          //    ShopLoginCubit.get(context)
                          //     .changePasswordVisibility();
                          //  },
                          validator: ( value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                          },


                        ),


                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(

                          controller: phoneController,
                     //     keyboardType:  TextInputType.phone,


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
                          height: 30.0,
                        ),
                        Conditional.single(
                          context: context,
                          conditionBuilder: (BuildContext context) => state is! ShopRegisterLoadingState,
                          widgetBuilder: (BuildContext context) =>




                              MaterialButton(
                                onPressed: () {


                                  if (formKey.currentState!.validate())
                                  {
                                    ShopRegisterCubit.get(context).userRegister(

                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                child: Text(
                                  'register',

                                  style: TextStyle(
                                    color: Colors.blueAccent,

                                  ),
                                ),
                              ),






                          fallbackBuilder: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

