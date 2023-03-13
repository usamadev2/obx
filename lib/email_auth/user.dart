import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserS {
  final String uid;
  final String? parentUid;
  final String email;
  final String name;
  final String referralCode;
  final String referCode;
  final String referLink;
  final int reward;
  final List listRef;

  UserS({
    required this.uid,
    required this.parentUid,
    required this.email,
    required this.name,
    required this.referralCode,
    required this.referCode,
    required this.referLink,
    required this.reward,
    required this.listRef,
  });

  UserS copyWith({
    String? uid,
    String? parentUid,
    String? email,
    String? name,
    String? referralCode,
    String? referCode,
    String? referLink,
    int? reward,
    List? listRef,
  }) {
    return UserS(
      uid: uid ?? this.uid,
      parentUid: parentUid ?? this.parentUid,
      email: email ?? this.email,
      name: name ?? this.name,
      referralCode: referralCode ?? this.referralCode,
      referCode: referCode ?? this.referCode,
      referLink: referLink ?? this.referLink,
      reward: reward ?? this.reward,
      listRef: listRef ?? this.listRef,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'parentUid': parentUid,
      'email': email,
      'name': name,
      'referralCode': referralCode,
      'referCode': referCode,
      'referLink': referLink,
      'reward': reward,
      'listRef': listRef,
    };
  }

  factory UserS.fromMap(Map<String, dynamic> map) {
    return UserS(
      uid: map['uid'] as String,
      parentUid: map['parentUid'] as String?,
      email: map['email'] as String,
      name: map['name'] as String,
      referralCode: map['referralCode'] as String,
      referCode: map['referCode'] as String,
      referLink: map['referLink'] as String,
      reward: map['reward'] as int,
      listRef: List.from(map['listRef'] as List),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserS.fromJson(String source) =>
      UserS.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserS(uid: $uid, parentUid: $parentUid, email: $email, name: $name, referralCode: $referralCode, referCode: $referCode, referLink: $referLink, reward: $reward, listRef: $listRef)';
  }

  @override
  bool operator ==(covariant UserS other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.parentUid == parentUid &&
        other.email == email &&
        other.name == name &&
        other.referralCode == referralCode &&
        other.referCode == referCode &&
        other.referLink == referLink &&
        other.reward == reward &&
        listEquals(other.listRef, listRef);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        parentUid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        referralCode.hashCode ^
        referCode.hashCode ^
        referLink.hashCode ^
        reward.hashCode ^
        listRef.hashCode;
  }
}
