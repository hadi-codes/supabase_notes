import 'dart:convert';

import 'package:equatable/equatable.dart';

class Note extends Equatable {
  Note({
    this.id,
    this.user_id,
    this.title,
    this.body,
    required this.createdAt,
    this.updatedAt,
  });
  factory Note.empty() =>
      Note(createdAt: DateTime.now(), updatedAt: DateTime.now());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      createdAt: DateTime.tryParse(map['createdAt'].toString()),
      updatedAt: DateTime.tryParse((map['updatedAt'].toString())),
      user_id: map['user_id'],
    );
  }

  final int? id;
  final String? title;
  final String? body;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? user_id;

  Note copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? user_id,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'createdAt': createdAt?.toIso8601String(),
      'user_id': user_id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      id,
      title,
      body,
      createdAt,
      updatedAt,
      user_id,
    ];
  }
}
