import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount =
  await googleSignIn.signIn(); //holds users data and id
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount
      .authentication; //holds authentication after sign in

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication
        .accessToken, //if we want ot access any google serices like maps,gmail
    idToken: googleSignInAuthentication
        .idToken, //identifies every user with a unique id
  );

  final UserCredential authResult =
  await _auth.signInWithCredential(credential);

  final User user = authResult.user;

  if (user != null) {
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    name = user.displayName;
    if (name.contains(" ")) {
      name = name.substring(0, name.indexOf(" "));
    }
    email = user.email;
    imageUrl = user.photoURL;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Signed Out");
}