import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/admin/home_screen.dart';
import 'package:food_project/admin/screens/tables/cubit/cubit.dart';
import 'package:food_project/admin/screens/tables/cubit/states.dart';
import 'package:food_project/screens/table/tables_screen_.dart';
import 'package:food_project/shared/componentes/components.dart';

class AdminTablesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests'),
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
            onTap: (){navigateAndFinish(context, AdminTablesScreen());},
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
          create: (context)=> ShowAdminTableCubit()..showTablesAdmin(),
          child: BlocConsumer<ShowAdminTableCubit,ShowAdminTableStates>(
            listener: (context,state){
              if (state is NotificationsStatSuccess ){
                return showToast(text: 'Order is Accepted', error: false);
              }

              if (state is MealDeleteStateSuccess ){
                return showToast(text: 'Meals is Deleted', error: true);
              }
            },
            builder: (context,state){
              List adminTables = ShowAdminTableCubit.get(context).adminTables;
              List adminTablesId = ShowAdminTableCubit.get(context).adminTablesId;
              return ConditionalBuilder(
                condition: adminTables.length != 0 ,
                builder: (context)=> ConditionalBuilder(
                  condition: state is ShowAdminTableStateLoading ,
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
                                  'Date :  ${adminTables[index]['ReserveDate']}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Time :  ${adminTables[index]['UserTableTime'].toString()}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Number of people :  ${adminTables[index]['NumberPeople']}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Table Number :  ${adminTables[index]['TableId']}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Customer Name :  ${adminTables[index]['UserFullName']}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Phone Number :  ${adminTables[index]['UserPhone']}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    defaultButton(function: (){
                                      ShowAdminTableCubit.get(context).editTableCancel(adminTablesId,index);
                                      //tell user message by user id meal is Accepted
                                      ShowAdminTableCubit.get(context).sendConfirm(token:'${adminTables[index]['UserToken'].toString()}');
                                    }, text: 'Accept',background: Colors.green,width: 95,toUpper: false),

                                    // defaultButton(function: (){
                                    //   //tell user message by user id meal is
                                    //   // finished and delivery man take it to him soon
                                    //   ShowAdminOrderCubit.get(context).sendFinish(token: adminOrderMeals[index]['UserToken'],);
                                    // }, text: 'Finish',background: Colors.green,width: 95,toUpper: false),

                                    defaultButton(function: (){
                                      ShowAdminTableCubit.get(context).deleteMeal(documentId:adminTablesId,index: index);
                                      navigateAndFinish(context, AdminTablesScreen());
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
                    itemCount: adminTables.length,
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