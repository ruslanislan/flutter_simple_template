import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_template/screens/screens.dart';
import 'package:flutter_simple_template/widgets/widgets.dart';
import 'package:provider/provider.dart';

class StoreView extends StatelessWidget {
  const StoreView({Key? key, required this.storeModel}) : super(key: key);
  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: storeModel,
      child: Consumer<StoreModel>(
        builder: (BuildContext context, StoreModel value, Widget? child) {
          final enabled = value.selectedHint != null;
          final canDecrement = value.counter > 1;
          final canIncrement = enabled &&
              (value.counter + 1) * value.selectedHint!.price <= value.coins;
          return Column(
            children: [
              CustomAppBar(coins: value.coins),
              ...List.generate(
                value.hints.length,
                (index) {
                  final hint = value.hints[index];
                  final enoughMoney = value.coins >= hint.price;
                  return Column(
                    children: [
                      SizedBox(height: 20.h),
                      StoreHintButton(
                        enabled: enoughMoney,
                        text: hint.text,
                        price: hint.price,
                        selected: value.selected == index,
                        onTap: () => value.selected = index,
                        count: value.getCount(index),
                        child: hint.widget,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 76.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  OperandButton(
                    enabled: enabled && canDecrement,
                    onTap: value.decrement,
                    color: const Color(0xFFFD3636).withOpacity(0.75),
                    child: Container(
                      width: 10,
                      height: 3,
                      color: Colors.white,
                    ),
                  ),
                  OperandButton(
                    enabled: enabled && canIncrement,
                    onTap: value.increment,
                    color: const Color(0xFF41D358).withOpacity(0.75),
                    child: SizedBox(
                      width: 14,
                      height: 14,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 14,
                            height: 3,
                            color: Colors.white,
                          ),
                          Container(
                            width: 3,
                            height: 14,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  BuyButton(
                    enabled: enabled,
                    onTap: value.buy,
                    count: value.counter,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
