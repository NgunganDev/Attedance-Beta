import 'dart:math';
import 'package:intl/intl.dart';

abstract class Format {
  // Format({thiss.form});
  String formatDate(DateTime date){
    String dateq = DateFormat.yMMMEd().format(date);
    return dateq;
  }

  String formatTime(DateTime time){
    String datae = DateFormat('MM-dd-yyyy HH:mm').format(time);
    return datae;
  }

  String uuidFormat(){
    Random random = Random();
    List<String> n1 = ['a','bv', 'vc','ju','4','2','1','8','9'];
    List<String> nF = n1.sublist(random.nextInt(2) + 1, random.nextInt(9));
    print(nF);
    return nF.join();
  }
}