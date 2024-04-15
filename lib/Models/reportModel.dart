import 'dart:io';

class reportModel{
final int report_id;
final String? report_type;
final String? incident_description;
final String? incident_location;
final DateTime? report_date;
final DateTime? report_time;
final File? incident_video;
final File? incident_picture;
final File? incident_voiceNote;
final String? report_status;


//foreign keys

final String? user_id;
final int admin_resp;

  reportModel(this.admin_resp, {required this.report_id, required this.report_type, required this.incident_description, required this.incident_location, required this.report_date, required this.report_time, required this.incident_video, required this.incident_picture, required this.incident_voiceNote, required this.report_status, required this.user_id});




  factory reportModel.fromJson(Map<String, dynamic> json) {
    return reportModel(
      json['admin_resp'],
      report_id: json['report_id'],
      report_type: json['report_type'],
      incident_description: json['incident_description'],
      incident_location: json['incident_location'],
      report_date: json['report_date'],
      report_time: json['report_time'],
      incident_video: json['incident_video'],
      incident_picture: json['incident_picture'],
      incident_voiceNote: json['incident_voiceNote'],
      report_status: json['report_status'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'report_id': report_id,
      'report_type': report_type,
      'incident_description': incident_description,
      'incident_location': incident_location,
      'report_date': report_date,
      'report_time': report_time,
      'incident_video': incident_video,
      'incident_picture': incident_picture,
      'incident_voiceNote': incident_voiceNote,
      'report_status': report_status,
      'user_id': user_id,
      'admin_resp': admin_resp,
    };
  }
}