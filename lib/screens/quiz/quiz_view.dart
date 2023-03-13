import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_template/screens/screens.dart';
import 'package:flutter_simple_template/utils/utils.dart';
import 'package:flutter_simple_template/widgets/widgets.dart';
import 'package:provider/provider.dart';

class QuizView extends StatelessWidget {
  const QuizView({Key? key, required this.quizModel}) : super(key: key);
  final QuizModel quizModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: quizModel,
      child: Consumer2<QuizModel, StoreModel>(
        builder: (
          BuildContext context,
          QuizModel model,
          StoreModel storeModel,
          Widget? child,
        ) {
          return Column(
            children: [
              CustomAppBar(coins: storeModel.coins),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(20.r),
                height: 180.h,
                width: 180.w,
                child: Image.asset(cryptoCoins[storeModel.level].asset),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  model.targetLetters.length,
                  (index) => QuizCell(
                    onTap: () => model.unselect(index),
                    letter: model.targetLetters[index].values.first,
                  ),
                ),
              ),
              SizedBox(height: 170.h),
              _buildAdditionalButtons(model, storeModel),
              SizedBox(height: 16.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: List.generate(
                    quizModel.word.length,
                    (index) => LetterCell(
                      onTap: () => quizModel.selectLetter(index),
                      letter: quizModel.lettersMap[index]!,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAdditionalButtons(QuizModel model, StoreModel storeModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AdditionalCell(
          enabled: storeModel.randomHintCount > 0,
          color: const Color(0xFF366AFD).withOpacity(0.75),
          onTap: model.useRandomHint,
          child: Text(
            '?',
            style: AppThemes.helper3,
          ),
        ),
        AdditionalCell(
          enabled: storeModel.selectedHintCount > 0,
          color: const Color(0xFF366AFD).withOpacity(0.75),
          onTap: model.useSelectedHint,
          child: Image.asset(
            'assets/png/icons/pencil.png',
            width: 20.w,
            height: 20.h,
          ),
        ),
        AdditionalCell(
          enabled: storeModel.wordHintCount > 0,
          color: const Color(0xFF366AFD).withOpacity(0.75),
          onTap: model.useWordHint,
          child: Text(
            'aA',
            style: AppThemes.helper3,
          ),
        ),
        AdditionalCell(
          enabled: quizModel.canClear,
          color: const Color(0xFFFD3636).withOpacity(0.75),
          onTap: model.clear,
          child: Image.asset(
            'assets/png/icons/delete.png',
            width: 18.w,
            height: 16.h,
          ),
        ),
      ],
    );
  }
}

class QuizCell extends StatelessWidget {
  const QuizCell({Key? key, this.onTap, required this.letter})
      : super(key: key);
  final VoidCallback? onTap;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24.w,
        height: 40.h,
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: const Color(0xFF13161F).withOpacity(0.8),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: const Color(0xFF366AFD),
          ),
        ),
        child: Center(
          child: Text(
            letter,
            style: AppThemes.helper2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class LetterCell extends StatelessWidget {
  const LetterCell({Key? key, required this.letter, this.onTap})
      : super(key: key);
  final String letter;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF13161F).withOpacity(0.8),
          border: Border.all(
            color: const Color(0xFF366AFD).withOpacity(0.25),
          ),
        ),
        child: Center(
          child: Text(
            letter.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.r,
              height: 29 / 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
