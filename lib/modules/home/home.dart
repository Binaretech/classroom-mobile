import 'package:classroom_mobile/modules/home/register_user_info.dart';
import 'package:classroom_mobile/bloc/user/user_bloc.dart';
import 'package:classroom_mobile/modules/home/sections_list.dart';
import 'package:classroom_mobile/repository/class_repository.dart';
import 'package:classroom_mobile/widgets/drawer/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:classroom_mobile/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  final UserRepository repository;

  static const route = '/';

  const Home({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool loading = true;

  @override
  void dispose() {
    widget.repository.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _loadUser();
  }

  void _loadUser() {
    widget.repository.getUser().then((value) async {
      final bloc = context.read<UserBloc>();
      if (value != null) {
        bloc.add(SetUserEvent(user: value));
        return;
      }

      showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return RegisterUserInfo(
            repository: widget.repository,
          );
        },
      );
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classroom'),
      ),
      drawer: const AppDrawer(),
      body: SectionsList(
        repository: ClassRepository(),
      ),
    );
  }
}
