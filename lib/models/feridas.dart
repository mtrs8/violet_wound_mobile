// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Wound {
  String? id;
  final String local;
  final String tempo;
  final String tipologia;
  final String? pseudomonas;
  final String? carga;
  final String? imageurl;
  
  Wound({
    this.id,
    required this.local,
    required this.tempo,
    required this.tipologia,
    this.pseudomonas,
    this.carga,
    this.imageurl,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'local': local,
      'tempo': tempo,
      'tipologia': tipologia,
      'pseudomonas': pseudomonas,
      'carga': carga,
      'imageurl': imageurl,
    };
  }

  factory Wound.fromMap(Map<String, dynamic> map) {
    return Wound(
      id: map['id'] != null ? map['id'] as String : null,
      local: map['local'] as String,
      tempo: map['tempo'] as String,
      tipologia: map['tipologia'] as String,
      pseudomonas: map['pseudomonas'] != null ? map['pseudomonas'] as String : null,
      carga: map['carga'] != null ? map['carga'] as String : null,
      imageurl: map['imageurl'] != null ? map['imageurl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wound.fromJson(String source) => Wound.fromMap(json.decode(source) as Map<String, dynamic>);
}
