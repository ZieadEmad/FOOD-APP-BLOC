
import 'package:intl/intl.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/table/cubit/state.dart';
import 'package:food_project/shared/network/local/local.dart';

class TableCubit extends Cubit<TableStates> {

  TableCubit() : super(TableStateInitial());

  static TableCubit get(context) => BlocProvider.of(context);

  List tableReserve = [];
  List tableReserveId = [];
  var auth = FirebaseAuth.instance.currentUser;
  String error;
  List oldTables = [];
  bool canRes = true ;

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

  int currentIndex1 = 0;

  int currentIndex2 = 0;

  changeIndex1(index) {
    currentIndex1 = index;
    emit(TimeStateIndex());
  }

  changeIndex2(index) {
    currentIndex2 = index;
    emit(TimeStateIndex());
  }



  reserveTable({tableId, time, number, phone, date}) async {
    FirebaseFirestore.instance.collection('Tables').get().then((value) async {
      print('---1');
      for (var doc in value.docs) {
        oldTables.add(doc.data());
      }
      for (var i = 0 ; i< oldTables.length ; i++) {
        if (oldTables[i]['ReserveDate'] == date.toString()) {
          if (oldTables[i]['TableId'] == tableId) {
            if (oldTables[i]['UserTableTime'] == time) {
              emit(AddTableStateError('Table OR Time is Taken .. please Change Table No. or Time'));
              canRes = false ;

            }
            else {
              canRes = true ;
            }
          }
          else {
            canRes = true ;
          }
        }
        else {
          canRes = true ;
        }
      }
    }).then((value) async{
      print('------2');
      if(canRes == true ){
        print('Reserve Date !=');
        emit(AddTableStateLoading());
        await FirebaseFirestore.instance.collection('Tables').add({
          'ReserveDate': '${date.toString()}',
          'UserTableTime': '${time.toString()}',
          'NumberPeople': '${number.toString()}',
          'TableId': '${tableId.toString()}',
          'UserPhone': '${phone.toString()}',
          'UserFullName': '${auth.displayName.toString()}',
          'UserToken': '${getUserToken().toString()}',
          'UserID': '${auth.uid.toString()}',
          'CanCancel': 'true',
        }).then((value) async {
          emit(AddTableStateSuccess());
        }).catchError((e) {
          emit(AddTableStateError(e.toString()));
        });
      }
    });
  }

  showReserve() {
    emit(ShowTableStateLoading());
    FirebaseFirestore.instance.collection('Tables').get().then((value) {
      emit(ShowTableStateSuccess());
      print('$value');

      for (var doc in value.docs) {
        if (doc['UserID'] == auth.uid.toString()) {
          tableReserve.add(doc.data());
        }
      }

      for (var doc in value.docs) {
        if (doc['UserID'] == auth.uid.toString()) {
          tableReserveId.add(doc.id);
        }
      }

      print('========$tableReserveId');
    }).catchError((e) {
      emit(ShowTableStateError(e));
    });
  }

  Future<void> deleteReserve({documentId,index}) async {
    return await FirebaseFirestore.instance.collection('Tables')
        .doc(documentId[index].toString())
        .delete();
  }

}


//
// reserveTable({tableId, time, number, phone, date}) async {
//   FirebaseFirestore.instance.collection('Tables').get().then((value) async {
//     print('$value');
//     for (var doc in value.docs) {
//       oldTables.add(doc.data());
//     }
//   }).then((value) async{
//     for (var i = 0 ; i<= oldTables.length ; i++) {
//       if (oldTables[i]['ReserveDate'] == date.toString()) {
//         if (oldTables[i]['TableId'] == tableId) {
//           if (oldTables[i]['UserTableTime'] == time) {
//             error =
//             'Table OR Time is Taken .. please Change Table No. or Time';
//             emit(AddTableStateError('Table OR Time is Taken .. please Change Table No. or Time'));
//           }
//           else {
//             print('User Table Time !=');
//             emit(AddTableStateLoading());
//             await FirebaseFirestore.instance.collection('Tables').add({
//               'ReserveDate': '${date.toString()}',
//               'UserTableTime': '${time.toString()}',
//               'NumberPeople': '${number.toString()}',
//               'TableId': '${tableId.toString()}',
//               'UserPhone': '${phone.toString()}',
//               'UserFullName': '${auth.displayName.toString()}',
//               'UserToken': '${auth.uid.toString()}',
//               'UserID': '${getUserToken().toString()}',
//               'CanCancel': 'true',
//             }).then((value) async {
//               emit(AddTableStateSuccess());
//               canRes = false ;
//             }).catchError((e) {
//               emit(AddTableStateError(e.toString()));
//             });
//           }
//         }
//         else {
//           print('Table Id !=');
//           emit(AddTableStateLoading());
//           await FirebaseFirestore.instance.collection('Tables').add({
//             'ReserveDate': '${date.toString()}',
//             'UserTableTime': '${time.toString()}',
//             'NumberPeople': '${number.toString()}',
//             'TableId': '${tableId.toString()}',
//             'UserPhone': '${phone.toString()}',
//             'UserFullName': '${auth.displayName.toString()}',
//             'UserToken': '${auth.uid.toString()}',
//             'UserID': '${getUserToken().toString()}',
//             'CanCancel': 'true',
//           }).then((value) async {
//             emit(AddTableStateSuccess());
//             canRes = false ;
//           }).catchError((e) {
//             emit(AddTableStateError(e.toString()));
//           });
//         }
//       }
//     }
//   }).then((value) async {
//     if(canRes == true ){
//       print('Reserve Date !=');
//       emit(AddTableStateLoading());
//       await FirebaseFirestore.instance.collection('Tables').add({
//         'ReserveDate': '${date.toString()}',
//         'UserTableTime': '${time.toString()}',
//         'NumberPeople': '${number.toString()}',
//         'TableId': '${tableId.toString()}',
//         'UserPhone': '${phone.toString()}',
//         'UserFullName': '${auth.displayName.toString()}',
//         'UserToken': '${auth.uid.toString()}',
//         'UserID': '${getUserToken().toString()}',
//         'CanCancel': 'true',
//       }).then((value) async {
//         emit(AddTableStateSuccess());
//         canRes = false ;
//       }).catchError((e) {
//         emit(AddTableStateError(e.toString()));
//       });
//     }
//   });
// }