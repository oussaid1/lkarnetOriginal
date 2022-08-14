import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/navigator/rout_navigator.dart';
import 'package:lkarnet/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:lkarnet/screens/splash.dart';

import 'blocs/authbloc/auth_bloc.dart';
import 'cubits/userCubit/usermodel_cubit.dart';
import 'database/database.dart';
import 'utils.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticationFailed) {
          GetIt.I<Database>().setUserUid(state.user!.uid);
          context.read<UserModelCubit>().loadUser();
          GlobalFunctions.showSuccessSnackBar(
            context,
            'تم تسجيل الدخول بنجاح',
          );
          Navigator.pushReplacementNamed(context, RouteGenerator.home);
        }
        if (state.status == AuthStatus.authenticationFailed) {
          GlobalFunctions.showErrorSnackBar(
            context,
            state.error ?? 'حدث خطأ ما',
          );
          Navigator.of(context).pushReplacementNamed('/login');
        }

        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed('/');
        }
      },
      child: BlocBuilder<AuthBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthStatus.authenticating) {
            return SplashPage();
          }
          if (state.status == AuthStatus.authenticated) {
            GetIt.I<Database>().setUserUid(state.user!.uid);
            return HomePage();
          }
          if (state.status == AuthStatus.unauthenticated) {
            return SplashPage();
          }
          return Container();
        },
      ),
    );
  }
}
