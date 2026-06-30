import 'package:electro_pi_task/core/constants/app_extension.dart';
import 'package:flutter/material.dart';

class ProjectCardShimmer extends StatelessWidget {
  const ProjectCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final shimmerColor = Colors.grey.shade300;

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(24),
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Status
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(
                          height: 22,
                          width: 180,
                          color: shimmerColor,
                        ),
                        const SizedBox(height: 14),
                        _ShimmerBox(
                          height: 14,
                          width: double.infinity,
                          color: shimmerColor,
                        ),
                        const SizedBox(height: 8),
                        _ShimmerBox(
                          height: 14,
                          width: 220,
                          color: shimmerColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  _ShimmerBox(
                    height: 34,
                    width: 90,
                    radius: 30,
                    color: shimmerColor,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Bottom Row
              Row(
                children: [
                  _ShimmerBox(
                    height: 20,
                    width: 20,
                    radius: 20,
                    color: shimmerColor,
                  ),
                  const SizedBox(width: 8),
                  _ShimmerBox(
                    height: 16,
                    width: 110,
                    color: shimmerColor,
                  ),
                  const Spacer(),
                  _ShimmerBox(
                    height: 34,
                    width: 34,
                    radius: 17,
                    color: shimmerColor,
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

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.height,
    required this.color,
    this.width,
    this.radius = 6,
  });

  final double height;
  final double? width;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        width: width,
        color: color,
      ).withShimmer(),
    );
  }
}