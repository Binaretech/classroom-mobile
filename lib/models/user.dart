import 'package:classroom_mobile/models/file.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String lastname;
  final File? profileImage;

  const User({
    required this.id,
    required this.name,
    required this.lastname,
    this.profileImage,
  });

  User.fromMap(Map<String, dynamic> data)
      : id = data['id'] as String,
        name = data['name'] as String,
        lastname = data['lastname'] as String,
        profileImage = data.containsKey('profileImage')
            ? File.fromMap(data['profileImage'])
            : null;

  String get fullName => "$name $lastname";

  @override
  List<Object?> get props => [id, name, lastname, profileImage];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'profileImage': profileImage?.toMap(),
    };
  }
}
