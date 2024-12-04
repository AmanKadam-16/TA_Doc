import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mta/screens/LoginPage.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final context = SecurityContext.defaultContext;
  context.allowLegacyUnsafeRenegotiation = true;
  //final httpClient = HttpClient(context: context);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  // @override
  //Widget build(BuildContext context) => MaterialApp(home: Login());
  //MyApp({super.key});
  final navigatorKey = GlobalKey<NavigatorState>();
  final today = DateUtils.dateOnly(DateTime.now());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return /*SessionTimeOutListner(
        duration: const Duration(seconds: 180),
        onSessionTimeOut:()
        {
          print("TimeOut");
          //navigatorKey.currentState?.pushNamedAndRemoveUntil(
          //    Login(), //Add NewLogin (route) => false);
          navigatorKey.currentState?.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login(),) //Master Employee Dashboard
            ,(route) => false,);


        },
        child:*/MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'MTA',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          home:  LoginPage(),
    //    )
    );

  }
}
