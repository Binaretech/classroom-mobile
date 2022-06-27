import 'package:equatable/equatable.dart';

class File extends Equatable {
  final String id;
  final String key;
  final int type;
  final String bucket;
  final String mimeType;
  final String fileableType;
  final String fileableId;

  const File({
    required this.id,
    required this.key,
    required this.type,
    required this.bucket,
    required this.mimeType,
    required this.fileableType,
    required this.fileableId,
  });

  File.fromMap(Map<String, dynamic> data)
      : id = data['id'] as String,
        key = data['key'] as String,
        type = data['type'] as int,
        bucket = data['bucket'] as String,
        mimeType = data['mimeType'] as String,
        fileableType = data['fileableType'] as String,
        fileableId = data['fileableId'] as String;

  String get url => "http://localhost:9000/$bucket/$key";

  @override
  List<Object> get props =>
      [id, key, type, bucket, mimeType, fileableType, fileableId];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'key': key,
      'type': type,
      'bucket': bucket,
      'mimeType': mimeType,
      'fileableType': fileableType,
      'fileableId': fileableId,
    };
  }
}
