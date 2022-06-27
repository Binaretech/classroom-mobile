import 'dart:collection';

import 'package:classroom_mobile/models/class.dart';
import 'package:classroom_mobile/models/section.dart';
import 'package:equatable/equatable.dart';

class SectionResource extends Equatable {
  final int id;
  final String name;
  final int classId;
  final Class sectionClass;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SectionResource({
    required this.id,
    required this.name,
    required this.classId,
    required this.sectionClass,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SectionResource.fromJson(Map<String, dynamic> json) {
    return SectionResource(
      id: json["id"],
      name: json["name"],
      classId: json["classId"],
      sectionClass: Class.fromMap(HashMap.from(json['class'])),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }

  static List<SectionResource> fromList(List<dynamic> data) {
    return data
        .map((e) => SectionResource.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Section toModel() {
    return Section(
      id: id,
      name: name,
      classId: classId,
      sectionClass: sectionClass,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        classId,
        sectionClass,
        createdAt,
        updatedAt,
      ];
}
