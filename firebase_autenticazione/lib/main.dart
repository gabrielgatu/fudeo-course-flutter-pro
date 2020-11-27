import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                if (userSnapshot.data == null)
                  return LoginPage();
                else
                  return HomePage();
              },
            );
          } else
            return Scaffold(
              body: Center(
                  child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              )),
            );
        },
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(text: "gabriel.dny@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "supersecretpassword");

  void loginOrRegister() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: body(),
    );
  }

  Widget body() => SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text("Ben ritornato!", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              SizedBox(height: 50),
              field(
                controller: emailController,
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),
              field(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
                textInputType: TextInputType.text,
              ),
              SizedBox(height: 50),
              button(
                text: "Accedi o crea un nuovo account",
                onPressed: loginOrRegister,
              ),
              SizedBox(height: 10),
              Divider(color: Colors.grey.shade400),
              SizedBox(height: 10),
              GoogleAuthButton(
                onPressed: signInWithGoogle,
              ),
            ],
          ),
        ),
      );

  Widget field({
    bool obscureText = false,
    @required TextEditingController controller,
    @required TextInputType textInputType,
    @required String hintText,
  }) =>
      Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: textInputType,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
            ),
          ));

  Widget button({
    @required String text,
    @required Function onPressed,
  }) =>
      MaterialButton(
        minWidth: double.infinity,
        height: 55,
        onPressed: onPressed,
        color: Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text(text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Logged in as: ${FirebaseAuth.instance.currentUser.email}"),
          SizedBox(height: 10),
          RaisedButton(
            child: Text("Logout"),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ]),
      ),
    );
  }
}
