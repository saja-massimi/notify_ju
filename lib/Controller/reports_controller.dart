import 'package:get/get.dart';

class ReportsControllrt extends GetxController{
  var reportType = ''.obs;
  var address = ''.obs;
  var description = ''.obs;
  var date = ''.obs;
  var image = ''.obs;

  void setReportType(String value) {
    reportType.value = value;
  }

  void setAddress(String value) {
    address.value = value;
  }

  void setDescription(String value) {
    description.value = value;
  }

  void setDate(String value) {
    date.value = value;
  }

  void setImage(String value) {
    image.value = value;
  }
}