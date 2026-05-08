import 'package:flutter/material.dart';
import 'package:locafy/features/screens/registration_screen.dart';
import 'package:locafy/features/screens/reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  bool get _loginButtonStatus {
    return _emailController.text.isEmpty && _passwordController.text.isEmpty;
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 276,
                  width: double.infinity,

                  decoration: const BoxDecoration(
                    color: Color(0xFF2C56C0),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LOCAFY',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Find Places. Connect Local.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 211, 22, 0),
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.blueGrey,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 25),

                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'youremail@example.com',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          TextField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: (!_loginButtonStatus)
                                  ? null
                                  : () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _loginButtonStatus
                                    ? Colors.grey
                                    : const Color(0xFF2C56C0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 1),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const ResetPassword();
                                      },
                                    ),
                                  );
                                },
                                child: const Text("Reset Password"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),

            Row(
              children: [
                Expanded(child: Divider(endIndent: 23, color: Colors.grey)),

                Text('Or'),
                Expanded(child: Divider(indent: 23, color: Colors.grey)),
              ],
            ),

            SizedBox(height: 20),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {},
              child: Container(
                height: 50,
                width: 257,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black26),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google.jpg', height: 30),
                    SizedBox(width: 10),
                    Text('Continue with Google'),
                  ],
                ),
              ),
            ),

            SizedBox(height: 70),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('New Member?', style: TextStyle(color: Colors.grey)),

                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.only(left: 4),
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),

                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RegistrationScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'Sign Up Here',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
