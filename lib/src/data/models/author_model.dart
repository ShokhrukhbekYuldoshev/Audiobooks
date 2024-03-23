import 'dart:convert';
import 'package:audiobooks/src/domain/entities/author_entity.dart';

class AuthorModel extends AuthorEntity {
  const AuthorModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.dob,
    required super.dod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'dob': dob,
      'dod': dod,
    };
  }

  @override
  factory AuthorModel.fromMap(Map<String, dynamic> map) {
    return AuthorModel(
      id: map['id'] as String,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      dob: map['dob'],
      dod: map['dod'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorModel.fromJson(String source) =>
      AuthorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AuthorEntity toEntity() {
    return AuthorEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      dob: dob,
      dod: dod,
    );
  }
}
