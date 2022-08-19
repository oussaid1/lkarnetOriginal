import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lkarnet/database/database.dart';
import 'package:lkarnet/services/auth_service.dart';
import 'blocs/authbloc/auth_bloc.dart';
import 'blocs/loginbloc/login_bloc.dart';
import 'components.dart';
import 'cubits/userCubit/usermodel_cubit.dart';
import 'navigator/rout_navigator.dart';
import 'root.dart';
import 'settings/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.authService}) : super(key: key);
  final AuthService authService;
  //final Database database;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: (context) => authService,
        ),
        RepositoryProvider.value(
          value: (context) => Database(uid: ''),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authService),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              AuthBloc(authService),
              authService,
            ),
          ),

          /// provide user model cubit
          BlocProvider<UserModelCubit>(
            create: (context) => UserModelCubit(),
          ),
        ],
        child: LkarnetApp(),
      ),
    );
  }
}

class LkarnetApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var appThemeState = ref.watch(appThemeStateNotifier);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('ar'),
      //title: 'حانوتي - لكارني',
      theme: MThemeData.lightThemeData,
      darkTheme: MThemeData.darkThemeData,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: Root(),
    );
  }
}
