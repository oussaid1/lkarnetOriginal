import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lkarnet/providers/authproviders/auth_providers.dart';
import 'package:lkarnet/providers/authproviders/auth_services.dart';
import 'package:lkarnet/providers/authproviders/database_providers.dart';
import 'package:lkarnet/root.dart';
import 'package:lkarnet/settings/theme/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appThemeState = ref.watch(appThemeStateNotifier);
    final _authservice = ref.watch(authServicesProvider);
    final _user = ref.watch(userModelProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Account Settings'),
                      Row(
                        children: [
                          Switch(
                            activeColor:
                                Theme.of(context).colorScheme.secondary,
                            value: appThemeState.darkMode,
                            onChanged: (enabled) {
                              if (enabled) {
                                appThemeState.toggleChangeTheme();
                              } else {
                                appThemeState.toggleChangeTheme();
                              }
                            },
                          ),
                          Icon(
                            CupertinoIcons.moon_fill,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Text(
                  'Update your settings like profile edit, change password etc.',
                  style: Theme.of(context).textTheme.subtitle2,
                )
              ],
            ),
            SizedBox(
              height: 60,
            ),
            ListTile(
              leading: Container(
                width: 45,
                height: 45,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  child: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.grey,
                    size: 35,
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _user.when(
                      data: (user) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user.name}',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Text(
                                '${user.email}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                      loading: () => Text('loading ...'),
                      error: (e, t) => Text('error')),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
              onTap: () {},
            ),
            ListTile(
              leading:
                  Container(width: 45, height: 45, child: Icon(Icons.lock)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change Password',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    'change your password',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Container(
                  width: 45, height: 45, child: Icon(Icons.share_outlined)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Share to Friends',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    'change your account information ',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Container(
                  width: 45, height: 45, child: Icon(CupertinoIcons.power)),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Logout',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Text(
                    'logout and try different login',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
              onTap: () {
                _buildSignOut(context, _authservice);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _buildSignOut(
      BuildContext context, AuthenticationService authservice) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Log-out !?'),
            actionsPadding: EdgeInsets.only(left: 8, right: 8),
            actions: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120,
                      child: TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.headline3,
                          minimumSize: Size(88, 36),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 120,
                      child: TextButton(
                        child: Text(
                          'Out',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        onPressed: () {
                          authservice.signout().then((value) =>
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => Root()),
                                  (Route<dynamic> route) => false));
                        },
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.headline3,
                          minimumSize: Size(88, 36),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          elevation: 0,
                          onSurface: Theme.of(context).colorScheme.primary,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
