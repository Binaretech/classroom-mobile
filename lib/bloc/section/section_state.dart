part of 'section_bloc.dart';

class SectionState extends Equatable {
  final Map<int, Section> sections;

  const SectionState([this.sections = const {}]);

  @override
  List<Object> get props => [sections];
}
