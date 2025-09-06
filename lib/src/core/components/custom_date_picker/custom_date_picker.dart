part of 'package:sol_replace_revamp/src/core/components/custom_date_picker/date_picker_library.dart';

enum PickerModeEnum { calender, input }

/// Custom date picker dialog with text field that has input formatters
class CustomDatePicker extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final String? fieldHintText;
  final String? fieldLabelText;
  final Function(DateTime) onDateSelected;
  final Widget? suffixWidget;

  const CustomDatePicker({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.fieldHintText,
    this.fieldLabelText,
    required this.onDateSelected,
    required this.suffixWidget,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;
  final CustomTextController _textController = CustomTextController(
    controller: TextEditingController(),
    focusNode: FocusNode(),
  );
  PickerModeEnum _pickerMode = PickerModeEnum.calender;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, data) => LayoutBuilder(
        builder: (context, constraints) {
          final dialogWidth = _calculateAdaptiveWidth(
            data,
            constraints.maxWidth,
          );

          return Container(
            width: dialogWidth,
            constraints: const BoxConstraints(maxWidth: 700),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: AppColors.blackColor,
            ),
            padding: EdgeInsets.symmetric(
              vertical: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 20.0,
                tablet: 24.0,
                desktop: 28.0,
              ),
              horizontal: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 16.0,
                tablet: 20.0,
                desktop: 24.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _header(context, data),
                SizedBox(
                  height: ResponsiveHelper.responsiveSpacing(
                    data: data,
                    mobile: 16.0,
                    tablet: 20.0,
                    desktop: 24.0,
                  ),
                ),
                _tabBar(data),
                SizedBox(
                  height: ResponsiveHelper.responsiveSpacing(
                    data: data,
                    mobile: 16.0,
                    tablet: 20.0,
                    desktop: 24.0,
                  ),
                ),

                if (_pickerMode == PickerModeEnum.calender)
                  _CalendarView(
                    firstDate: widget.firstDate,
                    lastDate: widget.lastDate,
                    selectedDate: selectedDate,
                    selectDateTab: (DateTime date) {
                      setState(() {
                        selectedDate = date;
                        _textController.controller.text = DateFormat(
                          'dd/MM/yyyy',
                        ).format(date);
                      });
                    },
                  )
                else
                  _InputView(
                    firstDate: widget.firstDate,
                    lastDate: widget.lastDate,
                    selectedDate: selectedDate,
                    textController: _textController,
                    suffixWidget: widget.suffixWidget,
                    fieldHintText: widget.fieldHintText,
                    fieldLabelText: widget.fieldLabelText,
                    setInputDate: (DateTime date) {
                      setState(() {
                        selectedDate = date;
                        _textController.error = null;
                      });
                    },
                  ),

                SizedBox(
                  height: ResponsiveHelper.responsiveSpacing(
                    data: data,
                    mobile: 20.0,
                    tablet: 24.0,
                    desktop: 28.0,
                  ),
                ),

                _buildSelectButton(data, dialogWidth),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Calculate adaptive width for the date picker dialog
  double _calculateAdaptiveWidth(ResponsiveData data, double availableWidth) {
    return ResponsiveHelper.value<double>(
      data: data,
      mobile: availableWidth * 0.95,
      // 95% of screen width on mobile
      mobileLarge: availableWidth * 0.85,
      tablet: availableWidth * 0.7,
      // 70% of screen width on tablet
      tabletLarge: availableWidth * 0.65,
      desktop: 600.0,
      // Fixed width for desktop
      desktopLarge: 650.0,
      ultraWide: 700.0,
      // Max width for ultra-wide
      fallback: availableWidth.clamp(300.0, 700.0),
    );
  }

  /// Build responsive select button
  Widget _buildSelectButton(ResponsiveData data, double dialogWidth) {
    final buttonWidth = ResponsiveHelper.value<double>(
      data: data,
      mobile: dialogWidth * 0.8,
      tablet: dialogWidth * 0.6,
      desktop: 300.0,
      fallback: 250.0,
    );

    final buttonHeight = ResponsiveHelper.responsiveHeight(
      data: data,
      mobile: 44.0,
      tablet: 48.0,
      desktop: 52.0,
    );

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: CustomButton(
        title: "Select Date",
        bgColor: AppColors.primaryColor,
        onPressed: () {
          if (selectedDate != null) {
            widget.onDateSelected(selectedDate!);
            CustomNavigation().pop();
          } else {
            SnackBarUtils.show('Please select a date', SnackBarType.error);
          }
        },
      ),
    );
  }

  Row _header(BuildContext context, ResponsiveData data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Select Date',
          style: FontStyles.montserratBold.copyWith(
            fontSize: ResponsiveHelper.adaptiveFontSize(
              data: data,
              baseSize: 18.0,
              scaleFactor: 1.0,
            ),
            color: AppColors.whiteColor,
          ),
        ),
        IconButton(
          onPressed: () => CustomNavigation().pop(),
          iconSize: ResponsiveHelper.adaptiveIconSize(
            data: data,
            baseSize: 24.0,
          ),
          icon: Icon(Icons.close, color: AppColors.whiteColor),
        ),
      ],
    );
  }

  Widget _tabBar(ResponsiveData data) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ResponsiveHelper.responsiveSpacing(
          data: data,
          mobile: 8.0,
          tablet: 10.0,
          desktop: 12.0,
        ),
        horizontal: ResponsiveHelper.responsiveSpacing(
          data: data,
          mobile: 12.0,
          tablet: 16.0,
          desktop: 20.0,
        ),
      ),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.responsiveRadius(
            data: data,
            mobile: 8.0,
            tablet: 10.0,
            desktop: 12.0,
          ),
        ),
      ),
      child: Row(
        children: [
          _tab(
            data: data,
            onTap: () => setState(() => _pickerMode = PickerModeEnum.calender),
            title: 'Calendar',
            isSelected: _pickerMode == PickerModeEnum.calender,
          ),
          16.horizontalSpace,

          _tab(
            data: data,
            onTap: () => setState(() => _pickerMode = PickerModeEnum.input),
            title: 'Manual Input',
            isSelected: _pickerMode == PickerModeEnum.input,
          ),
        ],
      ),
    );
  }

  Widget _tab({
    required ResponsiveData data,
    required Function() onTap,
    required String title,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveHelper.responsiveSpacing(
              data: data,
              mobile: 10.0,
              tablet: 12.0,
              desktop: 14.0,
            ),
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(
              ResponsiveHelper.responsiveRadius(
                data: data,
                mobile: 8.0,
                tablet: 10.0,
                desktop: 12.0,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: FontStyles.montserratRegular.copyWith(
              fontSize: ResponsiveHelper.adaptiveFontSize(
                data: data,
                baseSize: 14.0,
                scaleFactor: 0.9,
              ),
              color: isSelected ? AppColors.blackColor : AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
