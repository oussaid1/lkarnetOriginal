import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:lkarnet/screens/splash.dart';

import 'bloc/authbloc/auth_bloc.dart';
import 'utils.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticationFailedState) {
          GlobalFunctions.showErrorSnackBar(
            context,
            state.error,
          );
          Navigator.of(context).pushReplacementNamed('/login');
        }

        if (state is UnauthenticatedState) {
          Navigator.of(context).pushReplacementNamed('/');
        }

        if (state is AuthenticatedState) {
          GlobalFunctions.showSuccessSnackBar(
            context,
            'تم تسجيل الدخول بنجاح',
          );
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthInitState) {
            return SplashPage();
          }
          if (state is AuthenticatedState) {
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
