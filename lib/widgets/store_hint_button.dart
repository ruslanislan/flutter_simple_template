import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_template/utils/utils.dart';

import 'additional_cell.dart';

class StoreHintButton extends StatelessWidget {
  const StoreHintButton({
    Key? key,
    required this.text,
    required this.price,
    this.child,
    required this.selected,
    this.onTap,
    this.enabled = true,
    required this.count,
  }) : super(key: key);
  final String text;
  final int price;
  final Widget? child;
  final bool selected;
  final VoidCallback? onTap;
  final bool enabled;
  final int count;

  Border get border {
    if (selected) {
      return Border.all(
        color: const Color(0xFF366AFD),
        width: 2,
      );
    }
    return Border.all(
      color: const Color(0xFF366AFD).withOpacity(0.3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: 343.w,
          height: 130.h,
          decoration: BoxDecoration(
            color: const Color(0xFF13161F).withOpacity(0.8),
            borderRadius: BorderRadius.circular(100),
            border: border,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAdditionalCell(),
              SizedBox(height: 12.h),
              Text(
                text,
                style: AppThemes.helper3.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$price ',
                    style: AppThemes.helper3.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Coins',
                    style: AppThemes.helper3.copyWith(
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF366AFD),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalCell() {
    if (count <= 0) {
      return AdditionalCell(
        borderColor: const Color(0xFF13161F).withOpacity(0.8),
        child: child,
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AdditionalCell(
          borderColor: const Color(0xFF13161F).withOpacity(0.8),
          child: child,
        ),
        SizedBox(width: 8.h),
        Text(
          '— $count',
          style: AppThemes.helper5.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF366AFD),
          ),
        )
      ],
    );
  }
}
