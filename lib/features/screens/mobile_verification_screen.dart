import 'package:flutter/material.dart';
import 'package:locafy/features/screens/verify_number.dart';
import 'package:locafy/features/services/phone_auth_service.dart';
import 'dart:async';

class MobileVerification extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  const MobileVerification({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    super.key,
  });

  @override
  State<MobileVerification> createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  final TextEditingController _phoneNumberController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  Timer? _timer;

  void _startTimer() {
    _timer?.cancel();
    if (_errorMessage != null) {
      _timer = Timer(Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _errorMessage = null;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
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
                            'Mobile Number',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child: const Text(
                              'Please enter your phone number. We will send you a 6-digit code to verify your account.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13),
                            ),
                          ),

                          const SizedBox(height: 25),

                          TextField(
                            controller: _phoneNumberController,

                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',

                              counterText: '',
                              hintText: '00000000000',
                              prefixIcon: IntrinsicWidth(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '+234',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 24,
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                ),
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
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
                                border: Border.all(color: Colors.red.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _errorMessage!,
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),

                          SizedBox(height: 10),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _errorMessage = null;
                                  _isLoading = true;
                                });

                                if (_phoneNumberController.text.isEmpty ||
                                    _phoneNumberController.text.length != 10) {
                                  setState(() {
                                    _errorMessage =
                                        'Please enter a valid phone number';
                                    _isLoading = false;
                                  });
                                  _startTimer();
                                  return;
                                }

                                try {
                                  final phoneAuthService = PhoneAuthService();
                                  await phoneAuthService.sendOtp(
                                    phoneNumber:
                                        '+234${_phoneNumberController.text.trim()}',
                                    onCodeSent: (verificationId) {
                                      if (!mounted) return;

                                      setState(() {
                                        _isLoading = false;
                                      });

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return VerifyNumber(
                                              verificationId: verificationId,
                                              phoneNumber:
                                                  _phoneNumberController.text
                                                      .trim(),

                                              firstName: widget.firstName,
                                              lastName: widget.lastName,
                                              username: widget.username,
                                              email: widget.email,
                                              password: widget.password,
                                            );
                                          },
                                        ),
                                      );
                                    },

                                    onVerificationError: (onVerificationError) {
                                      if (!mounted) return;

                                      setState(() {
                                        _errorMessage = onVerificationError;
                                        _isLoading = false;
                                      });

                                      _startTimer();
                                    },
                                  );
                                } catch (e) {
                                  if (!mounted) return;
                                  setState(() {
                                    _errorMessage =
                                        'Unable to send code. Check your internet connection.';
                                    _isLoading = false;
                                  });
                                  _startTimer();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _isLoading
                                    ? Colors.grey
                                    : Color(0xFF2C56C0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: _isLoading
                                  ? Center(
                                      child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      'Send Code',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
