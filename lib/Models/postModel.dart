// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class postModel {
  final String post_id;
  final String description;
  final String email;
  final List<String>? likesCount;
  final DateTime? time;
  final String? totalLikes;

  postModel({
    required this.post_id,
    required this.description,
    required this.email,
    this.likesCount,
    this.time,
    this.totalLikes
,
  });

  toJson() {
    return {
      'post_id': post_id,
      'email': email,
      'description': description,
      // 'image': image,
      'likesCount': [],
      // 'DislikesCount': [],
      'TimeStamp': time,
      // 'comments': comments,
      'totalLikes': 0
    };
  }

  factory postModel.fromJsonSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return postModel(
      post_id: doc.id,
      description: data!['description'],
      email: data['email'],
      // image: data['image'],
      likesCount: data['likesCount'],
      // DislikesCount: data['DislikesCount'],
      time: data['TimeStamp'],
      totalLikes: data['totalLikes'],
      // comments: doc.id,
    );
  }
}
