import 'package:authexam_firebase/routes.dart';
import 'package:authexam_firebase/service/auth_service.dart';
import 'package:authexam_firebase/service/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                ),
                icon: Icon(Icons.email),
                labelText: "Email",
                hintText: "Enter Your Email",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.black),
                ),
                icon: Icon(Icons.password),
                labelText: "Password",
                hintText: "Enter Your Password",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 2,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 15),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.instance.signin);
                  },
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                AuthService.instance.signInWithGoogle().then(
                      (value) =>
                          Navigator.of(context).pushReplacementNamed('home'),
                    );
              },
              icon: const Icon(Icons.g_mobiledata),
            ),
            ElevatedButton(
              onPressed: () async {
                User? user = await AuthService.instance.register(
                  email: emailController.text,
                  password: passwordController.text,
                );

                if (user != null) {
                  await FireStoreService.instance.addUser(user: user);
                  await FireStoreService.instance.getUser();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("REGISTERED !!"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text("email-pass REGISTER"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                User? user = await AuthService.instance.signIn(
                  email: emailController.text,
                  psw: passwordController.text,
                );

                if (user != null) {
                  await FireStoreService.instance.getUser();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("SIGN UP !!"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  Navigator.of(context).pushReplacementNamed('home_page');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("FAILLED !!"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text("email-pass Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}
