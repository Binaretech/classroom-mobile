import 'dart:convert';

import 'package:classroom_mobile/models/user.dart';

class SectionMember extends User {
  final String type;

  const SectionMember({
    required this.type,
    required String id,
    required String name,
    required String lastname,
  }) : super(id: id, name: name, lastname: lastname);

  SectionMember.fromMap(Map<String, dynamic> data)
      : type = data['type'] as String,
        super.fromMap(data);

  static List<SectionMember> fromList(List<dynamic> data) {
    return data
        .map((e) => SectionMember.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  static SectionMember? fromJson(String? json) {
    if (json == null) return null;

    final data = jsonDecode(json) as Map<String, dynamic>;

    return SectionMember.fromMap(data);
  }
}
