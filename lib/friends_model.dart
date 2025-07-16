// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FriendModel {
  String? recieverId;
  String? recieverName;
  String? uniqId;
  String? userID;
  FriendModel({
    this.recieverId,
    this.recieverName,
    this.uniqId,
    this.userID,
  });

  FriendModel copyWith({
    String? recieverId,
    String? recieverName,
    String? uniqId,
    String? userID,
  }) {
    return FriendModel(
      recieverId: recieverId ?? this.recieverId,
      recieverName: recieverName ?? this.recieverName,
      uniqId: uniqId ?? this.uniqId,
      userID: userID ?? this.userID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recieverId': recieverId,
      'recieverName': recieverName,
      'uniqId': uniqId,
      'userID': userID,
    };
  }

  factory FriendModel.fromMap(Map<String, dynamic> map) {
    return FriendModel(
      recieverId:
          map['recieverId'] != null ? map['recieverId'] as String : null,
      recieverName:
          map['recieverName'] != null ? map['recieverName'] as String : null,
      uniqId: map['uniqId'] != null ? map['uniqId'] as String : null,
      userID: map['userID'] != null ? map['userID'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendModel.fromJson(String source) =>
      FriendModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FriendModel(recieverId: $recieverId, recieverName: $recieverName, uniqId: $uniqId, userID: $userID)';
  }

  @override
  bool operator ==(covariant FriendModel other) {
    if (identical(this, other)) return true;

    return other.recieverId == recieverId &&
        other.recieverName == recieverName &&
        other.uniqId == uniqId &&
        other.userID == userID;
  }

  @override
  int get hashCode {
    return recieverId.hashCode ^
        recieverName.hashCode ^
        uniqId.hashCode ^
        userID.hashCode;
  }
}
