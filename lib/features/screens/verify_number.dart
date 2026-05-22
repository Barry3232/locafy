import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locafy/features/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerifyNumber extends StatefulWidget {
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String verificationId;

  const VerifyNumber({
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    required this.verificationId,
    super.key,
  });

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;
  bool _isSuccess = false;

  final focusNode1 = FocusNode();
  final focusNode2 = FocusNode();
  final focusNode3 = FocusNode();
  final focusNode4 = FocusNode();
  final focusNode5 = FocusNode();
  final focusNode6 = FocusNode();
  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();
  final otp5Controller = TextEditingController();
  final otp6Controller = TextEditingController();

  void _clearOtpFields() {
    otp1Controller.clear();
    otp2Controller.clear();
    otp3Controller.clear();
    otp4Controller.clear();
    otp5Controller.clear();
    otp6Controller.clear();
    FocusScope.of(context).requestFocus(focusNode1);
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    focusNode6.dispose();
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
    otp5Controller.dispose();
    otp6Controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Verify Account',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: const Text(
                              'Please enter 6-digit code. So we will verify your account.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),

                          const SizedBox(height: 25),

                          Form(
                            key: _formKey,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: otp1Controller,

                                    focusNode: focusNode1,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNode2);
                                      } else if (value.isEmpty) {
                                        focusNode1.unfocus();
                                      }
                                    },
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 18,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xFF2C56C0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 20),

                                Expanded(
                                  child: TextFormField(
                                    controller: otp2Controller,
                                    focusNode: focusNode2,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNode3);
                                      } else if (value.isEmpty) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNode1);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 18,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xFF2C56C0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 20),

                                Expanded(
                                  child: TextFormField(
                                    controller: otp3Controller,

                                    focusNode: focusNode3,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNode4);
                                      } else if (value.isEmpty) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNode2);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 18,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xFF2C56C0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 20),

                                Expanded(
                                  child: TextFormField(
                                    controller: otp4Controller,

                                    focusNode: focusNode4,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNode5);
                                      } else if (value.isEmpty) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNode3);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 18,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xFF2C56C0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 20),

                                Expanded(
                                  child: TextFormField(
                                    controller: otp5Controller,

                                    focusNode: focusNode5,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1),
                                    ],

                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNode6);
                                      } else if (value.isEmpty) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNode4);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 18,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xFF2C56C0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 20),

                                Expanded(
                                  child: TextFormField(
                                    controller: otp6Controller,

                                    focusNode: focusNode6,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        focusNode6.unfocus();
                                      } else if (value.isEmpty) {
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(focusNode5);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            vertical: 18,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Color(0xFF2C56C0),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                border: Border.all(color: Colors.red.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),

                          const SizedBox(height: 10),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: (!_isLoading)
                                  ? () async {
                                      final otpCode =
                                          otp1Controller.text +
                                          otp2Controller.text +
                                          otp3Controller.text +
                                          otp4Controller.text +
                                          otp5Controller.text +
                                          otp6Controller.text;

                                      if (otpCode.length != 6) {
                                        setState(() {
                                          _errorMessage =
                                              'Enter complete OTP code';
                                        });
                                        return;
                                      }

                                      setState(() {
                                        _isLoading = true;
                                        _errorMessage = null;
                                      });

                                      try {
                                        final credential =
                                            PhoneAuthProvider.credential(
                                              verificationId:
                                                  widget.verificationId,
                                              smsCode: otpCode,
                                            );
                                        await FirebaseAuth.instance
                                            .signInWithCredential(credential);

                                        final emailCredential =
                                            EmailAuthProvider.credential(
                                              email: widget.email,
                                              password: widget.password,
                                            );
                                        await FirebaseAuth.instance.currentUser!
                                            .linkWithCredential(
                                              emailCredential,
                                            );

                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(
                                              FirebaseAuth
                                                  .instance
                                                  .currentUser!
                                                  .uid,
                                            )
                                            .set({
                                              'firstName': widget.firstName,
                                              'lastName': widget.lastName,
                                              'username': widget.username,
                                              'email': widget.email,
                                              'phoneNumber': widget.phoneNumber,
                                              'createdAt': Timestamp.now(),
                                            });

                                        if (!mounted) return;

                                        setState(() {
                                          _isSuccess = true;
                                        });

                                        await Future.delayed(
                                          const Duration(seconds: 5),
                                        );

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const LoginScreen(),
                                          ),
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        setState(() {
                                          _errorMessage =
                                              e.message ??
                                              'Verification failed';
                                        });
                                        _clearOtpFields();
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
                                backgroundColor: _isLoading
                                    ? Colors.grey
                                    : const Color(0xFF2C56C0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: _isLoading
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Verify Code',
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
                                  // Navigate to register
                                },
                                child: const Text("Resend Code"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_isSuccess)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black54,
                      child: Center(
                        child: Container(
                          width: 260,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 70,
                              ),

                              SizedBox(height: 15),

                              Text(
                                'Account Created Successfully',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }
}
