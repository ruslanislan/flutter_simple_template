import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_template/utils/utils.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key, required this.coins, required this.level})
      : super(key: key);
  final int coins;
  final int level;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: Row(
        children: [
          Expanded(child: Row()),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$coins ',
                  style: AppThemes.helper1.copyWith(
                    color: const Color(0xFF366AFD),
                  ),
                ),
                Text(
                  'COINS',
                  style: AppThemes.helper1,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$level/50',
                    style: AppThemes.helper2,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
