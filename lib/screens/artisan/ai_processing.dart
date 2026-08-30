import 'dart:async';

import 'product_review.dart';

import 'package:flutter/material.dart';

class AIProcessingScreen extends StatefulWidget {
  const AIProcessingScreen({super.key});

  @override
  State<AIProcessingScreen> createState() => _AIProcessingScreenState();
}

class _AIProcessingScreenState extends State<AIProcessingScreen> {
  int currentStep = 0;

  final List<String> steps = [
    'Understanding your craft',
    'Identifying materials and craft',
    'Creating product details',
    'Improving your product image',
    'Suggesting a suitable price',
    'Finding suitable markets',
  ];

  final List<IconData> icons = [
    Icons.visibility_outlined,
    Icons.palette_outlined,
    Icons.description_outlined,
    Icons.auto_fix_high_outlined,
    Icons.currency_rupee,
    Icons.storefront_outlined,
  ];

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentStep < steps.length - 1) {
        setState(() {
          currentStep++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = (currentStep + 1) / steps.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),

          child: Column(
            children: [
              const SizedBox(height: 10),

              // AI ICON
              Container(
                width: 82,
                height: 82,

                decoration: BoxDecoration(
                  color: const Color(0xFFE8E0CF),
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.auto_awesome,
                  size: 42,
                  color: Color(0xFF3F704F),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'Creating your listing',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F704F),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'KalaKriti is working its magic on your craft.',
                textAlign: TextAlign.center,

                style: TextStyle(fontSize: 15, color: Color(0xFF666666)),
              ),

              const SizedBox(height: 30),

              // PROGRESS BAR
              ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,

                  backgroundColor: const Color(0xFFE1DDD3),

                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF3F704F),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,

                child: Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3F704F),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // STEPS
              Expanded(
                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(18),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: ListView.builder(
                    itemCount: steps.length,

                    itemBuilder: (context, index) {
                      final completed = index < currentStep;

                      final active = index == currentStep;

                      return _buildStep(
                        title: steps[index],
                        icon: icons[index],
                        completed: completed,
                        active: active,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // CURRENT STATUS
              Text(
                currentStep == steps.length - 1
                    ? 'Almost there...'
                    : steps[currentStep],

                textAlign: TextAlign.center,

                style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
              ),

              const SizedBox(height: 18),

              // CONTINUE BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,

                child: ElevatedButton(
                  onPressed: currentStep == steps.length - 1
                      ? () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductReviewScreen(),
                            ),
                          );
                        }
                      : null,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F704F),

                    disabledBackgroundColor: const Color(0xFFB7C4BA),

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: Text(
                    currentStep == steps.length - 1
                        ? 'View My Listing'
                        : 'Processing...',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep({
    required String title,
    required IconData icon,
    required bool completed,
    required bool active,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Row(
        children: [
          // STEP ICON
          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              color: completed || active
                  ? const Color(0xFFE8E0CF)
                  : const Color(0xFFF2F0EA),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(
              completed ? Icons.check : icon,

              color: completed || active
                  ? const Color(0xFF3F704F)
                  : const Color(0xFFAAAAAA),

              size: 23,
            ),
          ),

          const SizedBox(width: 14),

          // TEXT
          Expanded(
            child: Text(
              title,

              style: TextStyle(
                fontSize: 15,

                fontWeight: active || completed
                    ? FontWeight.w600
                    : FontWeight.normal,

                color: active || completed
                    ? const Color(0xFF333333)
                    : const Color(0xFF999999),
              ),
            ),
          ),

          // STATUS
          if (completed)
            const Icon(Icons.check_circle, color: Color(0xFF3F704F), size: 22)
          else if (active)
            const SizedBox(
              width: 20,
              height: 20,

              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3F704F)),
              ),
            ),
        ],
      ),
    );
  }
}
