import 'package:electro_pi_task/core/common/widgets/theme_toggle_button.dart';
import 'package:electro_pi_task/features/projects/presentation/views/widgets/background_wave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  const SliverSearchAppBar({this.onSearch, this.onFilter});
  final ValueChanged<String>? onSearch;
  final VoidCallback? onFilter;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset = shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.5;
    double topPadding = MediaQuery.of(context).padding.top + 16;
    final opacity = (1 - shrinkOffset / minExtent).clamp(0.0, 1.0);

    return Stack(
      children: [
        const BackgroundWave(height: 280),

        /// Greeting
        Positioned(
          top: topPadding,
          left: 20,
          right: 20,
          child: Opacity(
            opacity: opacity,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Text(
                          //   "My Projects",
                          //   style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          // ),
                          // const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                height: 64,
                                width: 64,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset('assets/images/work.svg', fit: BoxFit.contain),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8,
                                children: [
                                  Text(
                                    "My Projects",
                                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    "Hi, Aya 👋",
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: Colors.white70,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const ThemeToggleButton(color: Colors.white),
              ],
            ),
          ),
        ),
        // Positioned(
        //   top: topPadding + offset,
        //   left: 16,
        //   right: 16,
        //   child: const SearchBar(),
        // )
        /// Search + Filter
        Positioned(
          top: topPadding + 72 + offset,
          left: 20,
          right: 20,
          child: Row(
            children: [
              Expanded(
                child: Material(
                  elevation: 8,
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
                elevation: 8,
                borderRadius: BorderRadius.circular(18),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: onFilter,
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.tune_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 140;

  @override
  // bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
  @override
  bool shouldRebuild(covariant SliverSearchAppBar oldDelegate) {
    return true;
  }
}
