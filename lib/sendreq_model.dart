// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SendRequest {
  String? senderName;
  String? senderId;
  String? receiverName;
  String? receiverId;
  String? uniqueId;
  SendRequest({
    this.senderName,
    this.senderId,
    this.receiverName,
    this.receiverId,
    this.uniqueId,
  });

  SendRequest copyWith({
    String? senderName,
    String? senderId,
    String? receiverName,
    String? receiverId,
    String? uniqueId,
  }) {
    return SendRequest(
      senderName: senderName ?? this.senderName,
      senderId: senderId ?? this.senderId,
      receiverName: receiverName ?? this.receiverName,
      receiverId: receiverId ?? this.receiverId,
      uniqueId: uniqueId ?? this.uniqueId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderName': senderName,
      'senderId': senderId,
      'receiverName': receiverName,
      'receiverId': receiverId,
      'uniqueId': uniqueId,
    };
  }

  factory SendRequest.fromMap(Map<String, dynamic> map) {
    return SendRequest(
      senderName:
          map['senderName'] != null ? map['senderName'] as String : null,
      senderId: map['senderId'] != null ? map['senderId'] as String : null,
      receiverName:
          map['receiverName'] != null ? map['receiverName'] as String : null,
      receiverId:
          map['receiverId'] != null ? map['receiverId'] as String : null,
      uniqueId: map['uniqueId'] != null ? map['uniqueId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SendRequest.fromJson(String source) =>
      SendRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SendRequest(senderName: $senderName, senderId: $senderId, receiverName: $receiverName, receiverId: $receiverId, uniqueId: $uniqueId)';
  }

  @override
  bool operator ==(covariant SendRequest other) {
    if (identical(this, other)) return true;

    return other.senderName == senderName &&
        other.senderId == senderId &&
        other.receiverName == receiverName &&
        other.receiverId == receiverId &&
        other.uniqueId == uniqueId;
  }

  @override
  int get hashCode {
    return senderName.hashCode ^
        senderId.hashCode ^
        receiverName.hashCode ^
        receiverId.hashCode ^
        uniqueId.hashCode;
  }
}
