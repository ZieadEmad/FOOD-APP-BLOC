import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/screens/orders/cubit/state.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/cart/cart_screen.dart';
import 'package:food_project/screens/cart/cubit/cubit.dart';
import 'package:food_project/screens/cart/cubit/states.dart';
import 'package:food_project/screens/favorites/cubit/cubit.dart';
import 'package:food_project/screens/favorites/cubit/states.dart';
import 'package:food_project/screens/favorites/favorites_screen.dart';
import 'package:food_project/screens/orders/cubit/cubit.dart';
import 'package:food_project/screens/orders/cubit/states.dart';
import 'package:food_project/screens/orders/orders_screen.dart';
import 'package:food_project/screens/profile/update_profile/update_user_profile_screen.dart';
import 'package:food_project/screens/welcome/welcome_screen.dart';
import 'package:food_project/shared/colors/colors.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:food_project/shared/network/local/local.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    String userName = FirebaseAuth.instance.currentUser.displayName;
    String userEmail = FirebaseAuth.instance.currentUser.email;
    String userPhoto =  FirebaseAuth.instance.currentUser.photoURL;
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CartCubit()..showCart(),
          ),

          BlocProvider(
            create: (context) => FavoritesCubit()..showFavorites(),
          ),
        ],
        child: BlocProvider(
          create: (context)=> ShowOrderCubit()..showOrdersUser(),
          child: BlocConsumer<ShowOrderCubit,ShowOrderStates>(
            listener: (context,state){},
            builder: (context,state){
              List userOrders = ShowOrderCubit.get(context).orderMeals ;
              return BlocConsumer<FavoritesCubit,FavoritesStates>(
                listener: (context,state){},
                builder: (context,state){
                  List favoritesItems = FavoritesCubit.get(context).favoritesMeals;
                  return ListView(
                    children: [
                      BlocConsumer<CartCubit,CartStates>(
                        listener: (context,state){},
                        builder: (context,state){
                          List cartItems = CartCubit.get(context).cartMeals;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(60.0)),
                                  border: Border.all(
                                    color: defaultColor,
                                    width: 2.0,
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    '${userPhoto.toString()}' ,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${userName.toString()}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),


                                ],
                              ),

                              SizedBox(
                                height: 15,
                              ),
                              Text('${userEmail.toString()}',style: TextStyle(fontSize: 20),),

                              SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        OMIcons.borderColor,
                                        color: defaultColor,
                                        size: 30,
                                      ),
                                      SizedBox(width: 10,),
                                      Text('Update Your Profile',style: TextStyle(fontSize: 20),),
                                    ],
                                  ),
                                  onTap: () {
                                    navigateAndFinish(context, UpdateProfileScreen());
                                    //print(profile.toString());
                                  },
                                ),
                              ),

                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Row(
                                  children: [
                                    buildProfileItem(
                                      function: () {navigateTo(context, UserOrdersScreen());},
                                      title: 'My Orders',
                                      shape: Text(
                                        '${userOrders.length}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    buildProfileItem(
                                      function: () {},
                                      title: 'Restaurant Website',
                                      shape: Image.asset(
                                        'assets/images/network.png',
                                        color: Colors.white,
                                        fit: BoxFit.cover,
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                ),
                                child: Row(
                                  children: [
                                    buildProfileItem(
                                      function: () {},
                                      title: 'My Cart',
                                      shape: Text(
                                        '${cartItems.length}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    buildProfileItem(
                                      function: () {},
                                      title: 'My Favourites',
                                      shape: Text(
                                          '${favoritesItems.length}',
                                          style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white
                                          ),
                                    ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50,right: 50,bottom: 20),
                                child: defaultButton(
                                    function: (){
                                      removeToken();
                                      navigateAndFinish(context, WelcomeScreen());
                                    },
                                    text: 'logout',
                                    background: Colors.red,
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),

    );
  }
}

