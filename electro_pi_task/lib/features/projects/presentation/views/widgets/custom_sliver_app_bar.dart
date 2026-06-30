import 'dart:ui';

import 'package:electro_pi_task/core/common/widgets/theme_toggle_button.dart';
import 'package:electro_pi_task/core/constants/app_extension.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CustomSliverAppBar extends SliverPersistentHeaderDelegate {
  const CustomSliverAppBar({
    required this.onSearch,
    required this.onFilter,
    this.userName,
  });

  final ValueChanged<String> onSearch;
  final VoidCallback onFilter;
  final String? userName;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // final topPadding = MediaQuery.of(context).padding.top;
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final titleOpacity = (1 - progress * 1.4).clamp(0.0, 1.0);
    final searchOffset = 18 * (1 - progress);

    return Stack(
      fit: StackFit.expand,
      children: [
        const BackgroundWave(height: 480),
        Positioned(
          top: 0,
          right: 0,
          bottom: 56,
          child: SvgPicture.asset(
            'assets/images/work.svg',
            width: MediaQuery.of(context).size.width * 0.4,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: OverflowBox(
              alignment: Alignment.topCenter,
              maxHeight: maxExtent,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Opacity(
                          opacity: titleOpacity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  if (userName != null)
                                    IconButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                    ),
                                  AnimatedSize(
                                    duration: const Duration(milliseconds: 200),
                                    child: titleOpacity < .25
                                        ? const SizedBox.shrink()
                                        : Text(
                                            userName != null ? "Hi, $userName 👋" : "Hi, ${context.read<AuthCubit>().user?.name ?? 'Guest'} 👋",
                                            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold, //
                                                ),
                                          ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Let's manage your projects",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Colors.black38,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const ThemeToggleButton(color: Colors.white), //
                    ],
                  ),
                  // const SizedBox(height: 12),
                  SizedBox(height: lerpDouble(12, 4, progress)!),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: progress > .75
                        ? const SizedBox.shrink()
                        : Transform.translate(
                            offset: Offset(0, searchOffset),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    elevation: 10,
                                    borderRadius: BorderRadius.circular(18),
                                    child: TextField(
                                      onChanged: onSearch,
                                      decoration: InputDecoration(
                                        hintText: "Search projects...",
                                        prefixIcon: const Icon(Icons.search),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.surface,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(18),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Material(
                                  elevation: 10,
                                  borderRadius: BorderRadius.circular(18),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(18),
                                    onTap: onFilter,
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Icon(
                                        Icons.tune_rounded,
                                        color: context.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                ThemeToggleButton(),
                                // const Icon(Icons.tune_rounded),
                              ],
                            ),
                          ),
                  ),
                  // SizedBox(height: lerpDouble(0, 0, progress)!),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 230;

  @override
  double get minExtent => 132;

  @override
  bool shouldRebuild(covariant CustomSliverAppBar oldDelegate) {
    return false;
  }
}

class BackgroundWave extends StatelessWidget {
  final double height;

  const BackgroundWave({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ClipPath(
        clipper: BackgroundWaveClipper(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.theme.primaryColor,
                context.theme.primaryColor.withOpacity(0.7),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    const minSize = 130.0;

    // when h = max = 280
    // h = 280, p1 = 210, p1Diff = 70
    // when h = min = 140
    // h = 140, p1 = 140, p1Diff = 0
    final p1Diff = ((minSize - size.height) * 0.55).truncate().abs();
    path.lineTo(0.0, size.height - p1Diff);

    final controlPoint = Offset(size.width * 0.42, size.height);
    final endPoint = Offset(size.width, minSize);

    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) => oldClipper != this;
}
