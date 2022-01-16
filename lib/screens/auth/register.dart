import 'package:lkarnet/providers/authproviders/auth_providers.dart';
import 'package:lkarnet/providers/authproviders/login_page_providers.dart';
import 'package:lkarnet/providers/varproviders/var_providers.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/components.dart';

import 'login.dart';

class RegisterPage extends ConsumerWidget {
  final _registerFormKey = GlobalKey<FormState>();

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
      centerWidget: GlassContainer(
          child: SizedBox(
              width: 380,
              height: 420,
              child: _getWidgetRegistrationCard(context, ref))),
    );
  }

  Widget _getWidgetRegistrationCard(BuildContext context, WidgetRef ref) {
    var _obscConfirmPass = ref.watch(confirmPassObscureProvider.state);
    var _obscPass = ref.watch(passwordObscureProvider.state);
    var _auth = ref.watch(authServicesProvider);
    var _username = ref.watch(regUsernameProvider.state).state.trim();
    var _email = ref.watch(regEmailProvider.state).state.trim();
    var _pass = ref.watch(regPasswordProvider.state).state.trim();
    //final _confirmPass = ref.watch(regConfPasswordProvider.state).state.trim();
    // final _db = ref.watch(databaseProvider);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _registerFormKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Register',
                    style: GoogleFonts.sansita(
                      fontSize: 24,
                    ),
                  ),
                ), // title: login
                Container(
                  child: TextFormField(
                    onChanged: (value) =>
                        ref.read(regUsernameProvider.state).state = value,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (text) {
                      if (text!.trim().isEmpty) {
                        return "Please insert a unique username";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Username',
                        //prefixIcon: Icon(Icons.email),
                        icon: Icon(Icons.perm_identity)),
                  ),
                ), //text field : user name
                Container(
                  child: TextFormField(
                    onChanged: (value) =>
                        ref.read(regEmailProvider.state).state = value,
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
                        ref.read(regPasswordProvider.state).state = value,
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
                  child: TextFormField(
                      onChanged: (value) =>
                          ref.read(regConfPasswordProvider.state).state = value,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return "Please insert a valid password";
                        } else if (text.trim() != text.trim()) {
                          return "The Passwords dont match !";
                        }
                        return null;
                      },
                      obscureText: _obscConfirmPass.state,
                      decoration: InputDecoration(
                          labelText: "Confirm Password",
                          suffixIcon: IconButton(
                            icon: Icon(_obscConfirmPass.state
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              _obscConfirmPass.state = !_obscConfirmPass.state;
                            },
                          ),
                          icon: Icon(Icons.vpn_key))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 32.0),
                  width: 400,
                  height: 45,
                  child: ElevatedButton(
                    style: MThemeData.raisedButtonStyleSave,
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: () {
                      if (_registerFormKey.currentState!.validate()) {
                        _auth
                            .signUp(
                                username: _username,
                                email: _email,
                                password: _pass)
                            .then((value) =>
                                _registerFormKey.currentState!.reset());
                      }
                    },
                  ),
                ), //button: login
                Container(
                    margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already Registered? ',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        InkWell(
                          splashColor:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            ' Sign in',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
