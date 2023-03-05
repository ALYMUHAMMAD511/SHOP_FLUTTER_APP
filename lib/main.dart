import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'modules/on boarding/onboarding_screen.dart';

void main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  late Widget widget;
  String? token = CacheHelper.getData(key: 'token');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  if (kDebugMode)
  {
    print(onBoarding);
  }
  if(onBoarding != null)
    {
      if(token != null)
      {
        widget = const ShopLayout();
      }
      else
        {
          widget = LoginScreen();
        }
    }
  else
  {
    widget = const OnboardingScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.startWidget});
  late final Widget startWidget;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      // themeMode: LoginCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
      home: startWidget,
    );
  }
}