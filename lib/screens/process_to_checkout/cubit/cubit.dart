import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/process_to_checkout/cubit/states.dart';
import 'package:food_project/shared/network/local/local.dart';
import 'package:intl/intl.dart';

class AddOrderCubit extends Cubit<OrderStates> {
  AddOrderCubit() : super(OrderStateInitial());
  static AddOrderCubit get(context) => BlocProvider.of(context);

  List orderMeals = [];
  List orderMealsId = [];

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  var currentHour = new DateTime(now.hour);
  var currentMinute = new DateTime(now.minute);
  var currentTime = new DateTime(now.year, now.month, now.day, now.hour, now.minute,now.second);

  addOrder({name,phone,area,street,building,floor,apartment,note,orderName,totalPrice}) async {
    emit(AddOrderStateLoading());
    await Firestore.instance.collection('Orders').add({
      'UserFullName': '${name.toString()}',
      'UserPhone': '${phone.toString()}',
      'UserArea': '${area.toString()}',
      'UserStreetName': '${street.toString()}',
      'UserBuildingNumber':'${building.toString()}',
      'UserFloorNumber': '${floor.toString()}',
      'UserApartmentNumber': '${apartment.toString()}',
      'UserNote': '${note.toString()}',
      'UserId': '${getToken().toString()}',
      'UserOrder':'${orderName.toString()}',
      'UserTotalPrice': '${totalPrice.toString()}',
      'Date' : '${formatted.toString()}',
      'DateAndTime': '${currentTime.toString()}',
      'DateAndTimeAdmin': Timestamp.now(),
    }).then((value) async{
      emit(AddOrderStateSuccess());

    }).catchError((e){
      emit(AddOrderStateError(e.toString()));
    });
  }

  // showOrdersUser(){
  //   emit(ShowOrderStateLoading());
  //   FirebaseFirestore.instance.collection('Orders').get().then((value){
  //     emit(ShowOrderStateSuccess());
  //     print('$value');
  //     for(var doc in value.docs ) {
  //       if(doc['UserId']==getToken().toString()){
  //         orderMeals.add(doc.data());
  //       }
  //     }
  //     // cartMeals=value.docs;
  //     for(var doc in value.docs ) {
  //       if(doc['UserId']==getToken().toString()){
  //         orderMealsId.add(doc.id);
  //       }
  //       // cartMealsId.add(doc.id);
  //     }
  //     print('========$orderMealsId');
  //   }).catchError((e){
  //     emit(ShowOrderStateError(e));
  //   });
  // }

  showOrdersAdmin(){}


  Future<void> deleteMeal({documentId,index}) async {
    return await FirebaseFirestore.instance.collection('Orders')
        .doc(documentId[index].toString())
        .delete();
  }


}
