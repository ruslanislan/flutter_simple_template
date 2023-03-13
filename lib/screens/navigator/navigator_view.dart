import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_template/screens/navigator/navigator.dart';
import 'package:flutter_simple_template/widgets/background_widget.dart';
import 'package:provider/provider.dart';

class NavigatorView extends StatelessWidget {
  const NavigatorView({
    Key? key,
    required this.child,
    required this.navigatorModel,
  }) : super(key: key);
  final Widget child;
  final NavigatorModel navigatorModel;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: ChangeNotifierProvider.value(
        value: navigatorModel,
        child: Consumer<NavigatorModel>(
          builder: (BuildContext context, NavigatorModel value, Widget? _) {
            return Column(
              children: [
                Expanded(child: child),
                Container(
                  height: 56.h,
                  color: const Color(0xFF12151E),
                  child: Row(
                    children: List.generate(
                      value.items.length,
                      (index) {
                        final item = value.items[index];
                        return Expanded(
                          child: NavBarItem(
                            selected: value.selected == index,
                            asset: item.asset,
                            text: item.text,
                            onTap: () => value.selected = index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    Key? key,
    this.selected = false,
    required this.asset,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final bool selected;
  final String asset;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Image.asset(asset),
          ),
          SizedBox(height: 4.h),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.r,
              height: 15 / 12,
              color: const Color(0xFF366AFD),
            ),
          )
        ],
      );
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Center(
          child: Opacity(
            opacity: 0.3,
            child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: Image.asset(asset),
            ),
          ),
        ),
      ),
    );
  }
}
