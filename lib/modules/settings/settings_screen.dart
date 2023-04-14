import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../cubit/states.dart';
import '../../shared/components/constants.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget
{
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  SettingsScreen({super.key});
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer <ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var model = ShopCubit
            .get(context)
            .userModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit
              .get(context)
              .userModel != null,
          builder: (context) =>
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Name must not be Empty';
                        }
                        return null;
                      },
                      labelText: 'Name',
                      prefixIcon: Icons.person,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Email must not be Empty';
                        }
                        return null;
                      },
                      labelText: 'Email Address',
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Number must not be Empty';
                        }
                        return null;
                      },
                      labelText: 'Phone Number',
                      prefixIcon: Icons.phone,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        onPressed: ()
                        {
                          signOut(context);
                        },
                        text: 'Logout',
                    ),
                  ],
                ),
              ),
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}