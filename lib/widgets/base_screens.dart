import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_constants.dart';
import 'common_widgets.dart';

// Base screen widget that provides common functionality
class BaseScreen extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? trailing;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final bool showAppBar;

  const BaseScreen({
    super.key,
    required this.child,
    this.title,
    this.trailing,
    this.showBackButton = false,
    this.onBackPressed,
    this.padding,
    this.backgroundColor,
    this.showAppBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: showAppBar ? _buildAppBar(context) : null,
      body: SafeArea(
        child: Padding(
          padding: padding ?? AppSpacing.screenPadding,
          child: child,
        ),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (title == null && !showBackButton) return null;

    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textPrimary,
              ),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColors.textPrimary,
              ),
            )
          : null,
      centerTitle: true,
      actions: trailing != null ? [trailing!] : null,
    );
  }
}

// Common screen with header
class ScreenWithHeader extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const ScreenWithHeader({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: backgroundColor,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

// Common scrollable screen
class ScrollableScreen extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final ScrollController? controller;

  const ScrollableScreen({
    super.key,
    required this.child,
    this.title,
    this.trailing,
    this.padding,
    this.backgroundColor,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      backgroundColor: backgroundColor,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          if (title != null || trailing != null)
            Padding(
              padding: AppSpacing.screenPadding,
              child: Row(
                children: [
                  Expanded(
                    child: title != null
                        ? Center(
                            child: Text(
                              title!,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              padding: padding ?? AppSpacing.screenPadding,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

// Common section widget
class Section extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const Section({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title, trailing: trailing),
          AppSpacing.gapMd,
          child,
        ],
      ),
    );
  }
}

// Common list section widget
class ListSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? trailing;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool showDivider;

  const ListSection({
    super.key,
    required this.title,
    required this.children,
    this.trailing,
    this.margin,
    this.padding,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title, trailing: trailing),
          AppSpacing.gapMd,
          ...children.asMap().entries.map((entry) {
            final index = entry.key;
            final child = entry.value;
            return Column(
              children: [
                child,
                if (showDivider && index < children.length - 1)
                  AppSpacing.gapMd,
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
