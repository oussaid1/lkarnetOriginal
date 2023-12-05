import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:lkarnet/widgets/dialogs.dart';
import 'package:lkarnet/widgets/myappbar.dart';
import '../../blocs/loginbloc/login_bloc.dart';
import '../../components.dart';
import '../../cubits/userCubit/usermodel_cubit.dart';
import '../../widgets/notifications_switch.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  var appThemeState = ref.watch(appThemeStateNotifier);
    //context.read<UserModelCubit>().loadUser();
    return BluredContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: MyAppBar(
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body:
            BlocBuilder<UserModelCubit, UserModel?>(builder: (context, state) {
          if (state != null) {
            return SingleChildScrollView(
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
                            // Row(
                            //   children: [
                            //     Switch(
                            //       activeColor:
                            //           Theme.of(context).colorScheme.secondary,
                            //       value: appThemeState.darkMode,
                            //       onChanged: (enabled) {
                            //         if (enabled) {
                            //           appThemeState.toggleChangeTheme();
                            //         } else {
                            //           appThemeState.toggleChangeTheme();
                            //         }
                            //       },
                            //     ),
                            //     Icon(
                            //       CupertinoIcons.moon_fill,
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                      Text(
                        'Update your settings like profile edit, change password etc.',
                        style: Theme.of(context).textTheme.titleSmall,
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
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 35,
                      ),
                    ),
                    title: Text(
                      '${state.email}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Container(
                        width: 45, height: 45, child: Icon(Icons.lock)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Change Password',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          'change your password',
                          style: Theme.of(context).textTheme.titleSmall,
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
                        width: 45,
                        height: 45,
                        child: Icon(Icons.share_outlined)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Share to Friends',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          'change your account information ',
                          style: Theme.of(context).textTheme.titleSmall,
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
                        width: 45,
                        height: 45,
                        child: Icon(Icons.notifications)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Activate Notification',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          'Turn on/off notification',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    trailing: NotificationsSwitch(),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Container(
                        width: 45,
                        height: 45,
                        child: Icon(CupertinoIcons.power)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Logout',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          'logout and try different login',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
                    onTap: () {
                      Dialogs.confirmDialogue(
                        context,
                        title: 'Logout',
                        message: 'Are you sure you want to logout?',
                      ).then((value) {
                        if (value) {
                          BlocProvider.of<LoginBloc>(context)
                              .add(LogOutRequestedEvent());
                        }
                      });
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
