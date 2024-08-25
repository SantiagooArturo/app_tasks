// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:convert';

class TaskModel {
    final String? id;
    final String title;
    final String description;
    final String? priority;
  TaskModel({
    this.id,
    required this.title,
    required this.description,
    this.priority,
  });

    

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] as String,
      description: map['description'] as String,
      priority: map['priority'] != null ? map['priority'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
    );
  }
}
