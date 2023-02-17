import 'package:flutter/material.dart';

class FilterTextButton extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final Function()? onTap;
  final bool isSecondary;
  final Color? txtColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const FilterTextButton({
    Key? key,
    this.text,
    this.style,
    this.onTap,
    this.isSecondary = false,
    this.txtColor,
    this.fontWeight,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        text ?? '',
        style: style ??
            (isSecondary
                ? Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: txtColor ?? Theme.of(context).primaryColor,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    )
                : Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: txtColor ?? Theme.of(context).primaryColor,
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                    )),
      ),
    );
  }
}
