import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note/core/theme/app_colors.dart';
import 'package:note/core/theme/app_dimens.dart';
import 'package:note/core/theme/app_spacing.dart';
import 'package:note/core/theme/app_text_styles.dart';
import 'package:note/features/onboard/data/onboard_items.dart';
import 'package:note/features/onboard/presentation/widgets/onboard_page.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final _pageController = PageController(initialPage: 1);

  var _skipTextVisibility = true;
  var _startButtonVisibility = false;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final currentPage = _pageController.page?.round();

      if (currentPage != null && currentPage != _currentPage) {
        _currentPage = currentPage;

        final isLastPage = _currentPage == onboardItems.length - 1;

        setState(() {
          _skipTextVisibility = !isLastPage;
          _startButtonVisibility = isLastPage;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(AppDimens.paddingMd.r),
              child: Visibility(
                visible: _skipTextVisibility,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: GestureDetector(
                  onTap: () {}, // TODO: tap logic
                  child: Text(
                    "Пропустить",
                    style: AppTextStyles.poppins15SemiBold.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(child: Text("Notes", style: AppTextStyles.pottaOne24Regular)),
          AppSpacing.h32,
          SizedBox(
            height: 490.h,
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardItems.length,
              itemBuilder: (context, index) =>
                  OnboardPage(entity: onboardItems[index]),
            ),
          ),
          AppSpacing.h24,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardItems.length,
              (index) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingXss.w,
                ),
                child: Container(
                  width: 12.w,
                  height: 11.h,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Visibility(
                visible: _startButtonVisibility,
                child: ElevatedButton(
                  onPressed: () {}, // TODO: tap logic
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                    ),
                    fixedSize: Size(230.w, 58.h),
                  ),
                  child: Text("Начать", style: AppTextStyles.roboto21Bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
