


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/table/cubit/state.dart';

class TableCubit extends Cubit<TableStates> {

  TableCubit() : super(TableStateInitial());

  static TableCubit get(context) => BlocProvider.of(context);

  var times = [
     "1 To 3 PM",
     "3 To 5 PM",
     "5 To 7 PM",
     "7 To 9 PM",
     "9 To 11 PM",
  ];

  var people = [
    "1 - 2",
    "3 - 4",
    "5 - 6",
    "7 - 8",
    "MORE",
  ];

  int currentIndex1 = 0 ;
  int currentIndex2 = 0 ;

  changeIndex1(index){
    currentIndex1 = index ;
    emit(TimeStateIndex());
  }

  changeIndex2(index){
    currentIndex2 = index ;
    emit(TimeStateIndex());
  }

}