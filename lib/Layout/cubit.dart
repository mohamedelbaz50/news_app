import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Layout/states.dart';
import 'package:news_app/Modules/Business_Screen/business_screen.dart';
import 'package:news_app/Modules/Science_Screen/science_screen.dart';
import 'package:news_app/Modules/Sports_Screen/sports_screen.dart';

import 'package:news_app/Shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> BottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: "Business"),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Sports"),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: "Science"),
  ];
  int currentIndex = 0;
  void changeBottomBar(int index) {
    currentIndex = index;
    emit(NavBarChange());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': 'b7c61fc6e86d4a82a8a5caa4871a7f66',
    }).then((value) {
      emit(NewsGetBusinessSuccessState());
      business = value.data['articles'];
    }).catchError((error) {
      emit(NewsGetBusinessErrorState());
      print(error.toString());
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsSportsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'sports',
      'apiKey': 'b7c61fc6e86d4a82a8a5caa4871a7f66',
    }).then((value) {
      emit(NewsGetSportsSuccessState());
      sports = value.data['articles'];
    }).catchError((error) {
      emit(NewsGetSportsErrorState());
      print(error.toString());
    });
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsScienceLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'science',
      'apiKey': 'b7c61fc6e86d4a82a8a5caa4871a7f66',
    }).then((value) {
      emit(NewsGetScienceSuccessState());
      science = value.data['articles'];
    }).catchError((error) {
      emit(NewsGetScienceErrorState());
      print(error.toString());
    });
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsSearchLoadingState());
    search = [];
    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apiKey': 'b7c61fc6e86d4a82a8a5caa4871a7f66',
    }).then((value) {
      emit(NewsGetSearchSuccessState());
      search = value.data['articles'];
    }).catchError((error) {
      emit(NewsGetSearchErrorState());
      print(error.toString());
    });
  }

  List<Widget> bottomBarScreens = [
    businessScreen(),
    sportsScreen(),
    scienceScreen(),
  ];
}
