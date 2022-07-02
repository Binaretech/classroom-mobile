part of '../section_view.dart';

class _SectionBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const _SectionBottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTabTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.announcement),
          label: lang.trans('attributes.announcements', capitalize: true),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.assignment),
          label: lang.trans('attributes.assignments', capitalize: true),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.people),
          label: lang.trans('attributes.members', capitalize: true),
        ),
      ],
    );
  }
}
