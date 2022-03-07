import 'package:flutter/material.dart';
import 'package:classroom_mobile/http/request.dart';
import 'package:classroom_mobile/repository/auth_repository.dart';
import 'package:classroom_mobile/repository/user_repository.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text("asdasd"),
      ),
    );
  }
}
