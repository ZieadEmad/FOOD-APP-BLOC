

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/screens/favorites/cubit/states.dart';
import 'package:food_project/shared/network/local/local.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(AddFavoritesStateInitial());
  static FavoritesCubit get(context) => BlocProvider.of(context);

  List favoritesMeals = [];
  List favoritesId = [];

  addFavorites(String id){
    emit(AddFavoritesStateLoading());
    FirebaseFirestore.instance.collection('Meals')
        .get().then((value){
      for(var doc in value.docs ) {
        if(id == doc.id){
          var id =doc.id ;
          var data = doc.data();
          Firestore.instance.collection('Favorites').add({
            'MealTitle': '${data['MealTitle']}',
            'MealDescription': '${data['MealDescription']}}',
            'MealPrice': '${data['MealPrice']}',
            'MealCategory': '${data['MealCategory']}',
            'imageLink':'${data['imageLink']}',
            'UserId' : '${getToken()}',
            'MealId' : '$id',
          }).then((value) async{
            emit(AddFavoritesStateSuccess());
          }).catchError((e){
            emit(AddFavoritesStateError(e.toString()));
          });
        }
      }
    }).catchError((e){
      emit(AddFavoritesStateError(e));
    });
  }

  showFavorites(){
    emit(ShowFavoritesStateLoading());
    FirebaseFirestore.instance.collection('Favorites').get().then((value){
      emit(ShowFavoritesStateSuccess());
      print('$value');
      favoritesMeals=value.docs;
      for(var doc in value.docs ) {
        favoritesId.add(doc.id);
      }
      print('========$favoritesId');
    }).catchError((e){
      emit(ShowFavoritesStateError(e));
    });
  }


  Future<void> deleteMeal({documentId,index}) async {
    return await FirebaseFirestore.instance.collection('Favorites')
        .doc(documentId[index].toString())
        .delete();
  }


  }



