import 'package:amazon_like_filter/app_style_mixin.dart';
import 'package:amazon_like_filter/filter/filter_text.dart';
import 'package:flutter/material.dart';

class FilterCheckboxTitle extends StatelessWidget with AppStyleMixin {
  const FilterCheckboxTitle({
    Key? key,
    required this.selected,
    required this.title,
    required this.onUpdate,
  }) : super(key: key);

  final bool selected;
  final String title;
  final ValueChanged<bool?> onUpdate;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: selected,
      onChanged: (value) {
        onUpdate(value);
      },
      title: FilterText(
        title: title,
        style: getTitleTheme1(context)?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
