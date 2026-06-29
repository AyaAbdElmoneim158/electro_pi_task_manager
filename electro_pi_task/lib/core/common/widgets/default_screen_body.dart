// lib/core/widgets/default_screen_body.dart
import 'package:flutter/material.dart';

class DefaultScreenBody extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  const DefaultScreenBody({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: padding,
          child: SingleChildScrollView(
            child: Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}