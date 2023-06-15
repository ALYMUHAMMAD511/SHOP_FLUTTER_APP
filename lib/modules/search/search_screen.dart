import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/search_cubit/cubit.dart';
import 'package:shop_app/modules/search/search_cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    var formKey = GlobalKey <FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer <SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:
                [
                  defaultFormField(
                    context,
                    controller: searchController,
                    type: TextInputType.text,
                    validate: (value)
                    {
                      if (value != null || value!.isEmpty)
                      {
                        return 'Enter Text to Search';
                      }
                      return null;
                    },
                    labelText: 'Search',
                    prefixIcon: Icons.search,
                    onFieldSubmitted: (String text)
                    {
                      SearchCubit.get(context).search(text);
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildProductItems(
                          SearchCubit.get(context)
                              .model!
                              .data!
                              .data![index],
                          context,
                          isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => mySeparator(),
                        itemCount: SearchCubit.get(context)
                            .model!
                            .data!
                            .data!
                            .length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
