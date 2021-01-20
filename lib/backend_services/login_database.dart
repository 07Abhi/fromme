import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BackendDBservices {
  static createNewUser({String email, String password}) async {
    final registerUser = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return registerUser;
  }

  static saveSignUpData(
      {String uid, String name, String mobile, String email}) async {
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

  static saveGoogleSignUpData(GoogleSignIn googleSignIn) async {
    await FirebaseFirestore.instance
        .collection('userdata')
        .doc(googleSignIn.currentUser.id)
        .set({
      "address": null,
      "availableStatus": true,
      "email": googleSignIn.currentUser.email,
      "gender": null,
      "isOnline": false,
      "mobile": null,
      "name": googleSignIn.currentUser.displayName,
      "photoUrl": googleSignIn.currentUser.photoUrl,
      "uid": googleSignIn.currentUser.id
    });
  }

  static saveFacebookSignUpData(Map userProfile) async {
    await FirebaseFirestore.instance
        .collection('userdata')
        .doc(userProfile['id'])
        .set({
      'address': null,
      'availableStatus': true,
      'dob': null,
      'email': userProfile['email'],
      'gender': null,
      'isOnline': true,
      'mobile': null,
      'name': userProfile['name'],
      'photoUrl': null,
      'uid': userProfile['id']
    });
  }

  static updateUserMobileNumber(String mobileNumber, {String uid}) async {
    await FirebaseFirestore.instance.collection("userdata").doc(uid).update({
      "mobile": mobileNumber,
    });
  }

  static saveEditProfileChanges(
      {String uid,
      String name,
      String gender,
      String address,
      String dob,
      bool availableStatus,
      String photoUrl}) async {
    await FirebaseFirestore.instance.collection('userdata').doc(uid).update({
      'name': name,
      'gender': gender,
      'address': address,
      'dob': dob,
      'availableStatus': true,
      'photoUrl': photoUrl,
      'uid': uid
    });
  }
}
