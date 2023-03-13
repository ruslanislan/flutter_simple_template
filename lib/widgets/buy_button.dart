import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_template/utils/utils.dart';

class BuyButton extends StatelessWidget {
  const BuyButton({
    Key? key,
    this.onTap,
    required this.count,
    this.enabled = true,
  }) : super(key: key);
  final VoidCallback? onTap;
  final int count;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 200.w,
          height: 64.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xFF366AFD),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Buy — ',
                  style: AppThemes.helper5,
                ),
                Text(
                  '$count',
                  style: AppThemes.helper5.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
