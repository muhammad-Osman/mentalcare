import 'dart:convert';

class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String dob;
  final String city;
  final String state;
  final String gender;
  final bool? active;
  final dynamic lastSceneTime;
  final bool? premium;
  final String? createdAt;
  final String? updatedAt;
  final String country;
  final String email;
  final String? password;
  final String? passwordConfirmation;
  final String? emailVerifiedAt;
  final String? image;

  User({
    this.id,
    this.active,
    required this.city,
    required this.country,
    this.createdAt,
    required this.dob,
    this.emailVerifiedAt,
    required this.firstName,
    required this.gender,
    required this.lastName,
    this.lastSceneTime,
    this.premium,
    required this.state,
    this.updatedAt,
    required this.email,
    this.password,
    this.image,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "image": image,
      "email": email,
      "email_verified_at": emailVerifiedAt,
      "dob": dob,
      "gender": gender,
      "city": city,
      "state": state,
      "country": country,
      "active": active,
      "last_scene_time": lastSceneTime,
      "premium": premium,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      passwordConfirmation: map['password_confirmation'] ?? '',
      image: map['image'] ?? '',
      emailVerifiedAt: map['email_verified_at'] ?? '',
      dob: map['dob'] ?? '',
      gender: map['gender'] ?? '',
      city: map['city'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      active: map['active'] ?? '',
      lastSceneTime: map['last_scene_time'] ?? '',
      premium: map['premium'] ?? '',
      createdAt: map['created_at'] ?? '',
      country: map['country'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      state: map['state'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(Map<String, dynamic> source) => User.fromMap(source);

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? dob,
    String? city,
    String? state,
    String? gender,
    bool? active,
    dynamic lastSceneTime,
    bool? premium,
    String? createdAt,
    String? updatedAt,
    String? country,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? emailVerifiedAt,
    String? image,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      password: password ?? this.password,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      city: city ?? this.city,
      state: state ?? this.state,
      gender: gender ?? this.gender,
      active: active ?? this.active,
      lastSceneTime: lastSceneTime ?? this.lastSceneTime,
      premium: premium ?? this.premium,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      image: image ?? this.image,
    );
  }
}
