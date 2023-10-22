import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTile extends StatelessWidget {
  final bool? isPopular;

  const ShimmerTile({super.key, this.isPopular = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isPopular! ? EdgeInsets.zero : const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(width: 1, color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8)),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: const SizedBox(
          width: 200,
          height: 300,
        ),
      ),
    );
  }
}
