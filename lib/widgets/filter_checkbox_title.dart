import 'package:amazon_like_filter/filter_style_mixin.dart';
import 'package:flutter/material.dart';

import 'filter_text.dart';

class FilterCheckboxTitle extends StatelessWidget with FilterStyleMixin {
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
