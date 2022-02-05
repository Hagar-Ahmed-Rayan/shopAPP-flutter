
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:untitled2/modules/login/cubit/cubit.dart';
import 'package:untitled2/modules/login/cubit/states.dart';
import 'package:untitled2/modules/regester/regester.dart';
import 'package:untitled2/shared/components.dart';
import 'package:untitled2/shared/consts.dart';
import 'package:untitled2/shared/network/local/cache-helper.dart';
import 'package:untitled2/shop-layout.dart';
/*import 'package:marketapp/SHOP-LAYOUT.dart';
import 'package:marketapp/modules/login/cubit/cubit.dart';
import 'package:marketapp/modules/login/cubit/states.dart';
import 'package:marketapp/shared/components.dart';
import 'package:marketapp/shared/constants.dart';
import 'package:marketapp/shared/constants.dart';
import 'package:marketapp/shared/network/local/cache-helper.dart'; */

class Login extends StatelessWidget {
  // const Login({Key? key}) : super(key: key);
  GlobalKey<FormState> formK  = GlobalKey<FormState>(debugLabel: 'login');
 // var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener:(context,state) {


          if (state is ShopLoginSuccessState) {
            print('yessssssssssssss');
            if (state.loginModel.status) {
              //   print(state.loginModel.message);
              // print(state.loginModel.data.token);

              //   CacheHelper.saveData(
              //  key: 'token',
              // value: state.loginModel.data.token,
              //  ).then((value) {
              // navigateAndFinish(
              // context,
              // ShopLayout(),
              //  );
              //  });



              showToast(text: state.loginModel.message, state:ToastStates.SUCCESS);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token=state.loginModel.data.token;
                navigateAndFinish(
                  context,
                    shop(),
                );
              //  Navigator.push(
               //   context,
                //  MaterialPageRoute(builder: (context) => shop()),
              //  );
              });
















            } else {
              print(state.loginModel.message);
              // print('yessssssssssssss');
              showToast(text: state.loginModel.message, state:ToastStates.WARNING );









            }
          }

          else if (state is ShopLoginErrorState)  {
            print("in else iffffffffffffffffffff");
            Fluttertoast.showToast(

              // msg: state.loginModel.status,
                msg:ShopLoginCubit.data['message'],
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            showToast(text: ShopLoginCubit.data['message'], state:ToastStates.ERROR );





          }





        },
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formK,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            //  style:// Theme.of(context).textTheme.headline4.copyWith(
                            //  color: Colors.black,
                            //  ),
                          ),
                          Text(
                            'Login now to browse our hot offers',
                            // style: Theme.of(context).textTheme.bodyText1.copyWith(
                            // color: Colors.grey,
                            //),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            validator:   (value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                            },

                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,// type: TextInputType.emailAddress,

                            decoration: InputDecoration(
                              labelText: 'Email Address',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                              ),



                              border: OutlineInputBorder(),
                            ),

                            //  validate:


                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:  ShopLoginCubit.get(context).isPassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.lock_outline,
                              ),



                              suffixIcon: IconButton(
                                icon: Icon(
                                  ShopLoginCubit.get(context).suffix,
                                  // Icons.panorama_fish_eye,
                                ),
                                onPressed: () {

                                  ShopLoginCubit.get(context)
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
                            height: 30.0,
                          ),





                          Conditional.single(
//
                            context: context,

                            conditionBuilder: (BuildContext context) =>state is! ShopLoginLoadingState,

                            widgetBuilder: (BuildContext context) => Container(
                              width: double.infinity,
                              color: Colors.blue,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formK.currentState!.validate()) {
                                    print('yes');
                                    //   ScaffoldMessenger.of(context).showSnackBar(
                                    //   const SnackBar(content: Text('Processing Data')),
                                    //);

                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );






                                  }

                                  else
                                  {print('no');}












                                  print(emailController.text);
                                  print(passwordController.text);
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),


                            fallbackBuilder: (BuildContext context) =>Center(child: CircularProgressIndicator()),


                          ),























                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                              ),
                              TextButton(
                                onPressed: () {

                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ShopRegisterScreen()),
                                  );


                                },
                                child: Text(
                                  'Register Now',
                                ),
                              ),
                            ],
                          ),
                        ]
                    ),
                  ),
                ),
              ),
            ),
          );

        } ,
      ),
    );


  }
}


























