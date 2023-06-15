import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCategoriesItem(
              ShopCubit.get(context).categoriesModel!.data.data[index], context),
          separatorBuilder: (context, index) => mySeparator(),
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
        );
      },
    );
  }

  Widget buildCategoriesItem(DataModel model, context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            child:
             Image(
               image: NetworkImage("${model.image}"),
               fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            capitalizeAllWord('${model.name}'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.8,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios),
            color: ShopCubit.get(context).isDark ? Colors.white : Colors.black,
          ),
        ],
      ));
}