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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          GetIt.I<Database>().setUserUid(state.user.uid);
          context.read<UserModelCubit>().loadUser();
          GlobalFunctions.showSuccessSnackBar(
            context,
            'تم تسجيل الدخول بنجاح',
          );
          Navigator.pushNamed(context, RouteGenerator.home);
        }
        if (state is AuthenticationFailedState) {
          GlobalFunctions.showErrorSnackBar(
            context,
            state.error,
          );
          Navigator.of(context).pushReplacementNamed('/login');
        }

        if (state is UnauthenticatedState) {
          Navigator.of(context).pushNamed('/');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitState) {
            return SplashPage();
          }
          if (state is AuthenticatedState) {
            GetIt.I<Database>().setUserUid(state.user.uid);
            return HomePage();
          }
          if (state is UnauthenticatedState) {
            return SplashPage();
          }
          return Container();
        },
      ),
    );
  }
}
