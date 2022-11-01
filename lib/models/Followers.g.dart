// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Followers.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FollowerUsersAdapter extends TypeAdapter<FollowerUsers> {
  @override
  final int typeId = 0;

  @override
  FollowerUsers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FollowerUsers(
      pk: fields[0] as dynamic,
      username: fields[1] as String?,
      fullName: fields[2] as String?,
      isPrivate: fields[3] as bool?,
      profilePicUrl: fields[4] as String?,
      profilePicId: fields[5] as String?,
      isVerified: fields[6] as bool?,
      hasAnonymousProfilePicture: fields[7] as bool?,
      hasHighlightReels: fields[8] as bool?,
      accountBadges: (fields[9] as List).cast<dynamic>(),
      similarUserId: fields[10] as dynamic,
      latestReelMedia: fields[11] as dynamic,
      isFavorite: fields[12] as bool?,
      timestamp: fields[13] as DateTime,
      stillFollower: fields[14] as bool,
      userIdForAccount: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FollowerUsers obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.pk)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.isPrivate)
      ..writeByte(4)
      ..write(obj.profilePicUrl)
      ..writeByte(5)
      ..write(obj.profilePicId)
      ..writeByte(6)
      ..write(obj.isVerified)
      ..writeByte(7)
      ..write(obj.hasAnonymousProfilePicture)
      ..writeByte(8)
      ..write(obj.hasHighlightReels)
      ..writeByte(9)
      ..write(obj.accountBadges)
      ..writeByte(10)
      ..write(obj.similarUserId)
      ..writeByte(11)
      ..write(obj.latestReelMedia)
      ..writeByte(12)
      ..write(obj.isFavorite)
      ..writeByte(13)
      ..write(obj.timestamp)
      ..writeByte(14)
      ..write(obj.stillFollower)
      ..writeByte(15)
      ..write(obj.userIdForAccount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowerUsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
