import 'package:classroom_mobile/bloc/section/section_bloc.dart';
import 'package:classroom_mobile/modules/class/section_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionListItem extends StatelessWidget {
  final String className;
  final String section;
  final int sectionId;

  const SectionListItem({
    Key? key,
    required this.className,
    required this.section,
    required this.sectionId,
  }) : super(key: key);

  void Function() _onTap(BuildContext context) {
    return () {
      Navigator.of(context).pushNamed(
        '/section',
        arguments: SectionViewArguments(
            section: context.read<SectionBloc>().state.sections[sectionId]!),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Card(
        child: InkWell(
          onTap: _onTap(context),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(className),
                      Text(section),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
