import 'package:flutter/material.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/network/remote/cashe_helper.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/cubit/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> BottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: "Business"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_baseball), label: "Sports"),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: "science"),
  ];

  int CurrentIndex = 0;

  void ChangeBottomNavBar(int index) {
    CurrentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getscience();
    }
    emit(NewsBottomNavState());
  }

  List<Widget> Screens = [BusinessScreen(), SportsScreen(), ScienceScreen()];

  List<dynamic> business = [];
  int selectedBusinessItem = 0;
  bool isDesktop = false;

  void setDesktop(bool value) {
    isDesktop = value;
    emit(NewsSetDesktopState());
  }

  void getBusiness() {
    emit(NewsBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'cdba10e504e944d6b863fafa52eda882'
      }).then((value) {
        business = value.data['articles'];
        /* business.forEach((element) {
          businessSelectedItem.add(false);
        }); */
        print('....................${business[0]}');
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print("error is $error");
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  void selectBuisinessItem(index) {
    selectedBusinessItem = index;
    /*  for (var i = 0; i < businessSelectedItem.length; i++) {
      if (i == index) {
        businessSelectedItem[i] = true;
      } else {
        businessSelectedItem[i] = false;
      }
    } */
    emit(NewsSelectBusinessSuccessState());
  }

  List<dynamic> Sports = [];

  void getSports() {
    emit(NewsSportsLoadingState());
    if (Sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'cdba10e504e944d6b863fafa52eda882'
      }).then((value) {
        Sports = value.data['articles'];
        print(Sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print("error is $error");
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getscience() {
    emit(NewsScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'cdba10e504e944d6b863fafa52eda882'
      }).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetSienceSuccessState());
      }).catchError((error) {
        print("error is $error");
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSienceSuccessState());
    }
  }

  bool isDark = false;

  void changeTheme({bool? fromshared}) {
    if (fromshared != null) {
      isDark = fromshared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CasheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  List<dynamic> Search = [];

  void getsearch(String value) {
    emit(NewssearchLoadingState());
    Search = [];

    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'cdba10e504e944d6b863fafa52eda882'
    }).then((value) {
      Search = value.data['articles'];
      print(Search[0]['title']);
      emit(NewsGetsearchSuccessState());
    }).catchError((error) {
      print("error is $error");
      emit(NewsGetsearchErrorState(error.toString()));
    });
  }
}
