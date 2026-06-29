import 'package:electro_pi_task/core/constants/app_extension.dart';
import 'package:electro_pi_task/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetPath;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.assetPath = 'assets/images/work.svg',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(AppSizes.appBarHight),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: AspectRatio(
            aspectRatio: 3.0,
            child: SvgPicture.asset(assetPath, fit: BoxFit.scaleDown),
          ),
        ),
        verticalSpace(AppSizes.xs),
        Text(
          title,
          style: context.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        verticalSpace(AppSizes.sm),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: context.bodyMedium?.copyWith(color: context.colorScheme.surfaceContainerHighest),
        ),
      ],
    );
  }
}
