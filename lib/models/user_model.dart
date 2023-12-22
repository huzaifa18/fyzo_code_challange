class UserModel {
  final String? name;
  final String? profilePic;
  final String? dob;
  UserModel({
    required this.name,
    required this.profilePic,
    required this.dob,
  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? dob,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      dob: dob ?? this.dob,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'dob': dob,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      dob: map['dob'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, profilePic: $profilePic, dob: $dob)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.profilePic == profilePic &&
        other.dob == dob;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profilePic.hashCode ^
        dob.hashCode;
  }
}