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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.blackColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 24.sp, horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _header(context),
          20.verticalSpace,
          _tabBar(),
          20.verticalSpace,

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

          20.verticalSpace,

          SizedBox(
            height: 40.h,
            width: 200.w,
            child: CustomButton(
              title: "Select Date",
              bgColor: AppColors.primaryColor,
              onPressed: () {
                if (selectedDate != null) {
                  widget.onDateSelected(selectedDate!);
                  CustomNavigation().pop();
                } else {
                  SnackBarUtils.show(
                    'Please select a date',
                    SnackBarType.error,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Row _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Select Date',
          style: FontStyles.montserratBold.copyWith(
            fontSize: 18.sp,
            color: AppColors.whiteColor,
          ),
        ),
        IconButton(
          onPressed: () => CustomNavigation().pop(),
          icon: Icon(Icons.close, color: AppColors.whiteColor),
        ),
      ],
    );
  }

  Widget _tabBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          _tab(
            onTap: () => setState(() => _pickerMode = PickerModeEnum.calender),
            title: 'Calendar',
            isSelected: _pickerMode == PickerModeEnum.calender,
          ),
          20.horizontalSpace,
          _tab(
            onTap: () => setState(() => _pickerMode = PickerModeEnum.input),
            title: 'Manual Input',
            isSelected: _pickerMode == PickerModeEnum.input,
          ),
        ],
      ),
    );
  }

  Widget _tab({
    required Function() onTap,
    required String title,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.sp),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: FontStyles.montserratRegular.copyWith(
              fontSize: 14.sp,
              color: isSelected ? AppColors.blackColor : AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
