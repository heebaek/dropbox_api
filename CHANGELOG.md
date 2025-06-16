# Changelog

## 0.0.4

* Made `.tag` field nullable in `DropboxFile` class
  - Added fallback to assume file when tag is null
  
* Fixed download functionality to properly handle file streams

## 0.0.3

* Added support for Dropbox API's pagination using `list_folder/continue` endpoint
  - Added `listFolderContinue` method
  - Removed cursor parameter from `listFolder` method
  - Removed redundant `hasMore` field

## 0.0.2

* Initial release of the Dropbox API client
* Features:
  - OAuth2 authentication
  - File operations (upload, download, copy, move, delete)
  - Folder operations (list, create)
  - Account information retrieval