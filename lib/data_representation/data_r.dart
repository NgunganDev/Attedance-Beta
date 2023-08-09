import '../model_data/model_retrieve_attedance.dart';

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}
class Representation {

List<ModelAttedance> _listOf = [];
List<ModelAttedance> _listNon = [];
List<ModelAttedance> _listDay = [];
List<ModelAttedance> _listAttedance = [];
set listTo (List<ModelAttedance> theList){
  _listOf = theList;
}

List<ModelAttedance> get nonData {
  return _listNon;
} 

List<ModelAttedance> get listOf{
  return _listOf;
}

List<ModelAttedance> get dataAattedance {
  return _listAttedance;
}

  //  Refactor code 
  List<ModelAttedance> dayData (Weekday weekly){
    _listDay =  listOf.where((element) {
      return element.realtime.toDate().weekday == weekly.index + 1;
    }).toList();
    return _listDay;
  }

    List<ModelAttedance> dataAttedance (Weekday weekly){
    _listAttedance =  listOf.where((element) {
      return element.realtime.toDate().weekday == weekly.index + 1 && element.noAttedance == '';
    }).toList();
    return _listAttedance;
  }

   List<ModelAttedance> dataNon (Weekday weekly){
    _listNon =  listOf.where((element) {
      return element.realtime.toDate().weekday == weekly.index + 1 && element.noAttedance != '';
    }).toList();
    return _listNon;
  
}
}
