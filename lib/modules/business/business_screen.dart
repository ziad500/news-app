import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var list = NewsCubit.get(context).business;
          return ScreenTypeLayout(
            mobile: Builder(builder: (context) {
              NewsCubit.get(context).setDesktop(false);
              return articleBuilder(list, context);
            }),
            desktop: Builder(builder: (context) {
              NewsCubit.get(context).setDesktop(true);

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: articleBuilder(list, context)),
                  Expanded(
                      child: Container(
                    height: double.infinity,
                    color: Colors.grey[100],
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        list.length > 0
                            ? list[NewsCubit.get(context).selectedBusinessItem]
                                    ['description'] ??
                                'لا يوجد وصف'
                            : '',
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ))
                ],
              );
            }),
            breakpoints:
                const ScreenBreakpoints(desktop: 750, tablet: 600, watch: 300),
          );
        },
        listener: (context, state) {});
  }
}
