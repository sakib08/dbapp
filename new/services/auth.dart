import 'package:firebase_auth/firebase_auth.dart';
import 'package:sondhani/models/user.dart';
import 'package:sondhani/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user objs based on fire base 
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid:user.uid) : null;
  }

  //auth change user stream

  Stream<User> get user{
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  //sign in annon
  Future singInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in with email and pass

  Future signInWithEmailAndPassword(String email,String password) async{
      try{
        AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);
        FirebaseUser  user = result.user;
        return _userFromFirebaseUser(user);
      }catch(e){
        print(e.toString());
        return null;
      }

    }

  //register with email and password 

    Future registerWithEmailAndPassword(String email,String password) async{
      try{
        AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password: password);
        FirebaseUser  user = result.user;

        //create a new document for the user with the uid
        DatabaseService(uid: user.uid).updateUserData('10/10/1995', 'someone','A+','Dhaka','+88017111111111',email,'mirpur',0.0,0.0,'yes');

        return _userFromFirebaseUser(user);
      }catch(e){
        print(e.toString());
        return null;
      }

    }
  //sign out
  Future signout() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}