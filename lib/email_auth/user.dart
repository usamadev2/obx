// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserS {
  final String uid;
  final String email;
  final String name;
  final String referralCode;
  final String referCode;
  final String referLink;
  final int reward;
  final List listRef;

  UserS({
    required this.listRef,
    required this.uid,
    required this.email,
    required this.name,
    required this.referCode,
    required this.referLink,
    required this.referralCode,
    required this.reward,
  });

  factory UserS.fromJson(Map<String, dynamic> data) {
    return UserS(
      uid: data['uid'] ?? '',
      listRef: data['listRef'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      referCode: data['refer_code'] ?? '',
      referLink: data['refer_link'] ?? '',
      reward: data['reward'] ?? 0,
      referralCode: data['referral_code'] ?? '',
    );
  }

  factory UserS.empty() {
    return UserS(
      uid: '',
      listRef: [],
      name: '',
      email: '',
      referCode: '',
      referLink: '',
      reward: 0,
      referralCode: '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserS &&
        other.uid == uid &&
        other.listRef == listRef &&
        other.email == email &&
        other.name == name &&
        other.referralCode == referralCode &&
        other.referCode == referCode &&
        other.referLink == referLink &&
        other.reward == reward;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        listRef.hashCode ^
        referralCode.hashCode ^
        name.hashCode ^
        referCode.hashCode ^
        referLink.hashCode ^
        reward.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'listRef': listRef,
      'email': email,
      'name': name,
      'referralCode': referralCode,
      'referCode': referCode,
      'referLink': referLink,
      'reward': reward,
    };
  }

  factory UserS.fromMap(Map<String, dynamic> map) {
    return UserS(
      uid: map['uid'] as String,
      listRef: map['listRef'] as List,
      email: map['email'] as String,
      name: map['name'] as String,
      referralCode: map['referralCode'] as String,
      referCode: map['referCode'] as String,
      referLink: map['referLink'] as String,
      reward: map['reward'] as int,
    );
  }
}
