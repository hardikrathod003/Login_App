import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helper/AuthHelper.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  GlobalKey<FormState> signInKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController signinemailController = TextEditingController();
  TextEditingController signinpasswordController = TextEditingController();

  String? email;
  String? password;
  String? signinemail;
  String? signinpassword;

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Firebase App"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  "https://images.unsplash.com/photo-1528459801416-a9e53bbf4e17?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8c3BsYXNoJTIwc2NyZWVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                  fit: BoxFit.fill,
                  height: _height - 88,
                  width: _width,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: signInKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: TextFormField(
                                  controller: emailController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter valid username/email";
                                    }
                                    null;
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: "User Name/ Email",
                                      hintStyle: GoogleFonts.ubuntu(
                                          color: Colors.grey),
                                      contentPadding: const EdgeInsets.only(
                                          top: 15, bottom: 15),
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                child: TextFormField(
                                  controller: passwordController,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Enter valid password";
                                    }
                                    null;
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      password = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: GoogleFonts.ubuntu(
                                          color: Colors.grey),
                                      contentPadding: const EdgeInsets.only(
                                          top: 15, bottom: 15),
                                      border: const UnderlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          if (signInKey.currentState!.validate()) {
                            signInKey.currentState!.save();

                            User? user = await FirebaseauthHelper
                                .firebaseauthHelper
                                .signInUser(email: email!, password: password!);

                            if (user != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Sign In Successful.."),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context).pop();

                              Navigator.of(context).pushNamed('dashboardpage');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Sign In Failed! plz Try Again..",
                                  ),
                                  backgroundColor: Colors.redAccent,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.of(context).pop();
                            }
                            signinemailController.clear();
                            signinpasswordController.clear();

                            signinemail = "";
                            signinpassword = "";
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 50, right: 50),
                            decoration: BoxDecoration(
                                color: const Color(0xff6a74ce),
                                borderRadius: BorderRadius.circular(30)),
                            height: 50,
                            child: Center(
                                child: Text(
                              "Login",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Forgot your password?",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                User? user = await FirebaseauthHelper
                                    .firebaseauthHelper
                                    .signInAnonymously();

                                if (user != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Login Successful.. with UID:${user.uid}"),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  Navigator.of(context)
                                      .pushReplacementNamed('dashboardpage');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Login Failed! plz Try Again.."),
                                      backgroundColor: Colors.redAccent,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xff38a4ef),
                                        offset: Offset(3.0, 3.0),
                                        blurRadius: 15,
                                        spreadRadius: 1.0),
                                    BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-3.0, -3.0),
                                        blurRadius: 15,
                                        spreadRadius: 1.0),
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xff38a4ef),
                                ),
                                height: 40,
                                width: 150,
                                child: Center(
                                  child: Text(
                                    "Guest",
                                    style: GoogleFonts.ubuntu(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                User? user = await FirebaseauthHelper
                                    .firebaseauthHelper
                                    .signinwithgoogle();

                                if (user != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Login Successful.. with UID:${user.uid}"),
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  Navigator.of(context)
                                      .pushReplacementNamed('dashboardpage');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Login Failed! plz Try Again.."),
                                      backgroundColor: Colors.redAccent,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xff38a4ef),
                                        offset: Offset(3.0, 3.0),
                                        blurRadius: 15,
                                        spreadRadius: 1.0),
                                    BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-3.0, -3.0),
                                        blurRadius: 15,
                                        spreadRadius: 1.0),
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0xff5172b4),
                                ),
                                height: 40,
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/225px-Google_%22G%22_Logo.svg.png",
                                        height: 25,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Google",
                                        style: GoogleFonts.ubuntu(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: GoogleFonts.ubuntu(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: validatorandSignUp,
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  validatorandSignUp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text("Sign Up"),
        ),
        content: Form(
          key: signUpKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (val) {
                  (val!.isEmpty) ? "Enter Email" : null;
                },
                controller: emailController,
                onSaved: (val) {
                  email = val;
                },
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Email",
                  hintText: "Enter Email Here...",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: (val) {
                  (val!.isEmpty) ? "Enter Password" : null;
                },
                controller: passwordController,
                onSaved: (val) {
                  password = val;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Enter Password Here...",
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Sign Up"),
            onPressed: () async {
              if (signUpKey.currentState!.validate()) {
                signUpKey.currentState!.save();

                User? user = await FirebaseauthHelper.firebaseauthHelper
                    .signUpUser(email: email!, password: password!);

                if (user != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: const Text("Sign Up Successful.."),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  Navigator.of(context).pop();
                  // Navigator.of(context).pushReplacementNamed('/');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Sign UP Failed! plz Try Again.."),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              }

              emailController.clear();
              passwordController.clear();
              setState(() {
                email = "";
                password = "";
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                emailController.clear();
                passwordController.clear();
                setState(() {
                  email = "";
                  password = "";
                });
                Navigator.of(context).pop();
              },
              child: const Text("Cancel")),
        ],
      ),
    );
  }
}
