import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/App_cubit/app_cubit.dart';
import 'package:news_app/Layout/cubit.dart';
import 'package:news_app/Layout/states.dart';
import 'package:news_app/Modules/Search_screen/search_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..getSports()
        ..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                      },
                      icon: const Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        AppCubit().get(context).changeMode();
                      },
                      icon: Icon(Icons.brightness_4_outlined))
                ],
                title: const Text("News App"),
              ),
              body: cubit.bottomBarScreens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                items: cubit.BottomItem,
                currentIndex: cubit.currentIndex,
                onTap: (Index) {
                  cubit.changeBottomBar(Index);
                },
              ),
            );
          }),
    );
  }
}
