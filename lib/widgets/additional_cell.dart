import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdditionalCell extends StatelessWidget {
  const AdditionalCell({
    Key? key,
    this.child,
    this.onTap,
    this.color = const Color(0xFF366AFD),
    this.enabled = true, this.borderColor,
  }) : super(key: key);
  final Widget? child;
  final VoidCallback? onTap;
  final Color color;
  final Color? borderColor;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Opacity(
        opacity: enabled ? 1 : 0.3,
        child: Container(
          width: 80.w,
          height: 40.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: borderColor ?? color,
            ),
          ),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
