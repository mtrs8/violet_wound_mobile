// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_namesdynamicdynamicdynamicdynamicdynamicdynamicdynamicdynamicdynamic
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:violet_wound/models/feridas.dart';

class Pacientes {
  String? iD;
  String nome;
  String cpf;
  String data;
  double peso;
  double altura;
  int hgt;
  String pressao;
  int cardio;
  List<Wound>? feridas = [];
  Pacientes({
    this.iD,
    required this.nome,
    required this.cpf,
    required this.data,
    required this.peso,
    required this.altura,
    required this.hgt,
    required this.pressao,
    required this.cardio,
    this.feridas,
  });
  
  

  Pacientes copyWith({
    String? iD,
    String? nome,
    String? cpf,
    String? data,
    double? peso,
    double? altura,
    int? hgt,
    String? pressao,
    int? cardio,
    List<Wound>? feridas,
  }) {
    return Pacientes(
      iD: iD ?? this.iD,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      data: data ?? this.data,
      peso: peso ?? this.peso,
      altura: altura ?? this.altura,
      hgt: hgt ?? this.hgt,
      pressao: pressao ?? this.pressao,
      cardio: cardio ?? this.cardio,
      feridas: feridas ?? this.feridas,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iD': iD,
      'nome': nome,
      'cpf': cpf,
      'data': data,
      'peso': peso,
      'altura': altura,
      'hgt': hgt,
      'pressao': pressao,
      'cardio': cardio,
      'feridas': feridas == null ? [] :feridas?.map((x) => x.toMap()).toList(),
    };
  }

  factory Pacientes.fromMap(Map<String, dynamic> map) {
    return Pacientes(
      iD: map['iD'] != null ? map['iD'] as String : null,
      nome: map['nome'] as String,
      cpf: map['cpf'] as String,
      data: map['data'] as String,
      peso: map['peso'] * 1.0,
      altura: map['altura'] * 1.0,
      hgt: map['hgt'] as int,
      pressao: map['pressao'] as String,
      cardio: map['cardio'] as int,
      feridas: (map['feridas'] as List<dynamic>).map((item) => Wound.fromMap(item)).toList()
    );
  }
//List<Wound> wounds = (map['ferida'] as List<dynamic>).map((item) => Wound.fromMap(item)).toList();

  String toJson() => json.encode(toMap());

  factory Pacientes.fromJson(String source) => Pacientes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pacientes(iD: $iD, nome: $nome, cpf: $cpf, data: $data, peso: $peso, altura: $altura, hgt: $hgt, pressao: $pressao, cardio: $cardio, feridas: $feridas)';
  }

  @override
  bool operator ==(covariant Pacientes other) {
    if (identical(this, other)) return true;
  
    return 
      other.iD == iD &&
      other.nome == nome &&
      other.cpf == cpf &&
      other.data == data &&
      other.peso == peso &&
      other.altura == altura &&
      other.hgt == hgt &&
      other.pressao == pressao &&
      other.cardio == cardio &&
      listEquals(other.feridas, feridas);
  }

  @override
  int get hashCode {
    return iD.hashCode ^
      nome.hashCode ^
      cpf.hashCode ^
      data.hashCode ^
      peso.hashCode ^
      altura.hashCode ^
      hgt.hashCode ^
      pressao.hashCode ^
      cardio.hashCode ^
      feridas.hashCode;
  }
}
