import 'package:flutter/cupertino.dart';
import './cupertinoDatePickerWeiPin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../app/services/screenAdapter.dart';

class DatePicker extends StatelessWidget {
  final void Function(DateTime) onChanged;
  final DateTime date;
  final int? minimumYear;
  final int? maximumYear;
  final bool? showToday;

  const DatePicker({
    super.key,
    required this.date,
    required this.onChanged,
    this.minimumYear,
    this.maximumYear,
    this.showToday,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: TextStyle(
            // decorationColor: Colors.white,
            // backgroundColor: Colors.white,
            color: const Color.fromRGBO(51, 51, 51, 1),
            fontSize: ScreenAdapter.fontSize(14),
          ),
        ),
      ),
      child: Localizations.override(
          context: context,
          locale: const Locale('zh'),
          delegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          child: Builder(builder: (context) {
            return CupertinoDatePickerWeiPin(
              key: UniqueKey(),
              minimumYear: minimumYear!,
              maximumYear: maximumYear,
              dateOrder: DatePickerDateOrder.ym,
              backgroundColor:
                  CupertinoColors.systemBackground.resolveFrom(context),
              mode: CupertinoDatePickerModeWeiPin.date,
              initialDateTime: date,
              onDateTimeChanged: (newDateTime) {
                // print(newDateTime);
                onChanged(newDateTime);
              },
            );
          })),
    );
  }
}
