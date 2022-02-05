
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/login.dart';
import 'package:untitled2/modules/login/cubit/shop-layout-cubit.dart';
import 'package:untitled2/modules/login/cubit/shop-layout-states.dart';
import 'package:untitled2/on-boarding.dart';
import 'package:untitled2/shared/consts.dart';
import 'package:untitled2/shared/network/local/cache-helper.dart';
import 'package:untitled2/shared/network/remote/dio-healper.dart';
import 'package:untitled2/shop-layout.dart';
/*import 'package:marketapp/SHOP-LAYOUT.dart';
import 'package:marketapp/login.dart';
import 'package:marketapp/modules/login/cubit/shoplayout-cubit.dart';
import 'package:marketapp/modules/login/cubit/shoplayout-state.dart';
import 'package:marketapp/on-boarding.dart';
import 'package:marketapp/shared/constants.dart';
import 'package:marketapp/shared/network/local/cache-helper.dart';
import 'package:marketapp/shared/network/remote/dio-healper.dart'; */

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  // Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();


// bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  dynamic onBoarding = CacheHelper.getData(key: 'onBoarding');

  print(onBoarding);
  token =  await CacheHelper.getData(key: 'token');

  print('jjjjjjjjjjjjjjjjlllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll');

  print(token);
  Widget widget;



  //String token='uu';

  if(onBoarding != null)
  {
    if(token != null) {
      widget = shop();
      print('shopppppppppp');
    }
    else {
      widget = Login();
      print('loginnnnnnnnnnn');
    }
  } else
  {
    print('on boardinggggggg');
    widget = OnBording();
  }



  runApp(MyApp( widget));
}

class MyApp extends StatelessWidget {

  final Widget startWidget;
  MyApp(this.startWidget);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [


        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit , ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            home: startWidget,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
