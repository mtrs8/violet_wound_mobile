// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:violet_wound/models/pacientes.dart';

class User {
  String email;
  String senha;
  String name;
  List<Pacientes>? pacientes;
  User({
    required this.email,
    required this.senha,
    required this.name,
    this.pacientes,
  });

  

  User copyWith({
    String? email,
    String? senha,
    String? name,
    List<Pacientes>? pacientes,
  }) {
    return User(
      email: email ?? this.email,
      senha: senha ?? this.senha,
      name: name ?? this.name,
      pacientes: pacientes ?? this.pacientes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'senha': senha,
      'name': name,
      'pacientes': pacientes?.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      senha: map['senha'] == null ? '' : map['senha'] as String,
      name: map['name'] as String,
      pacientes: List<Pacientes>.from((map['pacientes'] as List<dynamic>).map<Pacientes>((x) => Pacientes.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(email: $email, senha: $senha, name: $name, pacientes: $pacientes)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.senha == senha &&
      other.name == name &&
      listEquals(other.pacientes, pacientes);
  }

  @override
  int get hashCode {
    return email.hashCode ^
      senha.hashCode ^
      name.hashCode ^
      pacientes.hashCode;
  }
}
