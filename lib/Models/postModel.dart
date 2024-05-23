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
    this.totalLikes,
  });

  Map<String, dynamic> toJson() {
    return {
      'post_id': post_id,
      'email': email,
      'description': description,
      'likesCount': likesCount ?? [],
      'TimeStamp': time,
      'totalLikes': totalLikes ?? '0',
    };
  }

  factory postModel.fromJsonSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return postModel(
      post_id: doc.id,
      description: data['description'] ?? '',
      email: data['email'] ?? '',
      likesCount: List<String>.from(data['likesCount'] ?? []),
      time: (data['TimeStamp'] as Timestamp?)?.toDate(),
      totalLikes: data['totalLikes']?.toString() ?? '0',
    );
  }
}
