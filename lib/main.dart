import 'package:expenses_app/Screens/add_expense.dart';
import 'package:expenses_app/Screens/home.dart';
import 'package:expenses_app/Screens/splash_screen.dart';
import 'package:expenses_app/db/app_db.dart';
import 'package:expenses_app/exp_bloc/exp_bloc.dart';
import 'package:expenses_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: BlocProvider(
        create: (context) => ExpenseBloc(db: AppDataBase.instance),
         child: const MyApp(),
      ),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.read<ThemeProvider>().updateThemeOnStart();
    return MaterialApp(
      themeMode: context.watch<ThemeProvider>().themeValue?ThemeMode.dark:ThemeMode.light,
      darkTheme: ThemeData(brightness: Brightness.dark,
      useMaterial3: true,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
