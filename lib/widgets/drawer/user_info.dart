import 'package:classroom_mobile/models/user.dart';
import 'package:classroom_mobile/utils/helpers.dart';
import 'package:classroom_mobile/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  Widget avatar(User user) {
    final image = user.profileImage == null
        ? null
        : Image.network(user.profileImage!.url).image;

    return CircleAvatar(
      radius: 30.0,
      foregroundImage: image,
      child: Text(unnacent("${user.name[0]}${user.lastname[0]}")),
    );
  }

  User? _getUser(BuildContext context) {
    final user = BlocProvider.of<UserBloc>(context).state;

    if (user is UnLoggedUserState) {
      return null;
    }

    return (user as LoggedUserState).user;
  }

  @override
  Widget build(BuildContext context) {
    final user = _getUser(context);

    if (user == null) {
      return Container();
    }

    return Padding(
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
    );
  }
}
