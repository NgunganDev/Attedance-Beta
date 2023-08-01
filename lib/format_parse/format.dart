import 'package:intl/intl.dart';

class Format {
  String formatDate(DateTime date){
    String dateq = DateFormat.yMMMEd().format(date);
    return dateq;
  }

  String formatTime(DateTime time){
    String datae = DateFormat('MM-dd-yyyy HH:mm').format(time);
    return datae;
  }
}