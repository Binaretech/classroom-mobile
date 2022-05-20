import 'package:classroom_mobile/modules/home/register_user_info.dart';
import 'package:classroom_mobile/bloc/user/user_bloc.dart';
import 'package:classroom_mobile/repository/class_repository.dart';
import 'package:classroom_mobile/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:classroom_mobile/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  final UserRepository userRepository;
  final ClassRepository classRepository;

  const Home({
    Key? key,
    required this.userRepository,
    required this.classRepository,
  }) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool loading = true;

  @override
  void dispose() {
    widget.userRepository.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _loadUser();
    _loadClasses();
  }

  void _loadClasses() {
    widget.classRepository.getSections().then((value) {
      print(value.data);
    });
  }

  void _loadUser() {
    widget.userRepository.getUser().then((value) async {
      final bloc = context.read<UserBloc>();
      if (value != null) {
        bloc.add(SetUserEvent(user: value));
        return;
      }

      showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          return RegisterUserInfo(
            repository: widget.userRepository,
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
      body: Column(
        children: [
          loading ? const LinearProgressIndicator() : Container(),
        ],
      ),
    );
  }
}
