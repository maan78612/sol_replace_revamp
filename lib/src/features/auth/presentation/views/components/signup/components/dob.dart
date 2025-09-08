part of 'package:sol_replace_revamp/src/features/auth/auth_library.dart';

class _DOBPicker extends StatelessWidget {
  final Function(DateTime) setDate;
  final CustomTextController controller;

  const _DOBPicker({required this.setDate, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, data) {
        return CommonInkWell(
          onTap: () async {
            await DialogBoxUtils.show(
              CustomDatePicker(
                firstDate: DateTime(1920),
                lastDate: DateTime.now(),
                fieldHintText: 'dd/mm/yyyy',
                fieldLabelText: 'Enter date (dd/mm/yyyy)',
                suffixWidget: _suffixIcon(),
                onDateSelected: (date) {
                  setDate(date);
                },
              ),
            );
          },
          child: CustomInputField(
            title: 'Enter ',
            titleIcon: AppIcons.calendar,
            hint: 'DD / MM / YYYY',
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
              color: AppColors.blackColor,
            ),
          ),
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
