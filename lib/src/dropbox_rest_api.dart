import 'dart:async';
import 'dart:convert';

import 'package:oauth2restclient/oauth2restclient.dart';

import 'interface.dart';
import 'models/models.dart';

class DropboxRestApi implements DropboxApi {
  final OAuth2RestClient client;
  static const String _baseUrl = 'https://api.dropboxapi.com/2';

  DropboxRestApi(this.client);

  @override
  Future<Stream<List<int>>> download(String path) async {
    final response = await client.post(
      'https://content.dropboxapi.com/2/files/download',
      headers: {
        'Dropbox-API-Arg': jsonEncode({'path': path}),
      },
    );
    return response.bodyStream;
  }

  @override
  Future<DropboxFolderContents> listFolder(
    String path, {
    String? cursor,
    int limit = 2000,
  }) async {
    final response = await client.postJson(
      '$_baseUrl/files/list_folder',
      body: OAuth2JsonBody({
        'path': path,
        if (cursor != null) 'cursor': cursor,
        'limit': limit,
      }),
    );
    return DropboxFolderContents.fromJson(response);
  }

  @override
  Future<DropboxFolder> createFolder(String path) async {
    final response = await client.postJson(
      '$_baseUrl/files/create_folder_v2',
      body: OAuth2JsonBody({'path': path, 'autorename': false}),
    );
    return DropboxFolder.fromJson(response);
  }

  @override
  Future<DropboxFile> upload(
    String path,
    Stream<List<int>> dataStream, {
    String mode = 'add',
    bool autorename = true,
  }) async {
    // Stream을 List<int>로 변환
    final chunks = await dataStream.toList();
    final fileContent = <int>[];
    for (final chunk in chunks) {
      fileContent.addAll(chunk);
    }

    final fileBody = OAuth2FileBody(
      Stream.value(fileContent),
      contentLength: fileContent.length,
      contentType: 'application/octet-stream',
    );

    final response = await client.post(
      'https://content.dropboxapi.com/2/files/upload',
      body: fileBody,
      headers: {
        'Dropbox-API-Arg': jsonEncode({
          'path': path,
          'mode': mode,
          'autorename': autorename,
        }),
        'Content-Type': 'application/octet-stream',
      },
    );
    final bytes = await response.readAsBytes();
    return DropboxFile.fromJson(jsonDecode(utf8.decode(bytes)));
  }

  @override
  Future<void> delete(String path) async {
    await client.postJson(
      '$_baseUrl/files/delete_v2',
      body: OAuth2JsonBody({'path': path}),
    );
  }

  @override
  Future<void> move(String fromPath, String toPath) async {
    await client.postJson(
      '$_baseUrl/files/move_v2',
      body: OAuth2JsonBody({'from_path': fromPath, 'to_path': toPath}),
    );
  }

  @override
  Future<void> copy(String fromPath, String toPath) async {
    await client.postJson(
      '$_baseUrl/files/copy_v2',
      body: OAuth2JsonBody({'from_path': fromPath, 'to_path': toPath}),
    );
  }

  @override
  Future<DropboxAccount> getCurrentAccount() async {
    final response = await client.postJson(
      '$_baseUrl/users/get_current_account',
      body: OAuth2JsonBody({}),
    );
    return DropboxAccount.fromJson(response);
  }
}
