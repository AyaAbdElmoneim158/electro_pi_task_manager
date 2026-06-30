import 'package:electro_pi_task/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyProjectsState extends StatelessWidget {
  const EmptyProjectsState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: AspectRatio(
              aspectRatio: 3.2,
              child: SvgPicture.string(
                AppAssets.themedFolderOutlinedIllustration,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "No Projects Found",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            "Pull to refresh or create a new project.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
