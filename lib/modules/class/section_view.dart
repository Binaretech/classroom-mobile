import 'package:classroom_mobile/lang/lang.dart';
import 'package:classroom_mobile/models/section.dart';
import 'package:classroom_mobile/repository/class_repository.dart';
import 'package:classroom_mobile/repository/resources/section_member.dart';
import 'package:classroom_mobile/widgets/drawer/app_drawer.dart';
import 'package:classroom_mobile/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

part 'widgets/section_bottom_navigation.dart';
part 'widgets/members_list.dart';
part 'widgets/class_title.dart';

class SectionViewArguments {
  final Section section;

  SectionViewArguments({required this.section});
}

class SectionView extends StatefulWidget {
  static const route = '/section';

  const SectionView({Key? key}) : super(key: key);

  @override
  SectionViewState createState() => SectionViewState();
}

class SectionViewState extends State<SectionView> {
  int _currentIndex = 0;

  Widget _views(int index) {
    final section =
        (ModalRoute.of(context)!.settings.arguments as SectionViewArguments)
            .section;

    return [
      _ClassTitle(name: section.sectionClass!.name, section: section.name),
      const Text('Section 3'),
      _MembersList(
        sectionId: section.id,
      ),
    ][index];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: _views(_currentIndex),
      bottomNavigationBar: _SectionBottomNavigation(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}
