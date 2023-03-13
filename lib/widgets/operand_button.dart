import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OperandButton extends StatelessWidget {
  const OperandButton({
    Key? key,
    required this.color,
    required this.child,
    this.onTap,
    this.enabled = true,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: 64.w,
          height: 64.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: color,
            ),
            color: color,
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
