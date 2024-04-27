// ignore_for_file: non_constant_identifier_names

import 'dart:io';

class reportModel{
final int report_id;
final String? report_type;
final String? incident_description;
final String? incident_location;
final DateTime? report_date;
final File? incident_video;
final File? incident_picture;
final File? incident_voiceNote;
final String? report_status;



  reportModel( 
  {required this.report_id, 
  required this.report_type, 
  required this.incident_description, 
  required this.incident_location, 
  required this.report_date, 
  required this.incident_video, 
  required this.incident_picture,
  required this.incident_voiceNote, 
  required this.report_status, 
});




  factory reportModel.fromJson(Map<String, dynamic> json) {
    return reportModel(
      report_id: json['report_id'],
      report_type: json['report_type'],
      incident_description: json['incident_description'],
      incident_location: json['incident_location'],
      report_date: json['report_date'],
      incident_video: json['incident_video'],
      incident_picture: json['incident_picture'],
      incident_voiceNote: json['incident_voiceNote'],
      report_status: json['report_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'report_id': report_id,
      'report_type': report_type,
      'incident_description': incident_description,
      'incident_location': incident_location,
      'report_date': report_date,
      'incident_video': incident_video,
      'incident_picture': incident_picture,
      'incident_voiceNote': incident_voiceNote,
      'report_status': report_status,
      
    };
  }
}