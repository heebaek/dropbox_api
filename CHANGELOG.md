# Changelog

## 0.0.2

* Initial release of the Dropbox API client
* Features:
  - OAuth2 authentication
  - File operations (upload, download, copy, move, delete)
  - Folder operations (list, create)
  - Account information retrieval

## 0.0.3

* Added support for Dropbox API's pagination using `list_folder/continue` endpoint
  - Added `listFolderContinue` method
  - Removed cursor parameter from `listFolder` method