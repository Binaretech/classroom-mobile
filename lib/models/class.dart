import 'dart:convert';

import 'package:classroom_mobile/models/user.dart';
import 'package:equatable/equatable.dart';

class Class extends Equatable {
  final int id;
  final String name;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? teacher;

  const Class({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    this.teacher,
  });

  Class.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'] as String,
        ownerId = data['ownerId'] as String,
        createdAt = DateTime.parse(data['createdAt'] as String),
        updatedAt = DateTime.parse(data['updatedAt'] as String),
        teacher = data['teacher'] == null
            ? null
            : User.fromMap(data['teacher'] as Map<String, dynamic>);

  @override
  List<Object> get props => [id, name];

  static Class? fromJson(String? json) {
    if (json == null) return null;

    final data = jsonDecode(json) as Map<String, dynamic>;

    return Class.fromMap(data);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "adminId": ownerId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
