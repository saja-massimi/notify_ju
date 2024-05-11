// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class postModel {
  final String post_id;
  final String description;
  final String email;
  // final String? image;
  final List<String>? likesCount;
  // final List<int>? DislikesCount;
  // final String? comments;
  final DateTime? time;

  postModel({
    required this.post_id,
    required this.description,
    required this.email,
    // this.image,
    this.likesCount,
    // this.DislikesCount,
    // this.comments,
    this.time,
  });

  toJson() {
    return {
      'post_id': post_id,
      'email': email,
      'description': description,
      // 'image': image,
      'likesCount': [],
      // 'DislikesCount': [],
      // 'comments': comments,
      'TimeStamp': time,
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
      // comments: data['comments'],
      time: data['TimeStamp'],
    );
  }
}
