import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordHidden = true;

  // WARNA DARI DESAIN
  final Color hijauMuda = const Color(0xFF8BAE66);
  final Color hijauTua = const Color(0xFF628141);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // LOGO
                Image.asset(
                  'assets/logo.png',
                  height: 140,
                ),

                const SizedBox(height: 32),

                // USERNAME / EMAIL
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'USERNAME / EMAIL',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan ID pengguna',
                        prefixIcon: const Icon(Icons.email),
                        filled: true,
                        fillColor: hijauMuda,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // PASSWORD
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PASSWORD',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      obscureText: isPasswordHidden,
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordHidden
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: hijauMuda,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // BUTTON LOGIN
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: hijauTua,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      // login supabase nanti
                    },
                    child: const Text(
                      'Masuk Sekarang',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
