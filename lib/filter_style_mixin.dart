import 'package:flutter/material.dart';

mixin FilterStyleMixin<T extends StatelessWidget> {
  ThemeData getTheme(BuildContext context) => Theme.of(context);

  TextStyle? getTitleTheme(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          );

  TextStyle? getTitle2Theme(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          );

  Color getDividerColor(BuildContext context) => Theme.of(context).dividerColor;

  TextStyle? getTitleTheme1(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          );
}
