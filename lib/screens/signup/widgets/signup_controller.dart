import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inbrief/data/repositories/authentication/authentication_repository.dart';
import 'package:inbrief/screens/signup/widgets/verify_email.dart';
import 'package:inbrief/utils/constants/image_strings.dart';
import 'package:inbrief/utils/popups/full_screen_loader.dart';
import '../../../common/widget/success_screen/success_screen.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../model/user_model.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/popups/loaders.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../login/login.dart';

class SignupController extends GetxController{
  static SignupController get instance => Get.find();


  // Variables
  final hidePassword = true.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Form key for form validation

  // signup
  void signup() async{
    try{
      // start loader
      TFullScreenLoader.openLoadingDialog('we are processing your information...', TImages.doceranimation); // TImages.doceranimation

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if(signupFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
      }
      //TFullScreenLoader.stopLoading();
      // Form validation
      if(!signupFormKey.currentState!.validate()){
        return;
      }

      // Register user in the Firebase Authentication & Save data in firebase
      final UserCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // save authentication in the firebase firestore
      final newUser = UserModel(
        id: UserCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim()
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);


      // Show Success Message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Login to continue.');


      //TFullScreenLoader.stopLoading();


      // Move to Created Success Screen
      Get.off(() => SuccessScreen(
        image: TImages.staticSuccessIllustration,
        title: TTexts.yourAccountCreatedTitle,
        subTitle: TTexts.yourAccountCreatedSubTitle,
        onPressed: () => Get.to(() => LoginScreen()),
      ));

    } catch(e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'oh snap!', message: e.toString());
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

}