part of 'package:sol_replace_revamp/src/core/components/custom_date_picker/date_picker_library.dart';

class _CalendarView extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;

  final DateTime? selectedDate;
  final Function(DateTime) selectDateTab;

  const _CalendarView({
    required this.firstDate,
    required this.lastDate,
    required this.selectedDate,
    required this.selectDateTab,
  });

  @override
  State<_CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView> {
  DateTime _currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.selectedDate != null) {
      _currentMonth = DateTime(
        widget.selectedDate!.year,
        widget.selectedDate!.month,
      );
    }
  }

  @override
  void didUpdateWidget(_CalendarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update current month when selected date changes (e.g., from input view)
    if (widget.selectedDate != null &&
        (oldWidget.selectedDate == null ||
            oldWidget.selectedDate!.year != widget.selectedDate!.year ||
            oldWidget.selectedDate!.month != widget.selectedDate!.month)) {
      setState(() {
        _currentMonth = DateTime(
          widget.selectedDate!.year,
          widget.selectedDate!.month,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, data) => SizedBox(
        height: ResponsiveHelper.responsiveHeight(
          data: data,
          mobile: 350.0,
          tablet: 370.0,
          desktop: 400.0,
        ),
        child: Column(
          children: [
            // Month/Year Header with separate dropdowns
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CommonInkWell(
                  onTap: () {
                    setState(() {
                      _currentMonth = DateTime(
                        _currentMonth.year,
                        _currentMonth.month - 1,
                      );
                    });
                  },
                  child: Icon(
                    Icons.chevron_left,
                    color: AppColors.whiteColor,
                    size: ResponsiveHelper.adaptiveIconSize(
                      data: data,
                      baseSize: 24.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CustomDropdown<int>(

                    value: _currentMonth.month,
                    options: List.generate(12, (index) => index + 1),
                    onChanged: (month) {
                      setState(() {
                        _currentMonth = DateTime(_currentMonth.year, month);
                      });
                    },
                    itemToString: (month) => _getMonthName(month),
                    backgroundColor: AppColors.blackColor,
                    textColor: AppColors.whiteColor,
                    iconColor: AppColors.whiteColor,
                    borderRadius: ResponsiveHelper.responsiveRadius(
                      data: data,
                      mobile: 8.0,
                      tablet: 10.0,
                      desktop: 12.0,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.responsiveSpacing(
                        data: data,
                        mobile: 10.0,
                        tablet: 12.0,
                        desktop: 14.0,
                      ),
                      vertical: ResponsiveHelper.responsiveSpacing(
                        data: data,
                        mobile: 6.0,
                        tablet: 8.0,
                        desktop: 10.0,
                      ),
                    ),
                  ),
                ),
                12.horizontalSpace,
                Expanded(
                  flex: 2,
                  child: CustomDropdown<int>(
                    value: _currentMonth.year,
                    options: _getYearOptions(),
                    onChanged: (year) {
                      setState(() {
                        _currentMonth = DateTime(year, _currentMonth.month);
                      });
                    },
                    itemToString: (year) => year.toString(),
                    backgroundColor: AppColors.blackColor,
                    textColor: AppColors.whiteColor,
                    iconColor: AppColors.whiteColor,
                    borderRadius: ResponsiveHelper.responsiveRadius(
                      data: data,
                      mobile: 8.0,
                      tablet: 10.0,
                      desktop: 12.0,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.responsiveSpacing(
                        data: data,
                        mobile: 10.0,
                        tablet: 12.0,
                        desktop: 14.0,
                      ),
                      vertical: ResponsiveHelper.responsiveSpacing(
                        data: data,
                        mobile: 6.0,
                        tablet: 8.0,
                        desktop: 10.0,
                      ),
                    ),
                  ),
                ),
                CommonInkWell(
                  onTap: () {
                    setState(() {
                      _currentMonth = DateTime(
                        _currentMonth.year,
                        _currentMonth.month + 1,
                      );
                    });
                  },
                  child: Icon(
                    Icons.chevron_right,
                    color: AppColors.whiteColor,
                    size: ResponsiveHelper.adaptiveIconSize(
                      data: data,
                      baseSize: 24.0,
                    ),
                  ),
                ),
              ],
            ),
            16.verticalSpace,

            Row(
              children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
                return Expanded(
                  child: Text(
                    day,
                    textAlign: TextAlign.center,
                    style: FontStyles.montserratRegular.copyWith(
                      fontSize: ResponsiveHelper.adaptiveFontSize(
                        data: data,
                        baseSize: 12.0,
                        scaleFactor: 0.9,
                      ),
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: ResponsiveHelper.responsiveSpacing(
                data: data,
                mobile: 8.0,
                tablet: 10.0,
                desktop: 12.0,
              ),
            ),

            // Calendar grid
            ..._buildCalendarDays(data),
          ],
        ),
      ),
    );
  }

  List<int> _getYearOptions() {
    final startYear = widget.firstDate.year;
    final endYear = widget.lastDate.year;
    return List.generate(endYear - startYear + 1, (index) => startYear + index);
  }

  List<Widget> _buildCalendarDays(ResponsiveData data) {
    final daysInMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    ).day;
    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    final firstWeekday =
        firstDayOfMonth.weekday % 7; // Convert to 0-based (Sunday = 0)

    List<Widget> calendarRows = [];
    List<Widget> currentRow = [];

    // Add empty cells for days before the first day of the month
    for (int i = 0; i < firstWeekday; i++) {
      currentRow.add(Expanded(child: SizedBox()));
    }

    // Add days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, day);
      final isSelected =
          widget.selectedDate != null &&
          widget.selectedDate!.year == date.year &&
          widget.selectedDate!.month == date.month &&
          widget.selectedDate!.day == date.day;

      final isDisabled =
          date.isBefore(widget.firstDate) || date.isAfter(widget.lastDate);
      currentRow.add(
        Expanded(
          child: GestureDetector(
            onTap: isDisabled ? null : () => widget.selectDateTab(date),
            child: Container(
              margin: EdgeInsets.all(
                ResponsiveHelper.responsiveSpacing(
                  data: data,
                  mobile: 1.5,
                  tablet: 2.0,
                  desktop: 2.5,
                ),
              ),
              height: ResponsiveHelper.responsiveHeight(
                data: data,
                mobile: 36.0,
                tablet: 40.0,
                desktop: 44.0,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  ResponsiveHelper.responsiveRadius(
                    data: data,
                    mobile: 18.0,
                    tablet: 20.0,
                    desktop: 22.0,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  day.toString(),
                  style: FontStyles.montserratRegular.copyWith(
                    fontSize: ResponsiveHelper.adaptiveFontSize(
                      data: data,
                      baseSize: 14.0,
                      scaleFactor: 1.0,
                    ),
                    color: isDisabled
                        ? AppColors.lightGreyColor
                        : isSelected
                        ? AppColors.blackColor
                        : AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Start new row after 7 days
      if (currentRow.length == 7) {
        calendarRows.add(Row(children: currentRow));
        currentRow = [];
      }
    }

    // Add remaining days to the last row
    if (currentRow.isNotEmpty) {
      // Fill remaining cells with empty widgets
      while (currentRow.length < 7) {
        currentRow.add(Expanded(child: SizedBox()));
      }
      calendarRows.add(Row(children: currentRow));
    }

    return calendarRows;
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
