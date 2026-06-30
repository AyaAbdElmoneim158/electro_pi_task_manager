import 'package:electro_pi_task/core/constants/app_assets.dart';
import 'package:electro_pi_task/core/constants/app_extension.dart';
import 'package:electro_pi_task/core/service_locator.dart';
import 'package:electro_pi_task/features/auth/presentation/controllers/auth_cubit.dart';
import 'package:electro_pi_task/features/auth/presentation/views/screens/profile_screen.dart';
import 'package:electro_pi_task/features/projects/presentation/controllers/projects_cubit.dart';
import 'package:electro_pi_task/features/projects/presentation/views/screens/projects_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() => currentSelectedIndex = index);
    // print(sl.isRegistered<HomeCubit>());
    // print(sl.isRegistered<HomeRepository>());
    // print(sl.isRegistered<HomeDataSource>());
    // print(sl.isRegistered<HomeLocalDataSource>());
  }

  final pages = [
    // ProjectsScreen(),
    // HomeScreen(),
    // BlocProvider(
    //   create: (_) => sl<ProjectsCubit>()..getProjects(),
    //   child: const ProjectsScreen(),
    // ),
    // Scaffold(body: Center(child: Text("Projects"))),
    // BlocProvider(
    //   create: (_) => sl<AuthCubit>()..checkAuthStatus(),
    //   child: ProfileScreen(),
    // ),
    //? ----------------------
    ProjectsScreen(), ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentSelectedIndex, children: pages),
      //  pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              AppAssets.projectsIcon,
              colorFilter: ColorFilter.mode(context.colorScheme.secondary, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.string(
              AppAssets.projectsIcon,
              colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              AppAssets.userIcon,
              colorFilter: ColorFilter.mode(context.colorScheme.secondary, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.string(
              AppAssets.userIcon,
              colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
