part of '../section_view.dart';

class _ClassTitle extends StatelessWidget {
  final String name;
  final String section;

  const _ClassTitle({
    Key? key,
    required this.name,
    required this.section,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                name,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Text(
              section,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
