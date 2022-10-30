import 'package:get/get.dart';
import 'package:shar/components/dialogs.dart';
import 'package:shar/components/show_snack.dart';
import 'package:shar/logic/apis/delete_message.dart';
import 'package:shar/logic/apis/profile.dart';
import 'package:shar/logic/apis/send_message_api.dart';

class UserContoller extends GetxController {
  var profile = Profile().obs;
  @override
  void onInit() {
    refreshProfile();
  }

  Future<void> refreshProfile() async {
    profile.value = await getProfileApi();
  }

  Future<void> deleteMessage({
    required String id,
  }) async {
    Dialogs.loading();
    try {
      var user = await deleteMessageApi(
        id: id,
      );
      await refreshProfile();
      Get.back();
    } catch (e) {
      Get.back();
      showSnack(e.toString());
      rethrow;
    }
  }

  Future<void> sendMessage({
    required String user,
    required String message,
  }) async {
    Dialogs.loading();
    try {
      await sendMessageApi(
        user: user,
        message: message,
      );

      Get.back();

      Get.offAllNamed('/');
      showSnack('Message sent');
    } catch (e) {
      Get.back();
      showSnack(e.toString());
      rethrow;
    }
  }
}
