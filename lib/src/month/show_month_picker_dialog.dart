import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/device_orientation_builder.dart';
import '../shared/month_picker.dart';

/// Shows a dialog containing a Material Design date picker.
///
/// The returned [Future] resolves to the date selected by the user or `null` when tap
/// outside the dialog.
///
/// When the date picker is first displayed, it will show the [initialDate].
///
/// The [minDate] is the earliest allowable date. The [maxDate] is the latest
/// allowable date. [initialDate] and [selectedDate] must either fall between these dates,
/// or be equal to one of them. For each of these [DateTime] parameters, only
/// their dates are considered. Their time fields are ignored. They must all
/// be non-null.
///
/// [initialDate] and [currentDate], If not specified, they will default to `DateTime.now()` date.
///
/// The locale for the date picker defaults to the ambient locale
/// provided by [Localizations].
///
/// The [context], [useRootNavigator] and [routeSettings] arguments are passed to
/// [showDialog], the documentation for which discusses how it is used.
///
/// An optional [initialPickerType] argument can be used to have the
/// date picker initially appear in the [initialPickerType.year],
/// [initialPickerType.month] or [initialPickerType.day] mode. It defaults
/// to [initialPickerType.day].
///
/// See also:
///
///  * [DatePicker], which provides the calendar grid used by the date picker dialog.
///
Future<DateTime?> showMonthPickerDialog({
  required BuildContext context,
  required DateTime maxDate,
  required DateTime minDate,
  double? width,
  double? height,
  DateTime? initialDate,
  DateTime? currentDate,
  DateTime? selectedDate,
  EdgeInsets contentPadding = const EdgeInsets.all(16),
  EdgeInsets padding = const EdgeInsets.all(36),
  bool barrierDismissible = true,
  Color? barrierColor = Colors.black54,
  String? barrierLabel,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  TextStyle? enabledCellsTextStyle,
  BoxDecoration enabledCellsDecoration = const BoxDecoration(),
  TextStyle? disabledCellsTextStyle,
  BoxDecoration disabledCellsDecoration = const BoxDecoration(),
  TextStyle? currentDateTextStyle,
  BoxDecoration currentDateDecoration = const BoxDecoration(),
  TextStyle? selectedCellTextStyle,
  BoxDecoration? selectedCellDecoration,
  double? slidersSize,
  Color? slidersColor,
  TextStyle? leadingDateTextStyle,
  Color? highlightColor,
  Color? splashColor,
  double? splashRadius,
  bool centerLeadingDate = false,
  String? previousPageSemanticLabel,
  String? nextPageSemanticLabel,
  ShapeBorder? shape,
  Color? backgroundColor,
}) async {
  return showDialog<DateTime>(
    context: context,
    barrierColor: barrierColor,
    anchorPoint: anchorPoint,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    routeSettings: routeSettings,
    useRootNavigator: useRootNavigator,
    useSafeArea: useSafeArea,
    builder: (context) {
      return DeviceOrientationBuilder(builder: (context, o) {
        late final Size size;
        switch (o) {
          case Orientation.portrait:
            size = const Size(328.0, 350.0);
            break;
          case Orientation.landscape:
            size = const Size(328.0, 300.0);
            break;
        }
        return Padding(
          padding: padding,
          child: Dialog(
            shape: shape,
            backgroundColor: backgroundColor,
            insetPadding: EdgeInsets.zero,
            child: SizedBox(
              width: width ?? size.width,
              height: height ?? size.height,
              child: MonthPicker(
                centerLeadingDate: centerLeadingDate,
                initialDate: initialDate,
                maxDate: maxDate,
                minDate: minDate,
                currentDate: currentDate,
                selectedDate: selectedDate,
                padding: contentPadding,
                onDateSelected: (value) {
                  Navigator.pop(context, value);
                  _vibrate(context);
                },
                currentDateDecoration: currentDateDecoration,
                currentDateTextStyle: currentDateTextStyle,
                disabledCellsDecoration: disabledCellsDecoration,
                disabledCellsTextStyle: disabledCellsTextStyle,
                enabledCellsDecoration: enabledCellsDecoration,
                enabledCellsTextStyle: enabledCellsTextStyle,
                selectedCellDecoration: selectedCellDecoration,
                selectedCellTextStyle: selectedCellTextStyle,
                leadingDateTextStyle: leadingDateTextStyle,
                slidersColor: slidersColor,
                slidersSize: slidersSize,
                highlightColor: highlightColor,
                splashColor: splashColor,
                splashRadius: splashRadius,
                previousPageSemanticLabel: previousPageSemanticLabel,
                nextPageSemanticLabel: nextPageSemanticLabel,
              ),
            ),
          ),
        );
      });
    },
  );
}

void _vibrate(BuildContext context) {
  switch (Theme.of(context).platform) {
    case TargetPlatform.android:
      HapticFeedback.vibrate();
      break;
    case TargetPlatform.iOS:
      HapticFeedback.lightImpact();
      break;
    default:
      break;
  }
}
