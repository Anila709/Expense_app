import 'package:intl/intl.dart';

class DateTimeUtils {
  static final dateFormat=DateFormat.yMd();
  static final monthFormat=DateFormat.yM();
  static final yearFormat=DateFormat.y();


//format date..
  static String getFormattedDateFromMilliseconds(int milliseconds){
    var date=DateTime.fromMillisecondsSinceEpoch(milliseconds);
    var formattedDate=dateFormat.format(date);
    return formattedDate;
  }

  static String getFormattedDateFromDateTime(DateTime dateTime){
    var formattedDate =dateFormat.format(dateTime);
    return formattedDate;
  }

  //format months..
  static String getFormattedMonthFromMilliseconds(int milliseconds){
    var month=DateTime.fromMillisecondsSinceEpoch(milliseconds);
    var formattedMonth=monthFormat.format(month);
    return formattedMonth;
  }

  static String getFormattedMonthFromDateTime(DateTime dateTime){
    var formattedMonth =monthFormat.format(dateTime);
    return formattedMonth;
  }

    //format years..
  static String getFormattedYearFromMilliseconds(int milliseconds){
    var year=DateTime.fromMillisecondsSinceEpoch(milliseconds);
    var formattedYear=yearFormat.format(year);
    return formattedYear;
  }

  static String getFormattedYearFromDateTime(DateTime dateTime){
    var formattedYear =yearFormat.format(dateTime);
    return formattedYear;
  }
}