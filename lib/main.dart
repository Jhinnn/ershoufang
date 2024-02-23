import 'dart:io';

import 'package:ershoufang/page/ershoufang.dart';
import 'package:ershoufang/sql/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper().getDb();
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(1080, 760),
      center: false,
      skipTaskbar: true,
      title: '二手房',
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '二手房',
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        fontFamily: 'sanjiyunlvti',
          brightness: Brightness.light,
          textTheme: const TextTheme(
              titleSmall: TextStyle(fontSize: 12, color: AppColors.goodColor, fontWeight: FontWeight.normal),
              labelSmall: TextStyle(fontSize: 12, color: Color.fromARGB(255, 105, 102, 102), fontWeight: FontWeight.normal),
              labelMedium: TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.normal),
              titleMedium: TextStyle(fontSize: 14, color: Color.fromARGB(255, 30, 29, 29),fontWeight: FontWeight.normal),
              titleLarge: TextStyle(fontSize: 18, color: Colors.white)),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.goodColor,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          ),
          appBarTheme: const AppBarTheme(backgroundColor: AppColors.goodColor, titleTextStyle: TextStyle(color: Colors.white, fontSize: 22)),
          textButtonTheme: TextButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey), foregroundColor: MaterialStateProperty.all<Color>(Colors.white))),
          scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all<Color>(AppColors.goodColor), thickness: MaterialStateProperty.all<double>(2), thumbVisibility: MaterialStateProperty.all<bool>(false))),
      home: const ErShouFangPage(),
    );
  }
}
