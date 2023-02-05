import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  static const userId = 'uid';
  static const profileFileName = 'profile_file_name';
  static const profileFileUrl = 'profile_file_url';
  static const profileThumbnailUrl = 'profile_thumbnail_url';
  static const aspectRatio = 'aspect_ratio';
  static const clubUsername = 'club_username';
  static const clubEmail = 'club_email';
  static const clubPhone = 'club_phone';
  static const clubFirstName = 'club_first_name';
  static const clubLastName = 'club_last_name';
  static const createdAt = 'created_at';
  static const fileStorageId = 'file_storage_id';

  const FirebaseFieldName._();
}
