import 'package:flutter/material.dart';

import 'role_selection_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }

    for (final node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void moveToNext(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF333333)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),

          child: Column(
            children: [
              const SizedBox(height: 45),

              Image.asset(
                'assets/images/kklogo-removebg-preview.png',
                width: 150,
              ),

              const SizedBox(height: 35),

              const Text(
                'Verify Your Number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F704F),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Enter the 6-digit OTP sent to your mobile number.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 45,
                    height: 55,

                    child: TextField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],

                      textAlign: TextAlign.center,

                      keyboardType: TextInputType.number,

                      maxLength: 1,

                      onChanged: (value) {
                        moveToNext(index, value);
                      },

                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Colors.white,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 25),

              TextButton(
                onPressed: () {},
                child: const Text(
                  'Resend OTP',
                  style: TextStyle(
                    color: Color(0xFF3F704F),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RoleSelectionScreen(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F704F),
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: const Text(
                    'Verify & Continue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
