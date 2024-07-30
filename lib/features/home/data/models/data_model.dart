import 'package:flutter_comment/core/common/entities/data_entity.dart';

class DataModel extends DataEntity {
  DataModel(
      {required super.postId,
      required super.id,
      required super.name,
      required super.email,
      required super.body});

       DataModel copyWith({
    int? postId,
    int? id,
    String? name,
    String? email,
    String? body,
  }) {
    return DataModel(
      postId: postId ?? this.postId,
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'id': id,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      postId: map['postId'] as int,
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      body: map['body'] as String,
    );
  }


}
