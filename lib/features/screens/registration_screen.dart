import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locafy/features/screens/login_screen.dart';
import 'package:locafy/features/screens/mobile_verification_screen.dart';
import 'package:locafy/features/validators/email&password_validators/validator.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool get _fields {
    return _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _userNameController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;
  }

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;
  final bool _isInvalid = false;

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(() => setState(() {}));
    _lastNameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _userNameController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
    _confirmPasswordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 25),

                              TextFormField(
                                controller: _firstNameController,
                                key: ValueKey('FirstNameField'),
                                keyboardType: TextInputType.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'First name required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  hintText: 'Barry',
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF2C56C0),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              TextFormField(
                                controller: _lastNameController,
                                key: ValueKey('LastNameField'),
                                keyboardType: TextInputType.name,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'LastName is required'
                                    : null,
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  hintText: 'Dave',
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF2C56C0),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              TextFormField(
                                controller: _userNameController,
                                key: ValueKey('UserNameField'),
                                keyboardType: TextInputType.name,
                                validator: (value) =>
                                    value == null || value.isEmpty
                                    ? 'UserName is required'
                                    : null,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  hintText: 'jane',
                                  prefixIcon: const Icon(Icons.person_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF2C56C0),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              TextFormField(
                                controller: _emailController,
                                validator: (value) => Validator.email(value),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Enter your email',
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF2C56C0),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 15),

                              TextFormField(
                                controller: _passwordController,
                                obscureText: !_isPasswordVisible,
                                validator: (value) => Validator.password(value),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Enter your password',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF2C56C0),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
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

                              const SizedBox(height: 15),

                              TextFormField(
                                controller: _confirmPasswordController,
                                validator: (value) => Validator.confirmPassword(
                                  value,
                                  _passwordController.text,
                                ),
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  hintText: 'Re-enter your password',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF2C56C0),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
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

                              if (_errorMessage != null)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    border: Border.all(
                                      color: Colors.red.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    _errorMessage!,
                                    style: TextStyle(
                                      color: Colors.red.shade700,
                                    ),
                                  ),
                                ),

                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: (_fields && !_isLoading)
                                      ? () async {
                                          setState(() {
                                            _errorMessage = null;
                                          });

                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          }

                                          final emailExists =
                                              await FirebaseFirestore.instance
                                                  .collection('users')
                                                  .where(
                                                    'email',
                                                    isEqualTo: _emailController
                                                        .text
                                                        .trim(),
                                                  )
                                                  .get();

                                          if (emailExists.docs.isNotEmpty) {
                                            setState(() {
                                              _errorMessage =
                                                  'Email already exists';
                                              _isLoading = false;
                                            });

                                            return;
                                          }

                                          setState(() {
                                            _isLoading = true;
                                          });

                                          try {
                                            await Future.delayed(
                                              Duration(seconds: 5),
                                              () {
                                                if (mounted) {
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                }
                                              },
                                            );
                                            if (context.mounted) {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return MobileVerification(
                                                      firstName:
                                                          _firstNameController
                                                              .text
                                                              .trim(),

                                                      lastName:
                                                          _lastNameController
                                                              .text
                                                              .trim(),

                                                      username:
                                                          _userNameController
                                                              .text
                                                              .trim(),

                                                      email: _emailController
                                                          .text
                                                          .trim(),

                                                      password:
                                                          _passwordController
                                                              .text
                                                              .trim(),
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          } catch (e) {
                                            setState(() {
                                              _errorMessage =
                                                  'Something went wrong';
                                            });
                                          } finally {
                                            if (mounted) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            }
                                          }
                                        }
                                      : null,

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _fields
                                        ? const Color(0xFF2C56C0)
                                        : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                    child: _isLoading
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                    Colors.white,
                                                  ),
                                            ),
                                          )
                                        : Text(
                                            'Create Account',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                  Text(
                    'Have an Account?',
                    style: TextStyle(color: Colors.grey),
                  ),

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
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Sign in Here',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
