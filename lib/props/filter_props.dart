import 'package:amazon_like_filter/props/applied_filter_model.dart';
import 'package:amazon_like_filter/props/filter_list_model.dart';
import 'package:flutter/material.dart';

class FilterProps {
  final List<FilterListModel> filters;
  final String? title;
  final ThemeProps? themeProps;

  final Function(List<AppliedFilterModel> appliedFilterModel)? onFilterChange;

  FilterProps({
    required this.filters,
    this.onFilterChange,
    this.title,
    this.themeProps,
  });
}

class ThemeProps {
  final TextStyle? titleStyle;
  final Color? titleColor;
  final Color? activeFilterHeaderColor;
  final Color? inActiveFilterHeaderColor;
  final TextStyle? activeFilterHeaderStyle;
  final TextStyle? activeFilterTextStyle;
  final Color? activeFilterTextColor;
  final Color? inActiveFilterTextColor;
  final TextStyle? inActiveFilterTextStyle;
  final Color? resetButtonColor;
  final TextStyle? resetButtonStyle;
  final Color? submitButtonColor;
  final TextStyle? submitButtonStyle;
  final Widget? divider;
  final Color? dividerColor;
  final double? dividerThickness;
  final CheckBoxTileThemeProps? checkBoxTileThemeProps;

  ThemeProps({
    this.titleStyle,
    this.titleColor,
    this.resetButtonColor,
    this.submitButtonColor,
    this.divider,
    this.dividerColor,
    this.inActiveFilterHeaderColor,
    this.activeFilterHeaderColor,
    this.activeFilterTextStyle,
    this.activeFilterTextColor,
    this.inActiveFilterTextColor,
    this.inActiveFilterTextStyle,
    this.activeFilterHeaderStyle,
    this.checkBoxTileThemeProps,
    this.dividerThickness,
    this.resetButtonStyle,
    this.submitButtonStyle,
  });
}

class CheckBoxTileThemeProps {
  final Color? activeCheckBoxColor;
  final Color? inActiveCheckBoxColor;
  final Color? checkboxTitleColor;
  final TextStyle? checkboxTitleStyle;
  final Color? tileColor;

  CheckBoxTileThemeProps({
    this.activeCheckBoxColor,
    this.inActiveCheckBoxColor,
    this.checkboxTitleColor,
    this.checkboxTitleStyle,
    this.tileColor,
  });
}
