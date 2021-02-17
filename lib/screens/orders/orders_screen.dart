import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/orders/cubit/cubit.dart';
import 'package:food_project/screens/orders/cubit/states.dart';
import 'package:food_project/shared/componentes/components.dart';

class UserOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders',),
        actions: [
          SizedBox(width: 10,),
          InkWell(
            onTap: (){navigateAndFinish(context, LayoutScreen());},
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
        ],
      ),
      body: BlocProvider(
        create: (context)=> ShowOrderCubit()..showOrdersUser(),
        child: BlocConsumer<ShowOrderCubit,ShowOrderStates>(
          listener: (context,state){
            if (state is ShowOrderStateLoading) {
              print('ShowOrderStateLoading');
              return buildProgress(
                  context: context,
                  text: "please Wait until Show Your Orders.. "
              );
            }
            if (state is ShowOrderStateSuccess) {
              print('ShowOrderStateSuccess');
            }
            if (state is ShowOrderStateError) {
              print('ShowOrderStateError');
              Navigator.pop(context);
              return buildProgress(
                context: context,
                text: "${state.error.toString()}",
                error: true ,
              );
            }
          },
          builder: (context,state){
            List orderMeals = ShowOrderCubit.get(context).orderMeals;
            List orderMealsId = ShowOrderCubit.get(context).orderMealsId;
            return  ConditionalBuilder(
              condition: orderMeals.length != 0 ,
              builder: (context)=> ConditionalBuilder(
                condition: state is ShowOrderStateLoading ,
                fallback: (context)=> ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order Name: ${orderMeals[index]['UserOrder']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Date/Time: ${orderMeals[index]['DateAndTime'].toString()}',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Total Price: ${orderMeals[index]['UserTotalPrice']}',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
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
                  itemCount: orderMeals.length,
                ),
                builder: (context)=>Center(child: CircularProgressIndicator()),
              ),
              fallback: (context)=> Center(child: Text('No Orders Yet...'),),
            );
          },
        ),
      ),
    );
  }
}
