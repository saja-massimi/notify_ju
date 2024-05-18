import 'package:get/get.dart';
import 'package:notify_ju/Models/adminModel.dart';
import 'package:notify_ju/Models/userModel.dart';
import 'package:notify_ju/Repository/authentication_repository.dart';
import 'package:notify_ju/Repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;

    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to view profile");
    }
  }

  Future<String> getUserName() async {
    UserModel user = await getUserData();
    return user.username;
  }

  Future<String> getAdminName() async {
    adminModel admin = await getAdminData();
    return admin.admin_name;
  }

  getAdminData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getAdminDetails(email);
    } else {
      Get.snackbar("Error", "Login to view profile");
    }
  }

}
