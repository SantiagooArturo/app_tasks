import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first


class TaskCreateDto {
  final String title;
  final String description;
  final String? priority;
  TaskCreateDto({
    required this.title,
    required this.description,
    this.priority,
  });

  TaskCreateDto copyWith({
    String? title,
    String? description,
    String? priority,
  }) {
    return TaskCreateDto(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'priority': priority,
    };
  }

  factory TaskCreateDto.fromMap(Map<String, dynamic> map) {
    return TaskCreateDto(
      title: map['title'] as String,
      description: map['description'] as String,
      priority: map['priority'] != null ? map['priority'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskCreateDto.fromJson(String source) => TaskCreateDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
