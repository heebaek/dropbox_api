/// Dropbox 파일/폴더 메타데이터를 나타내는 클래스입니다.
class DropboxMetadata {
  final String tag;
  final String name;
  final String pathLower;
  final String pathDisplay;
  final String id;
  final DateTime? clientModified;
  final DateTime? serverModified;
  final String? rev;
  final int? size;
  final bool? isDownloadable;
  final String? contentHash;

  DropboxMetadata({
    required this.tag,
    required this.name,
    required this.pathLower,
    required this.pathDisplay,
    required this.id,
    this.clientModified,
    this.serverModified,
    this.rev,
    this.size,
    this.isDownloadable,
    this.contentHash,
  });

  factory DropboxMetadata.fromJson(Map<String, dynamic> json) {
    return DropboxMetadata(
      tag: json['.tag'] as String,
      name: json['name'] as String,
      pathLower: json['path_lower'] as String,
      pathDisplay: json['path_display'] as String,
      id: json['id'] as String,
      clientModified:
          json['client_modified'] != null
              ? DateTime.parse(json['client_modified'] as String)
              : null,
      serverModified:
          json['server_modified'] != null
              ? DateTime.parse(json['server_modified'] as String)
              : null,
      rev: json['rev'] as String?,
      size: json['size'] as int?,
      isDownloadable: json['is_downloadable'] as bool?,
      contentHash: json['content_hash'] as String?,
    );
  }

  bool get isFile => tag == 'file';
  bool get isFolder => tag == 'folder';
}
