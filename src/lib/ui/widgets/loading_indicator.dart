import 'package:flutter/material.dart';
import 'package:gyde_app/ui/common/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;

  const LoadingIndicator({
    Key? key,
    this.size = 36.0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? kcPrimaryColor,
        ),
        strokeWidth: 3,
      ),
    );
  }
}
