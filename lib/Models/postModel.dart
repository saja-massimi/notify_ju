// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class postModel {
  final String post_id;
  final String description;
  final String email;
  final String? image;
  final List<int>? likesCount;
  final List<int>? DislikesCount;
  final String? comments;
  final DateTime time;

  postModel({
    required this.post_id,
    required this.description,
    required this.email,
    this.image,
    this.likesCount,
    this.DislikesCount,
    this.comments,
    required this.time,
  });

  toJson() {
    return {
      'post_id': post_id,
      'user_email': email,
      'description': description,
      'image': image,
      'likesCount': 0,
      'DislikesCount': 0,
      'comments': comments,
      'time': time,
    };
  }

  factory postModel.fromJsonSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return postModel(
      post_id: doc.id,
      description: data!['description'],
      email: data['user_email'],
      image: data['image'],
      likesCount: data['likesCount'],
      DislikesCount: data['DislikesCount'],
      comments: data['comments'],
      time: data['time'],
    );
  }
}
