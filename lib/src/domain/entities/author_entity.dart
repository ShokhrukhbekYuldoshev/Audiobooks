import 'package:audiobooks/src/data/models/author_model.dart';
import 'package:equatable/equatable.dart';

class AuthorEntity extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? dob; // date of birth
  final String? dod; // date of death

  const AuthorEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.dob,
    this.dod,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, dob, dod];

  AuthorModel toModel() {
    return AuthorModel(
      id: id,
      firstName: firstName,
      lastName: lastName,
      dob: dob,
      dod: dod,
    );
  }

  String get fullName => '$firstName $lastName';
}
