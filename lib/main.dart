import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_application/features/news/presentation/pages/news_page.dart';
import 'package:news_application/features/news/repository/news_model.dart';
import 'package:news_application/utility/modules/base_bloc_module.dart';

import 'utility/modules/base_module.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NewsModelAdapter());
  initModule();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: AppBloc.getAllProviders(),
        child: MaterialApp(
          title: 'News',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: NewsPage(),
        ));
  }
}
