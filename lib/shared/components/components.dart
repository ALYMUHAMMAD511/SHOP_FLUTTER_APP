import 'package:flutter/material.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget mySeparator() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


Widget defaultFormField(context,{
  required TextEditingController? controller,
  TextInputType? type,
  bool isPassword = false,
  required String? labelText,
  required IconData? prefixIcon,
  IconData? suffixIcon,
  final FormFieldValidator<String>? validate,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
  bool isClickable = true,
  ValueChanged<String>? onFieldSubmitted}) => TextFormField(
  style: TextStyle(
    color: ShopCubit.get(context).isDark ? Colors.white : Colors.black,
  ),
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(
      color:ShopCubit.get(context).isDark ? Colors.white: Colors.black,),
    prefixIcon: Icon(
      prefixIcon,
      color: ShopCubit.get(context).isDark ? Colors.white70: Colors.black54,
    ),
    suffixIcon: IconButton(onPressed: suffixPressed,
        icon: Icon(
          suffixIcon,
          color: ShopCubit.get(context).isDark ? Colors.white70: Colors.black54,
        )
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: ShopCubit.get(context).isDark ? Colors.white: Colors.black54,),
    ),
  ),
  onFieldSubmitted: onFieldSubmitted,
  validator: validate,
  onTap: onTap,
  enabled: isClickable,
);

Widget defaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  double radius = 3.0,
  required VoidCallback? onPressed,
  required String text,
  bool isUpperCase = true,
}) => Container(
  width: width,
  height: 50.0,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: const TextStyle(
        color: Colors.white,
          ),
        ),
      ),
);

Widget defaultTextButton({
  required VoidCallback onPressed,
  required String text,
}) => TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => widget),
  );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false);

String capitalizeAllWord(String value) {
  var result = value[0].toUpperCase();
  for (int i = 1; i < value.length; i++) {
    if (value[i - 1] == " ") {
      result = result + value[i].toUpperCase();
    } else {
      result = result + value[i];
    }
  }
  return result;
}

Widget buildProductItems(
    model,
    context, {
      bool isOldPrice = true,
    }) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          model.oldPrice.toString(),
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          ShopCubit.get(context).favorites[model.id]!
                              ? defaultColor
                              : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );