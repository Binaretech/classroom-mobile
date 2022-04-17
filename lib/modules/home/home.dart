import 'package:classroom_mobile/modules/home/register_user_info.dart';
import 'package:classroom_mobile/bloc/user/user_bloc.dart';
import 'package:classroom_mobile/widgets/layout.dart';
import 'package:flutter/material.dart';
import 'package:classroom_mobile/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getUser().then((value) async {
      final bloc = context.read<UserBloc>();

      if (value != null) {
        bloc.add(SetUserEvent(user: value));
      }

      if (value == null) {
        showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) {
              return const RegisterUserInfo();
            });
      }
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      body: Column(
        children: [
          loading ? const LinearProgressIndicator() : Container(),
        ],
      ),
    );
  }
}
