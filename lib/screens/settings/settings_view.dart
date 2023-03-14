import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_template/screens/premium_screen.dart';
import 'package:flutter_simple_template/screens/screens.dart';
import 'package:flutter_simple_template/utils/app_themes.dart';
import 'package:flutter_simple_template/widgets/custom_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeModel = context.watch<StoreModel>();
    return Column(
      children: [
        CustomAppBar(
          coins: storeModel.coins,
          level: storeModel.level + 1,
        ),
        SizedBox(height: 20.h),
        _buildButton(storeModel, context),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BorderButton(text: 'Terms of Use'),
            SizedBox(width: 20.w),
            const BorderButton(text: 'Privacy Policy'),
          ],
        ),
        SizedBox(height: 16.h),
        BorderButton(
          text: 'Support',
          width: 343.w,
        ),
      ],
    );
  }

  Widget _buildButton(StoreModel storeModel, BuildContext context) {
    if (storeModel.premium) {
      return DailyCoins(
        enabled: storeModel.canTake,
        onTap: storeModel.getDailyMoney,
      );
    }
    return PremiumButton(onTap: () {
      final route = MaterialPageRoute(builder: (BuildContext context) {
        return const PremiumScreen();
      });
      Navigator.of(
        context,
        rootNavigator: true,
      ).push(route);
    });
  }
}

class BorderButton extends StatelessWidget {
  const BorderButton({Key? key, required this.text, this.width})
      : super(key: key);
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 161.w,
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color(0xFF13161F).withOpacity(0.8),
        border: Border.all(
          color: const Color(0xFF366AFD),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: AppThemes.helper3.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class PremiumButton extends StatelessWidget {
  const PremiumButton({Key? key, this.onTap}) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 343.w,
        height: 64.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color(0xFF366AFD),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 22,
              color: const Color(0xFF44B1FF).withOpacity(0.25),
            )
          ],
        ),
        child: Center(
          child: Text(
            'Get premium for \$0.99',
            style: AppThemes.helper5,
          ),
        ),
      ),
    );
  }
}

class DailyCoins extends StatelessWidget {
  const DailyCoins({Key? key, this.onTap, this.enabled = false})
      : super(key: key);
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          width: 343.w,
          height: 64.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 7.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white.withOpacity(0.09),
            border: Border.all(color: const Color(0xFF366AFD).withOpacity(0.3)),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xFF366AFD),
            ),
            child: Center(
              child: Text(
                'get daily coins'.toUpperCase(),
                style: AppThemes.helper5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
