import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Layout/cubit.dart';
import 'package:news_app/Layout/states.dart';
import 'package:news_app/Shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).search;

          return Scaffold(
            appBar: AppBar(
              title: const Text("Search"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  defaultFormField(
                      controller: searchController,
                      type: TextInputType.name,
                      validate: () {},
                      label: "search",
                      prefix: Icons.search,
                      onChange: (value) {
                        NewsCubit.get(context).getSearch(value);
                      }),
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            BuildArticleItem(list[index], context),
                        separatorBuilder: (context, index) => MyDivider(),
                        itemCount: list.length),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
