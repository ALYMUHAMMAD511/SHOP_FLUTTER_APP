import 'package:flutter/material.dart';

Widget mySeparator() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  TextInputType? type,
  bool isPassword = false,
  VoidCallback? onTap,
  void Function(String)? onChange,
  final FormFieldValidator<String>? validate,
  required String labelText,
  required IconData? prefixIcon,
  IconData? suffixIcon,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onChanged: onChange,
  onTap: onTap,
  validator: validate,
  decoration: InputDecoration(
    border: const OutlineInputBorder(),
    labelText: labelText,
    prefixIcon: Icon(prefixIcon),
    suffixIcon: Icon(suffixIcon),
  ),
);

void navigateTo(context, widget)
{
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget)
  );
}