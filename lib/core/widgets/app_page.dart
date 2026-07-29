import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/core/responsive/responsive_builder.dart';
import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.maxContentWidth = AppSizes.contentMaxWidth,
    super.key,
  });

  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(title: Text(title!), actions: actions),
      body: SafeArea(
        child: ResponsiveConstrainedBox(maxWidth: maxContentWidth, child: body),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
