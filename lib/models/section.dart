import 'package:classroom_mobile/models/class.dart';
import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final int id;
  final String name;
  final int classId;
  final Class? sectionClass;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Section({
    required this.id,
    required this.name,
    required this.classId,
    this.sectionClass,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [name, classId, sectionClass];
}
