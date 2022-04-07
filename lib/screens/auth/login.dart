import 'package:flutter/gestures.dart';
import 'package:lkarnet/providers/authproviders/auth_providers.dart';
import 'package:lkarnet/providers/authproviders/login_page_providers.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/root.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';

import 'register.dart';

// isLoading: false,
final isLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

class LoginPage extends ConsumerWidget {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassMaterial(
      circleWidgets: [
        Positioned(
          width: 100,
          height: 100,
          left: 10,
          top: 120,
          child: AppAssets.pinkCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          right: 80,
          top: 200,
          child: AppAssets.purpleCircleWidget,
        ),
        Positioned(
          width: 140,
          height: 140,
          left: 30,
          bottom: 80,
          child: AppAssets.blueCircleWidget,
        ),
      ],
      alignment: Alignment.center,
      centerWidget: SizedBox(
          width: 380, height: 420, child: _buildLoginCard(context, ref)),
    );
  }

  Widget _buildLoginCard(BuildContext context, WidgetRef ref) {
    var _email = ref.watch(emailProvider.state).state.trim();
    var _pass = ref.watch(passwordProvider.state).state.trim();
    var _isLoading = ref.watch(isLoadingProvider.state).state;
    final _auth = ref.watch(authServicesProvider);
    var _obscPass = ref.watch(passwordObscureProvider.state);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GlassContainer(
        start: 0.2,
        end: 0.15,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Text('Login',
                        style: Theme.of(context).textTheme.headline1),
                  ), // title: login
                  SizedBox(height: 10),
                  Container(
                    child: TextFormField(
                      onChanged: (value) =>
                          ref.read(emailProvider.state).state = value,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return "Please insert a valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email',
                          //prefixIcon: Icon(Icons.email),
                          icon: Icon(Icons.email)),
                    ),
                  ), //text field: email
                  Container(
                    child: TextFormField(
                      onChanged: (value) =>
                          ref.read(passwordProvider.state).state = value,
                      controller: _passController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return "Please insert a valid password";
                        }
                        return null;
                      },
                      obscureText: _obscPass.state,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(_obscPass.state
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              _obscPass.state = !_obscPass.state;
                            },
                          ),
                          icon: Icon(Icons.vpn_key)),
                    ),
                  ), //text field: password

                  Container(
                    margin: EdgeInsets.only(top: 40.0),
                    width: 300,
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xFFEAB93C)),
                    child: ElevatedButton(
                      style: MThemeData.raisedButtonStyleSave,
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: _isLoading
                          ? null
                          : () {
                              ref.read(isLoadingProvider.state).state = true;
                              if (_loginFormKey.currentState!.validate()) {
                                ref.read(isLoadingProvider.state).state = false;
                                _auth
                                    .signIn(email: _email, password: _pass)
                                    .then(
                                      (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Root()),
                                      ),
                                    );
                              }
                              // _auth.signInWithGoogle().then((value) => _auth.createNewUser(UserModel.fromUserCredential(value, value.user!.displayName.toString()) ));
                            },
                    ),
                  ), //button: lo
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    width: 300,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(50)),
                    child: InkWell(
                      child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: SizedBox(
                                height: 35,
                                width: 35,
                                child: AppAssets.googleSvgIcon),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              "Sign in with google",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        _auth.googleSignIn().then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Root()),
                            ));

                        // _auth.signInWithGoogle().then((value) => _auth.createNewUser(UserModel.fromUserCredential(value, value.user!.displayName.toString()) ));
                      },
                    ),
                  ), //button: login
                  Container(
                      margin: EdgeInsets.only(
                        left: 10.0,
                        top: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: Theme.of(context).textTheme.bodyText1,
                              children: [
                                TextSpan(
                                  text: "Sign up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
