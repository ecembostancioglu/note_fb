import 'package:easy_localization/easy_localization.dart';

class Calculator{

  static String dateTimeToString(DateTime dateTime){

    String formattedDate=DateFormat('yyyy/MM/dd').format(dateTime);
    return formattedDate;
  }

}