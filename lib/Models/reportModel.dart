import 'dart:io';

class reportModel{
String? report_id;
String? report_type;
String? incident_description;
String? incident_location;
DateTime? report_date;
DateTime? report_time;
File? incident_video;
File? incident_picture;
File? incident_voiceNote;
String? report_status;


//foreign keys

String? user_id;
String? admin_id;

}