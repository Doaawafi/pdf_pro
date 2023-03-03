import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf_pro/screens/splash_screen.dart';




void main() {
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
        valueListenable: themeNotifier ,
        builder: (context , currentMode , child){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: currentMode,
            home: const SplashScreen(),
          );
        }
    );
  }
}



