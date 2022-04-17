import 'package:classroom_mobile/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:classroom_mobile/bloc/user/user_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  Widget provider({
    required BuildContext context,
    required Widget Function(BuildContext, UserState) builder,
  }) {
    return BlocBuilder<UserBloc, UserState>(
      bloc: BlocProvider.of<UserBloc>(context),
      builder: builder,
    );
  }

  Widget avatar(User user) {
    final image = user.profileImage == null
        ? null
        : Image.network(user.profileImage!.url).image;

    return CircleAvatar(
      radius: 30.0,
      foregroundImage: image,
      child: Text("${user.name[0]} ${user.lastname[0]}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: provider(
        context: context,
        builder: (context, userState) {
          final user = (userState as LoggedUserState).user;

          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      avatar(user),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(user.fullName),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
