import 'package:flutter/material.dart';

import 'add_product.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF333333),

        title: const Text(
          'My Products',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 5, 22, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------------------
              // PAGE INTRO
              // ------------------------------------------------

              const Text(
                'Your Craft Catalogue',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F704F),
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Manage the crafts you have listed on KalaKriti.',
                style: TextStyle(fontSize: 15, color: Color(0xFF666666)),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // CATALOGUE SUMMARY
              // ------------------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: const Color(0xFFE8E0CF),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: const Icon(
                        Icons.inventory_2_outlined,
                        color: Color(0xFF3F704F),
                        size: 27,
                      ),
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Products listed',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF666666),
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            '—',
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
              // PRODUCTS TITLE
              // ------------------------------------------------
              const Text(
                'Your Products',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),

              const SizedBox(height: 14),

              // ------------------------------------------------
              // PRODUCT CARD
              // ------------------------------------------------
              _buildProductCard(context),

              const SizedBox(height: 14),

              // ------------------------------------------------
              // ADD ANOTHER CRAFT
              // ------------------------------------------------
              _buildAddProductCard(context),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // BACK TO DASHBOARD
              // ------------------------------------------------
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
                    'Back to Dashboard',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
  // PRODUCT CARD
  // ------------------------------------------------------------

  Widget _buildProductCard(BuildContext context) {
    return Container(
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // Product image placeholder
          Container(
            height: 180,
            width: double.infinity,

            decoration: const BoxDecoration(
              color: Color(0xFFE8E0CF),

              borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            ),

            child: const Center(
              child: Icon(
                Icons.image_outlined,
                size: 55,
                color: Color(0xFF3F704F),
              ),
            ),
          ),

          // Product information
          Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Your Product',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E0CF),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Text(
                        'Draft',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3F704F),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                const Text(
                  'Product description will appear here.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF777777),
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    const Text(
                      '₹ ---',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F704F),
                      ),
                    ),

                    const Spacer(),

                    // Edit
                    IconButton(
                      onPressed: () {
                        _showComingSoon(context, 'Edit product');
                      },

                      icon: const Icon(Icons.edit_outlined),

                      color: const Color(0xFF3F704F),

                      tooltip: 'Edit',
                    ),

                    // Delete
                    IconButton(
                      onPressed: () {
                        _showDeleteDialog(context);
                      },

                      icon: const Icon(Icons.delete_outline),

                      color: const Color(0xFF9B3D3D),

                      tooltip: 'Delete',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // ADD PRODUCT CARD
  // ------------------------------------------------------------

  Widget _buildAddProductCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddProductScreen()),
        );
      },

      borderRadius: BorderRadius.circular(18),

      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),

          border: Border.all(color: const Color(0xFFD8D2C5)),
        ),

        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,

              decoration: BoxDecoration(
                color: const Color(0xFFE8E0CF),
                borderRadius: BorderRadius.circular(14),
              ),

              child: const Icon(Icons.add, color: Color(0xFF3F704F)),
            ),

            const SizedBox(width: 14),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add another craft',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    'Create another product listing.',
                    style: TextStyle(fontSize: 13, color: Color(0xFF777777)),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Color(0xFF888888),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // EDIT MESSAGE
  // ------------------------------------------------------------

  void _showComingSoon(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$message will be connected later.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ------------------------------------------------------------
  // DELETE DIALOG
  // ------------------------------------------------------------

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF8F5EC),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: const Text(
            'Delete Product?',
            style: TextStyle(
              color: Color(0xFF3F704F),
              fontWeight: FontWeight.bold,
            ),
          ),

          content: const Text(
            'Are you sure you want to delete '
            'this product?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF666666)),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Product deletion will be '
                      'connected to the backend.',
                    ),
                  ),
                );
              },

              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Color(0xFF9B3D3D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
