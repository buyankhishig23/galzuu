import 'package:flutter/material.dart';

class FeedCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FeedCard({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.asset(
            imageUrl, // ✅ FIXED: use Image.asset for local images
            fit: BoxFit.cover,
            width: double.infinity,
            height: 180,
          ),
          Container(
            width: double.infinity,
            color: Colors.black54,
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
