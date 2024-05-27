import 'package:cloud_firestore/cloud_firestore.dart';

class commentModel {
  final String? comment_id;
  final String email;
  final DateTime? time;
  final String commentDescription;
  final String? post_id;

  commentModel({
    this.comment_id,
    required this.email,
    this.time,
    required this.commentDescription,
    this.post_id,
  });

  toJson() {
    return {
      'comment_id': comment_id,
      'email': email,
      'commentDescription': commentDescription,
      'Timestamp': time,
      'post_id': post_id,
    };
  }

  factory commentModel.fromJsonSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return commentModel(
      comment_id: doc.id,
      commentDescription: data!['commentDescription'],
      email: data['email'],
      time: data['Timestamp'],
    );
  }
}
