part of 'package:sol_replace_revamp/src/core/components/custom_date_picker/date_picker_library.dart';

class _InputView extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  final String? fieldHintText;
  final String? fieldLabelText;
  final Widget? suffixWidget;
  final DateTime? selectedDate;
  final CustomTextController textController;
  final Function(DateTime) setInputDate;

  const _InputView({
    required this.firstDate,
    required this.lastDate,
    this.fieldHintText,
    this.fieldLabelText,
    required this.suffixWidget,
    required this.selectedDate,
    required this.textController,
    required this.setInputDate,
  });

  @override
  State<_InputView> createState() => _InputViewState();
}

class _InputViewState extends State<_InputView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          10.verticalSpace,
          CustomInputField(
            controller: widget.textController,
            hint: widget.fieldHintText ?? 'dd/mm/yyyy',
            label: widget.fieldLabelText ?? 'Enter date',
            suffixWidget: widget.suffixWidget,
            errorPadding: EdgeInsets.symmetric(
              vertical: 8.sp,
              horizontal: 10.sp,
            ),
            inputFormatters: [
              _DateInputFormatter(),
              LengthLimitingTextInputFormatter(10),
            ],
            onChange: (value) {
              _parseAndSetDate(value);
            },
          ),
          10.verticalSpace,
          if (widget.textController.error != null) ...[_buildErrorText()],
          30.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildErrorText() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      margin: EdgeInsets.only(top: 8.h),
      decoration: BoxDecoration(
        color: AppColors.redColor.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: AppColors.redColor.withValues(alpha:0.3)),
      ),
      child: Text(
        widget.textController.error ?? "",
        maxLines: 2,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: FontStyles.montserratRegular.copyWith(
          fontSize: 12.sp,
          color: AppColors.redColor,
        ),
      ),
    );
  }

  void _parseAndSetDate(String value) {
    setState(() {
      widget.textController.error = null;
    });

    if (value.length == 10 && value.contains('/')) {
      try {
        final parts = value.split('/');
        if (parts.length == 3) {
          final day = int.tryParse(parts[0]);
          final month = int.tryParse(parts[1]);
          final year = int.tryParse(parts[2]);

          if (day != null && month != null && year != null) {
            // Validate day and month ranges
            if (day >= 1 && day <= 31 && month >= 1 && month <= 12) {
              final date = DateTime(year, month, day);

              // Check if date is within allowed range
              if (date.isAfter(
                    widget.firstDate.subtract(const Duration(days: 1)),
                  ) &&
                  date.isBefore(widget.lastDate.add(const Duration(days: 1)))) {
                widget.setInputDate(date);
              } else {
                setState(() {
                  widget.textController.error =
                      'Date must be between ${widget.firstDate.day}/${widget.firstDate.month}/${widget.firstDate.year} and ${widget.lastDate.day}/${widget.lastDate.month}/${widget.lastDate.year}';
                });
              }
            } else {
              setState(() {
                widget.textController.error =
                    'Invalid day or month. Day must be 1-31, month must be 1-12.';
              });
            }
          } else {
            setState(() {
              widget.textController.error =
                  'Invalid date format. Please enter a valid date.';
            });
          }
        } else {
          setState(() {
            widget.textController.error =
                'Invalid date format. Please use dd/mm/yyyy.';
          });
        }
      } catch (e) {
        setState(() {
          widget.textController.error = 'Invalid date. Please try again.';
        });
      }
    } else if (value.isNotEmpty) {
      setState(() {
        widget.textController.error =
            'Please enter a complete date in dd/mm/yyyy format.';
      });
    }
  }
}
