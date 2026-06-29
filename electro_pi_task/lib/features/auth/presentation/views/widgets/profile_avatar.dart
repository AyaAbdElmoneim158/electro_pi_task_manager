import 'package:electro_pi_task/core/constants/app_assets.dart';
import 'package:electro_pi_task/core/constants/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 88),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 65,
                backgroundColor: context.theme.scaffoldBackgroundColor,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor:
                  context.theme.hoverColor,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: AspectRatio(
                      aspectRatio: 3.0,
                      child: SvgPicture.asset(
                        AppAssets.work,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
