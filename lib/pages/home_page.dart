import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_project/pages/login_page.dart';
import 'package:flutter_firebase_project/services/check_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // void logout(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (context) => const LoginPage()));
  // }

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const CheckAuth()), // ✅
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Home Page"),
      //   actions: [
      //     IconButton(
      //       onPressed: () => logout(context),
      //       icon: const Icon(Icons.logout),
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: false, // ini akan menghilangkan tombol back
        title: Center(child: const Text("Home Page")),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Tambahkan ini untuk vertikal center
          children: [
            Text("Selamat datang, ${user?.email ?? 'User'}"),
          ],
        ),
      ),
    );
  }
}
