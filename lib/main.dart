import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/App_cubit/app_cubit.dart';
import 'package:news_app/App_cubit/app_states.dart';
import 'package:news_app/Shared/network/Local/shared_prefrences.dart';
import 'package:news_app/Shared/network/remote/dio_helper.dart';

import 'Layout/news_layout.dart';

void main() async {
  bool isDark = false;
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  CacheHelper.getBolean(key: "isDark") != null
      ? isDark = CacheHelper.getBolean(key: "isDark")
      : null;

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..changeMode(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode: AppCubit().get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: ThemeData(
                primarySwatch: Colors.teal,
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: HexColor("333739"),
                  unselectedIconTheme: IconThemeData(
                    color: Colors.grey,
                  ),
                  elevation: 100,
                  unselectedLabelStyle: TextStyle(color: Colors.grey),
                  selectedItemColor: Colors.teal,
                ),
                scaffoldBackgroundColor: HexColor("333739"),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.white, size: 40.0),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor("333739"),
                        statusBarBrightness: Brightness.dark),
                    backgroundColor: HexColor("333739"),
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            theme: ThemeData(
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                primarySwatch: Colors.teal,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  elevation: 100,
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  selectedItemColor: Colors.teal,
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    iconTheme: IconThemeData(color: Colors.black, size: 40.0),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarBrightness: Brightness.dark),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))),
            home: NewsScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
