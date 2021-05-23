import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/home_screen.dart';
import 'package:food_project/admin/screens/orders/cubit/cubit.dart';
import 'package:food_project/admin/screens/orders/cubit/state.dart';
import 'package:food_project/shared/componentes/components.dart';

class AdminOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Orders'),
        actions: [
          SizedBox(width: 10,),
          InkWell(
            onTap: (){navigateAndFinish(context, AdminHomeScreen());},
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home,color: Colors.white,),
                  Text('HOME'),
                ],
              ),
            ),
          ),
          SizedBox(width: 10,),
          InkWell(
            onTap: (){navigateAndFinish(context, AdminOrderScreen());},
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh,color: Colors.white,),
                  Text('Refresh'),
                ],
              ),
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: BlocProvider(
        create: (context)=> ShowAdminOrderCubit()..showOrdersUser(),
        child: BlocConsumer<ShowAdminOrderCubit,ShowAdminOrderStates>(
          listener: (context,state){},
          builder: (context,state){
            List adminOrderMeals = ShowAdminOrderCubit.get(context).adminOrderMeals;
            List adminOrderMealsId = ShowAdminOrderCubit.get(context).adminOrderMealsId;
            return ConditionalBuilder(
              condition: adminOrderMeals.length != 0 ,
              builder: (context)=> ConditionalBuilder(
                condition: state is ShowAdminOrderStateLoading ,
                fallback: (context)=> ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Name: ${adminOrderMeals[index]['UserOrder']}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Date/Time: ${adminOrderMeals[index]['DateAndTime'].toString()}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Total Price: ${adminOrderMeals[index]['UserTotalPrice']}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'User Name: ${adminOrderMeals[index]['UserFullName'].toString()}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'User Area: ${adminOrderMeals[index]['UserArea']}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'User Street Name: ${adminOrderMeals[index]['UserStreetName']}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Use Building Number: ${adminOrderMeals[index]['UserBuildingNumber']}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'User Floor Number: ${adminOrderMeals[index]['UserFloorNumber']}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'User Apartment Number: ${adminOrderMeals[index]['UserApartmentNumber']}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'User Note: ${adminOrderMeals[index]['UserNote']}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    defaultButton(function: (){
                                      ShowAdminOrderCubit.get(context).editOrderCancel(adminOrderMealsId,index);
                                      //tell user message by user id meal is Accepted
                                      ShowAdminOrderCubit.get(context).sendConfirm(token: adminOrderMeals[index]['UserToken'],);
                                    }, text: 'Accept',width: 95,toUpper: false),

                                    defaultButton(function: (){
                                      //tell user message by user id meal is
                                      // finished and delivery man take it to him soon
                                      ShowAdminOrderCubit.get(context).sendFinish(token: adminOrderMeals[index]['UserToken'],);
                                    }, text: 'Finish',background: Colors.green,width: 95,toUpper: false),

                                    defaultButton(function: (){
                                      ShowAdminOrderCubit.get(context).deleteMeal(documentId:adminOrderMealsId,index: index);
                                    }, text: 'Delete',background: Colors.red,width: 95,toUpper: false),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 20.0,
                  ),
                  itemCount: adminOrderMeals.length,
                ),
                builder: (context)=>Center(child: CircularProgressIndicator()),
              ),
              fallback: (context)=> Center(child: Text('No Orders Yet...'),),
            );
          },
        )
      ),
    );
  }
}
