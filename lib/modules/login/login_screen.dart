import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_cubit/cubit.dart';
import 'package:shop_app/modules/login/login_cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:toast/toast.dart';


// ignore: must_be_immutable
class LoginScreen extends StatelessWidget
{
  LoginScreen({super.key});
  var formKey = GlobalKey <FormState> ();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    ToastContext().init(context);

    return BlocProvider(

      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer <LoginCubit, LoginStates>(
        listener: (context, state)
        {
          if (state is LoginSuccessState)
            {
              if (state.loginModel.status)
              {
                CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value)
                {
                  token = state.loginModel.data!.token;
                  navigateAndFinish(context, const ShopLayout());
                }
                );
                if (kDebugMode)
                {
                  print(state.loginModel.message);
                  print(state.loginModel.data!.token);
                }
                Toast.show(state.loginModel.message, duration: Toast.lengthLong, gravity:  Toast.bottom, backgroundColor: Colors.green);
              }
              else
                {
                  if (kDebugMode)
                  {
                    print(state.loginModel.message);
                  }
                  Toast.show(state.loginModel.message, duration: Toast.lengthLong, gravity:  Toast.bottom, backgroundColor: Colors.red);
                }
            }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'Please, Enter your Email Address';
                          }
                          return null;
                        },
                        labelText: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 17.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffixIcon: LoginCubit.get(context).suffix,
                        onFieldSubmitted: (value)
                        {
                          if (formKey.currentState!.validate())
                          {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        isPassword: LoginCubit.get(context).isPasswordShown,
                        suffixPressed: ()
                        {
                          LoginCubit.get(context).changePasswordVisibility();
                        },
                        validate: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'Password should not be Empty';
                          }
                          return null;
                        },
                        labelText: 'Password',
                        prefixIcon: Icons.lock_outline,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => defaultButton(
                          onPressed: ()
                          {
                            if (formKey.currentState!.validate())
                            {
                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          text: 'login',
                          isUpperCase: true,
                        ),
                        fallback: (context) => const Center(child: CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 17.0,
                      ),
                      Row(
                        children:
                        [
                          const Text(
                            'Don\'t have an Account?',
                          ),
                          defaultTextButton(
                            onPressed: ()
                            {
                              navigateTo(context, RegisterScreen());
                            },
                            text: 'register',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      );
  }
}
