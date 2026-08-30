import 'package:flutter/material.dart';

import 'ai_processing.dart';

class ProductPhotoScreen extends StatelessWidget {
  const ProductPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF333333),

        title: const Text(
          'Add Your Craft',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 5, 22, 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------------------
              // HEADING
              // ------------------------------------------------

              const Text(
                'Show us your craft',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F704F),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Upload a clear photo of your handmade product.',
                style: TextStyle(fontSize: 15, color: Color(0xFF666666)),
              ),

              const SizedBox(height: 22),

              // ------------------------------------------------
              // AI INFO
              // ------------------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: const Color(0xFFE8E0CF),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFF3F704F),
                      size: 23,
                    ),

                    const SizedBox(width: 11),

                    const Expanded(
                      child: Text(
                        'KalaKriti will use your photo to help '
                        'create your product listing.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.35,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // PHOTO AREA
              // ------------------------------------------------
              Expanded(
                child: Container(
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),

                    border: Border.all(
                      color: const Color(0xFFD8D2C5),
                      width: 1.5,
                    ),
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        width: 90,
                        height: 90,

                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E0CF),
                          borderRadius: BorderRadius.circular(24),
                        ),

                        child: const Icon(
                          Icons.add_a_photo_outlined,
                          size: 44,
                          color: Color(0xFF3F704F),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'No photo added yet',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 35),

                        child: Text(
                          'Add a clear image of your craft. '
                          'A good photo helps KalaKriti '
                          'understand your product.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.45,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Choose photo
                      SizedBox(
                        height: 46,

                        child: OutlinedButton.icon(
                          onPressed: () {
                            _showComingSoon(context, 'Photo gallery');
                          },

                          icon: const Icon(
                            Icons.photo_library_outlined,
                            size: 19,
                          ),

                          label: const Text(
                            'Choose Photo',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF3F704F),

                            side: const BorderSide(color: Color(0xFF3F704F)),

                            padding: const EdgeInsets.symmetric(horizontal: 18),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Camera
                      SizedBox(
                        height: 46,

                        child: OutlinedButton.icon(
                          onPressed: () {
                            _showComingSoon(context, 'Camera');
                          },

                          icon: const Icon(Icons.camera_alt_outlined, size: 19),

                          label: const Text(
                            'Take Photo',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF3F704F),

                            side: const BorderSide(color: Color(0xFF3F704F)),

                            padding: const EdgeInsets.symmetric(horizontal: 18),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ------------------------------------------------
              // CONTINUE
              // ------------------------------------------------
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AIProcessingScreen(),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F704F),

                    foregroundColor: Colors.white,

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: 8),

                      Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // TEMPORARY PROTOTYPE MESSAGE
  // ------------------------------------------------------------

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature integration will be connected later.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
