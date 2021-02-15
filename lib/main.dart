import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/home_screen.dart';
import 'package:food_project/admin/screens/add_meal/cubit/cubit.dart';
import 'package:food_project/layout/cubit/cubit.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/login/cubit/cubit.dart';
import 'package:food_project/screens/sign_up/cubit/cubit.dart';
import 'package:food_project/screens/welcome/welcome_screen.dart';
import 'package:food_project/shared/network/local/local.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  var widget;

  await initpref().then((value)
  {
    if (getToken() != null && getToken().length > 0)
    {
      if(getToken()=='rMsp0UG3VnUb8KVMeNoRgHMK7em2'){
        widget = AdminHomeScreen();
      }
      else{
        widget = LayoutScreen() ;
      }

    }
    else
    {
      widget = WelcomeScreen() ;
    }
  });


  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  var widget;

  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) => SignUpCubit(),
        ),

        BlocProvider(
          create: (context) => LoginCubit(),
        ),

        BlocProvider(
          create: (context) => AddMealCubit(),
        ),

        BlocProvider(
          create: (context) => LayoutCubit(),
        ),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food APP',
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          accentColor: Colors.orange,
          scaffoldBackgroundColor: Colors.grey[200],
        ),
        home: widget,
      ),
    );
  }
}


