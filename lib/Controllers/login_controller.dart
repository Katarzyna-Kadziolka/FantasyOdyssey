import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final _googleSignIn = GoogleSignIn(scopes: ["https://www.googleapis.com/auth/fitness.activity.read"]);
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  login() async {
    googleAccount.value = await _googleSignIn.signIn();
  }
}