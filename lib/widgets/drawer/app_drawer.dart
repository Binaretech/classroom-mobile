import 'package:classroom_mobile/widgets/drawer/section_list.dart';
import 'package:classroom_mobile/widgets/drawer/user_info.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: const [
            UserInfo(),
            Divider(),
            SectionList(),
          ],
        ),
      ),
    );
  }
}
