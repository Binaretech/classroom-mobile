import 'package:classroom_mobile/repository/models/model.dart';

class Token extends Model {
  final String accessToken;
  final String refreshToken;
  final DateTime accessExpires;

  Token(this.accessToken, this.refreshToken, this.accessExpires);

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      json['accessToken'],
      json['accessToken'],
      DateTime.fromMillisecondsSinceEpoch(json['accessExpires']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'accessExpires': accessExpires.millisecondsSinceEpoch,
    };
  }
}
