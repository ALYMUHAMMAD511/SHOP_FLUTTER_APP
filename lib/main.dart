import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'cubit/cubit.dart';
import 'modules/on boarding/onboarding_screen.dart';

void main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  late Widget widget;
  token = CacheHelper.getData(key: 'token');
  if (kDebugMode)
  {
    print(token);
  }
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
  MyApp({ required this.startWidget});
  late final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
          ),
        ],
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              debugShowCheckedModeBanner: false,
              home: startWidget,
              // onBoarding ? LoginScreen() : OnBoarding(),
            );
          },
        ),
      ),
    );
  }
}