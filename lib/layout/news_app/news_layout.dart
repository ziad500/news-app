import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return /* BlocProvider(
        create: (context) => NewsCubit()..getBusiness(),
        child:  */
        BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var Cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Cubit.changeTheme();
                  },
                  icon: const Icon(Icons.brightness_4_outlined))
            ],
            title: const Text(
              "News App",
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: Cubit.BottomItems,
            currentIndex: Cubit.CurrentIndex,
            onTap: (index) {
              Cubit.ChangeBottomNavBar(index);
            },
          ),
          body: Cubit.Screens[Cubit.CurrentIndex],
        );
      },
      listener: (context, state) {},
    );
  }
}
