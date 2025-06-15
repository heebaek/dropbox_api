/// Dropbox 파일을 나타내는 클래스입니다.
class DropboxFile {
  final String id;
  final String name;
  final String pathLower;
  final String pathDisplay;
  final DateTime clientModified;
  final DateTime serverModified;
  final String rev;
  final int size;
  final String contentHash;

  DropboxFile({
    required this.id,
    required this.name,
    required this.pathLower,
    required this.pathDisplay,
    required this.clientModified,
    required this.serverModified,
    required this.rev,
    required this.size,
    required this.contentHash,
  });

  factory DropboxFile.fromJson(Map<String, dynamic> json) {
    return DropboxFile(
      id: json['id'] as String,
      name: json['name'] as String,
      pathLower: json['path_lower'] as String,
      pathDisplay: json['path_display'] as String,
      clientModified: DateTime.parse(json['client_modified'] as String),
      serverModified: DateTime.parse(json['server_modified'] as String),
      rev: json['rev'] as String,
      size: json['size'] as int,
      contentHash: json['content_hash'] as String,
    );
  }
}
