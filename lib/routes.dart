import 'package:classroom_mobile/modules/auth/login.dart';
import 'package:classroom_mobile/modules/auth/register.dart';
import 'package:classroom_mobile/modules/class/section_view.dart';
import 'package:classroom_mobile/modules/home/home.dart';
import 'package:classroom_mobile/repository/auth_repository.dart';
import 'package:classroom_mobile/repository/user_repository.dart';

final routes = {
  Home.route: (_) => Home(repository: UserRepository()),
  Login.route: (_) => Login(repository: AuthRepository()),
  Register.route: (_) => Register(repository: AuthRepository()),
  SectionView.route: (_) => const SectionView(),
};
