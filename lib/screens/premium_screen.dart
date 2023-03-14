import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_template/screens/store/store.dart';
import 'package:flutter_simple_template/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeModel = context.read<StoreModel>();
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/png/bg2.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.h, right: 16.w),
                          child: Image.asset(
                            'assets/png/icons/close.png',
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        storeModel.buyPremium();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 343.w,
                        height: 64.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xFF366AFD),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 0),
                              blurRadius: 25,
                              color: const Color(0xFF2760E2).withOpacity(0.5),
                            ),
                            const BoxShadow(
                              offset: Offset(0, 4),
                              color: Color(0xFF193481),
                            )
                          ],
                          border: GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFFFFFF).withOpacity(0.25),
                                const Color(0xFFFFFFFF).withOpacity(0.10),
                                const Color(0xFFFFFFFF).withOpacity(0),
                                const Color(0xFFFFFFFF).withOpacity(0.10),
                                const Color(0xFFFFFFFF).withOpacity(0.25),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Buy premium for \$0.99',
                            style: AppThemes.helper5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: 343.w,
                      height: 40.h,
                      child: Row(
                        children: const [
                          Expanded(
                            child: TextButton(
                              text: 'Terms of Use',
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              text: 'Restore',
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              text: 'Privacy Policy',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextButton extends StatelessWidget {
  const TextButton({
    Key? key,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Text(
            text,
            style: AppThemes.helper2.copyWith(
              fontWeight: FontWeight.w300,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
