// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_firebase_project/pages/login_page.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   void register() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         await _auth.createUserWithEmailAndPassword(
//           email: emailController.text.trim(),
//           password: passwordController.text.trim(),
//         );

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Registrasi berhasil!")),
//         );

//         // Navigator.pop(context); // kembali ke login
//         Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const LoginPage()));
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Gagal registrasi: ${e.toString()}")),
//         );
//       }
//     }
//   }

//   String? emailValidator(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email wajib diisi';
//     }
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!emailRegex.hasMatch(value)) {
//       return 'Format email tidak valid';
//     }
//     return null;
//   }

//   String? passwordValidator(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password wajib diisi';
//     }
//     if (value.length < 6) {
//       return 'Minimal 6 karakter';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Register")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(children: [
//             TextFormField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//               validator: emailValidator,
//             ),
//             TextFormField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(labelText: 'Password'),
//               validator: passwordValidator,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(onPressed: register, child: const Text('Register')),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const LoginPage()));
//               },
//               child: const Text("ALREADY HAVE ACCOUNT?  Sign-in"),
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_project/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // void register() async {
  //   if (_formKey.currentState!.validate()) {
  //     // Add password confirmation logic if necessary
  //     try {
  //       await _auth.createUserWithEmailAndPassword(
  //         email: emailController.text.trim(),
  //         password: passwordController.text.trim(),
  //       );

  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Registration successful!")),
  //       );

  //       Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => const LoginPage()));
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Registration failed: ${e.toString()}")),
  //       );
  //     }
  //   }
  // }

  void register() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Buat akun
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Set displayName setelah akun dibuat
        await userCredential.user
            ?.updateDisplayName(nameController.text.trim());
        await userCredential.user?.reload(); // Reload user agar update terambil
        FirebaseAuth.instance.currentUser; // Refresh referensi

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful!")),
        );

        // Arahkan ke login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: ${e.toString()}")),
        );
      }
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Minimum 6 characters';
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Ubah warna ikon back ke putih
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hotel Book App",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Looks like you don’t have an account. Let’s create a new account for you.",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Name is required' : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: emailValidator,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: passwordValidator,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: confirmPasswordValidator,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: register,
                      child: const Text('Create Account',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("ALREADY HAVE ACCOUNT?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text("Sign-in",
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
