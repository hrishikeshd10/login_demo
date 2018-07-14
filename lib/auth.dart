import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseUser;
import 'dart:async';

abstract class BaseAuth{
  Future<String> SignInWithEmailAndPassword(String email, String password);
  Future <String> CreateUserWithEmailAndPassword(String email, String password);


}

class Auth implements BaseAuth{

//**********make sure to add the method prototypes to the "abstracr class BaseAuth"************* */


  Future<String> SignInWithEmailAndPassword(String email, String password) async {

     FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return user.uid;
  }

Future <String> CreateUserWithEmailAndPassword(String email, String password) async{

  FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,password: password);
  return user.uid;

}

}
