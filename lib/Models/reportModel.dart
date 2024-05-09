// ignore_for_file: non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';

class reportModel{
  
String? report_id;
String? user_email;
final String report_type;
final String? incident_description;
final GeoPoint? incident_location;
final DateTime report_date;
final String? incident_picture;
late final String report_status;



  reportModel( 
  { this.report_id,
  this.user_email, 
  required this.report_type, 
  this.incident_description, 
  this.incident_location, 
  required this.report_date, 
  this.incident_picture, 
  required this.report_status, 
});

    toJson() {
    return {
      'report_id': report_id,
      'user_email': user_email,
      'report_type': report_type,
      'incident_description': incident_description,
      'incident_location': incident_location,
      'report_date': report_date,
      'incident_picture': incident_picture,
      'report_status': report_status,
      
    };
  }


  factory reportModel.fromJSnapshot(DocumentSnapshot< Map<String, dynamic>> doc) {
    final data = doc.data();
    return reportModel(
      report_id: doc.id,
      user_email: data!['user_email'],
      report_type: data['report_type'],
      incident_description: data['incident_description'],
      incident_location: data['incident_location'],
      report_date: data['report_date'],
      incident_picture: data['incident_picture'],
      report_status: data['report_status'], 
    );
  }


}