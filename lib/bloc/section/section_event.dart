part of 'section_bloc.dart';

abstract class SectionEvent extends Equatable {
  const SectionEvent();
}

class SetSectionsEvent extends SectionEvent {
  final List<SectionResource> sections;

  const SetSectionsEvent([this.sections = const []]);

  @override
  List<Object> get props => [jsonEncode(sections)];
}

class AddSectionEvent extends SectionEvent {
  final Section section;

  const AddSectionEvent(this.section);

  @override
  List<Object> get props => [section];
}
