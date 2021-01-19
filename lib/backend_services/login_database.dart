import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class BackendDBservices {
  static createNewUser({String email, String password}) async {
    final registerUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return registerUser;
  }

  static saveSignUpData({String uid, String name, String mobile, String email}) async {
    FirebaseFirestore.instance.collection('userdata').doc(uid).set({
      "name": name,
      "mobile": mobile,
      "email": email,
      "photoUrl": null,
      "address": null,
      "availableStatus": null,
      "gender": null,
      "dob": null,
    });
  }
}
