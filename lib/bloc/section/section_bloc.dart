import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:classroom_mobile/models/section.dart';
import 'package:classroom_mobile/repository/resources/section.dart';
import 'package:equatable/equatable.dart';

part 'section_event.dart';
part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  SectionBloc() : super(const SectionState()) {
    on<SetSectionsEvent>(
      (event, emit) {
        final sections = event.sections.map((section) {
          return section.toModel();
        }).toList();

        return emit(
          SectionState(
            sections.fold({}, (previousValue, element) {
              return {...previousValue, element.id: element};
            }),
          ),
        );
      },
    );
  }
}
