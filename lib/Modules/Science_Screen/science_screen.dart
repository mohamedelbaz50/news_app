import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Layout/cubit.dart';
import 'package:news_app/Layout/states.dart';
import 'package:news_app/Shared/component/component.dart';

class scienceScreen extends StatelessWidget {
  const scienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = NewsCubit.get(context).science;
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) => ConditionalBuilder(
            condition: list.length > 0,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    BuildArticleItem(list[index], context),
                separatorBuilder: (context, Index) => MyDivider(),
                itemCount: list.length),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                )),
        listener: (context, state) {});
  }
}
