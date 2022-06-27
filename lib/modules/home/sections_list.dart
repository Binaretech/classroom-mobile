import 'package:classroom_mobile/bloc/section/section_bloc.dart';
import 'package:classroom_mobile/modules/home/section_list_item.dart';
import 'package:classroom_mobile/repository/class_repository.dart';
import 'package:classroom_mobile/repository/resources/section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SectionsList extends StatefulWidget {
  final ClassRepository repository;

  const SectionsList({Key? key, required this.repository}) : super(key: key);

  @override
  SectionsListState createState() => SectionsListState();
}

class SectionsListState extends State<SectionsList> {
  bool isLoading = true;
  List<SectionResource> sections = [];

  @override
  void initState() {
    super.initState();
    _loadSections();
  }

  void _loadSections() {
    widget.repository.getSections().then((value) {
      context.read<SectionBloc>().add(SetSectionsEvent(value.data));

      setState(() {
        sections = value.data;
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return SectionListItem(
          className: section.sectionClass.name,
          section: section.name,
          sectionId: section.id,
        );
      },
    );
  }
}
