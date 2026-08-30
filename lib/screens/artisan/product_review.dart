import 'package:flutter/material.dart';

import 'my_products.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF333333),

        title: const Text(
          'Review Listing',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 5, 22, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your listing is ready',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F704F),
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Review the details before publishing your craft.',
                style: TextStyle(fontSize: 15, color: Color(0xFF666666)),
              ),

              const SizedBox(height: 24),

              // ------------------------------------------------
              // PRODUCT IMAGE
              // ------------------------------------------------
              Container(
                width: double.infinity,
                height: 230,

                decoration: BoxDecoration(
                  color: const Color(0xFFE8E0CF),
                  borderRadius: BorderRadius.circular(22),
                ),

                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 55,
                      color: Color(0xFF3F704F),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Your Craft Image',
                      style: TextStyle(fontSize: 15, color: Color(0xFF666666)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // PRODUCT NAME
              // ------------------------------------------------
              const Text(
                'Product Details',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),

              const SizedBox(height: 14),

              _detailCard(
                title: 'Product Name',
                value: 'Your Craft',
                icon: Icons.sell_outlined,
              ),

              const SizedBox(height: 12),

              _detailCard(
                title: 'Craft Type',
                value: 'Craft type will appear here',
                icon: Icons.palette_outlined,
              ),

              const SizedBox(height: 12),

              _detailCard(
                title: 'Material',
                value: 'Material information',
                icon: Icons.category_outlined,
              ),

              const SizedBox(height: 12),

              _detailCard(
                title: 'Description',
                value: 'Your product description will appear here.',
                icon: Icons.description_outlined,
                multiline: true,
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // PRICE
              // ------------------------------------------------
              const Text(
                'Suggested Price',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),

              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,

                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E0CF),
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: const Icon(
                        Icons.currency_rupee,
                        color: Color(0xFF3F704F),
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Recommended price',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF777777),
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            '₹ ---',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(Icons.auto_awesome, color: Color(0xFF3F704F)),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // MARKET OPPORTUNITY
              // ------------------------------------------------
              const Text(
                'Market Opportunities',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),

              const SizedBox(height: 14),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xFFE8E0CF),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Icon(
                      Icons.insights_outlined,
                      color: Color(0xFF3F704F),
                      size: 28,
                    ),

                    SizedBox(width: 14),

                    Expanded(
                      child: Text(
                        'Potential markets and recommendations '
                        'will appear here.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Color(0xFF555555),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ------------------------------------------------
              // PUBLISH BUTTON
              // ------------------------------------------------
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: () {
                    _showPublishedMessage(context);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F704F),

                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: const Text(
                    'Publish Listing',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF3F704F),

                    side: const BorderSide(color: Color(0xFF3F704F)),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: const Text(
                    'Edit Listing',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailCard({
    required String title,
    required String value,
    required IconData icon,
    bool multiline = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            width: 44,
            height: 44,

            decoration: BoxDecoration(
              color: const Color(0xFFE8E0CF),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(icon, color: const Color(0xFF3F704F), size: 22),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF888888),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  maxLines: multiline ? 4 : 2,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPublishedMessage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MyProductsScreen()),
    );
  }
}
