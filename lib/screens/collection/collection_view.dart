import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_template/screens/screens.dart';
import 'package:flutter_simple_template/utils/app_themes.dart';
import 'package:flutter_simple_template/utils/crypto_coins.dart';
import 'package:flutter_simple_template/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class CollectionView extends StatelessWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storeModel = context.read<StoreModel>();
    return Column(
      children: [
        CustomAppBar(
          coins: storeModel.coins,
          level: storeModel.level + 1,
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 80.w / 117.h,
              mainAxisSpacing: 8.h,
              crossAxisSpacing: 8.w,
            ),
            itemCount: 50,
            itemBuilder: (BuildContext context, int index) {
              return CollectionItem(
                asset: cryptoCoins[index].asset,
                enabled: storeModel.level > index,
                name: cryptoCoins[index].name,
              );
            },
          ),
        ),
      ],
    );
  }
}

class CollectionItem extends StatelessWidget {
  const CollectionItem({
    Key? key,
    required this.asset,
    this.enabled = false,
    required this.name,
  }) : super(key: key);
  final String asset;
  final bool enabled;
  final String name;

  Color get color {
    if (enabled) return const Color(0xFF3692FD).withOpacity(0.1);
    return const Color(0xFF366AFD).withOpacity(0.1);
  }

  String get imageAsset {
    if (enabled) return asset;
    return 'assets/png/placeholder.png';
  }

  String get text {
    if (enabled) return name;
    return '?';
  }

  TextStyle get style {
    if (enabled) return AppThemes.helper7;
    return AppThemes.helper7.copyWith(
      color: Colors.white.withOpacity(0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 117.h,
      decoration: BoxDecoration(
        color: const Color(0xFF13161F).withOpacity(0.8),
        border: Border.all(
          color: const Color(0xFF366AFD).withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            color: color,
            child: Center(
              child: Image.asset(
                imageAsset,
                width: 48.w,
                height: 48.h,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            text,
            style: style,
          )
        ],
      ),
    );
  }
}
