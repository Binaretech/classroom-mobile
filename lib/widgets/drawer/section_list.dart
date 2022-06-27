import 'package:classroom_mobile/bloc/section/section_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionList extends StatelessWidget {
  const SectionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sections =
        BlocProvider.of<SectionBloc>(context).state.sections.values.toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(sections[index].sectionClass?.name ?? ''),
            subtitle: Text(sections[index].name),
          );
        },
      ),
    );
  }
}
