import 'package:flutter/material.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class LoginScreen extends StatelessWidget
{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();


    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                  suffixIcon: Icons.visibility_outlined,
                  suffixPressed: (){},
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
                defaultButton(
                  onPressed: (){},
                  text: 'login',
                  isUpperCase: true,
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
                          navigateTo(context, const RegisterScreen());
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
    );
  }
}
