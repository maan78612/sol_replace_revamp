part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _DOBPicker extends ConsumerWidget {
  final Function(DateTime) setDate;
  final CustomTextController controller;

  const _DOBPicker({required this.setDate, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveWidget(
      builder: (context, data) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonInkWell(
              onTap: () async {
                await DialogBoxUtils.show(
                  CustomDatePicker(
                    firstDate: DateTime(1920),
                    lastDate: DateTime.now(),
                    fieldHintText: 'dd/mm/yyyy',
                    // Explicitly set hint text format
                    fieldLabelText: 'Enter date (dd/mm/yyyy)',
                    suffixWidget: _suffixIcon(),
                    onDateSelected: (date) {
                      setDate(date);
                    },
                  ),
                );
              },
              child: CustomInputField(
                title: 'Enter your birthday',
                titleIcon: AppIcons.calendar,
                hint: '"DD / MM / YYYY',
                enabled: false,
                textInputAction: TextInputAction.next,
                controller: controller,
                suffixWidget: _suffixIcon(),
                textStyle: FontStyles.montserratMedium.copyWith(
                  fontSize: ResponsiveHelper.adaptiveFontSize(
                    data: data,
                    baseSize: 14.0,
                    scaleFactor: 1.0,
                  ),
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 12.0,
                tablet: 14.0,
                desktop: 16.0,
              ),
            ),
            Text.rich(
              textAlign: TextAlign.start,
              softWrap: true,
              TextSpan(
                children: [
                  WidgetSpan(
                    child: SvgPicture.asset(
                      AppIcons.alert,
                      width: ResponsiveHelper.responsiveIconSize(
                        data: data,
                        mobile: 24.0,
                        tablet: 26.0,
                        desktop: 28.0,
                      ),
                      height: ResponsiveHelper.responsiveIconSize(
                        data: data,
                        mobile: 24.0,
                        tablet: 26.0,
                        desktop: 28.0,
                      ),
                    ),
                  ),
                  WidgetSpan(
                    child: SizedBox(
                      width: ResponsiveHelper.responsiveSpacing(
                        data: data,
                        mobile: 12.0,
                        tablet: 14.0,
                        desktop: 16.0,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: 'You must be at least 18 years old to register',
                    style: FontStyles.montserratRegular.copyWith(
                      fontSize: ResponsiveHelper.adaptiveFontSize(
                        data: data,
                        baseSize: 14.0,
                        scaleFactor: 0.95,
                      ),
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  SvgPicture _suffixIcon() {
    return SvgPicture.asset(
      AppIcons.calendar,
      colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
    );
  }
}
