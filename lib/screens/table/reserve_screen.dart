import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:food_project/admin/screens/push_notifications/cubit/cubit.dart';
import 'package:food_project/admin/screens/push_notifications/cubit/states.dart';
import 'package:food_project/screens/table/cubit/cubit.dart';
import 'package:food_project/screens/table/cubit/state.dart';
import 'package:food_project/screens/table/tables_screen_.dart';
import 'package:food_project/shared/colors/colors.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:intl/intl.dart';

class ReserveScreen extends StatefulWidget {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  _ReserveScreenState createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  final String formatted = ReserveScreen.formatter.format(ReserveScreen.now);

  var currentHour = new DateTime(ReserveScreen.now.hour);

  var currentMinute = new DateTime(ReserveScreen.now.minute);

  var currentTime = new DateTime(
      ReserveScreen.now.year,
      ReserveScreen.now.month,
      ReserveScreen.now.day,
      ReserveScreen.now.hour,
      ReserveScreen.now.minute,
      ReserveScreen.now.second
  );

  TabController timeController;

  var phoneController = TextEditingController();

  String tableValue = 'Table1';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> NotificationCubit(),
      child: BlocConsumer<NotificationCubit,NotificationsStates>(
        listener: (context,state){},
        builder: (context,state){
          return  Scaffold(
            body: BlocConsumer<TableCubit, TableStates>(
              listener: (context, state) {
                if (state is AddTableStateLoading) {
                  print('AddTableStateLoading');
                }
                if (state is AddTableStateSuccess) {
                  print('AddTableStateSuccess');
                  showToast(text: 'successfully', error: false);
                  NotificationCubit.get(context).sendAdminTables();
                  return navigateAndFinish(
                    context,
                    TablesScreen(),
                  );
                }
                if (state is AddTableStateError) {
                  print('AddTableStateError');
                  return buildProgress(
                    context: context,
                    text: "${state.error.toString()}",
                    error: true ,
                  );
                }
              },
              builder: (context, state) {
                var currentIndexTime = TableCubit.get(context).currentIndex1;
                var currentIndexPeople = TableCubit.get(context).currentIndex2;
                return ListView(
                  children: [
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today :',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$formatted',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Time',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SnakeNavigationBar.color(
                          snakeViewColor: defaultColor,
                          selectedItemColor: Colors.white,
                          unselectedItemColor: Colors.grey,
                          showSelectedLabels: true,
                          showUnselectedLabels: true,
                          height: 100,
                          selectedLabelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          currentIndex: currentIndexTime,
                          onTap: (index) {
                            TableCubit.get(context).changeIndex1(index);
                          },
                          items: [
                            BottomNavigationBarItem(
                                icon: Text(
                                  '1-3 PM',
                                  style: TextStyle(color: Colors.black),
                                ),
                                label: 'Time'),
                            BottomNavigationBarItem(
                                icon: Text('3-5 PM'), label: 'Time'),
                            BottomNavigationBarItem(
                                icon: Text('5-7 PM'), label: 'Time'),
                            BottomNavigationBarItem(
                                icon: Text('7-9 PM'), label: 'Time'),
                            BottomNavigationBarItem(
                                icon: Text('9-11 PM'))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Number Of People',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        // SizedBox(height: 20,),
                        // // Row(
                        // //   crossAxisAlignment: CrossAxisAlignment.center,
                        // //   mainAxisAlignment: MainAxisAlignment.center,
                        // //   children: [
                        // //     SizedBox(width: 3,),
                        // //     FlatButton(onPressed: (){} , child: Text('1 to 3'),),
                        // //     SizedBox(width: 3,),
                        // //     FlatButton(onPressed: (){} , child: Text('3 to 5'),),
                        // //     SizedBox(width: 3,),
                        // //     FlatButton(onPressed: (){} , child: Text('5 to 7'),),
                        // //     SizedBox(width: 3,),
                        // //     FlatButton(onPressed: (){} , child: Text('7 to 9'),),
                        // //   ],
                        // // ),
                        // DefaultTabController(
                        //   length: 5,
                        //   initialIndex: 0,
                        //   child: Column(
                        //     children: <Widget>[
                        //       ButtonsTabBar(
                        //         backgroundColor: Colors.blue[600],
                        //         unselectedBackgroundColor: Colors.white,
                        //         labelStyle:
                        //         TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        //         unselectedLabelStyle: TextStyle(
                        //             color: Colors.blue[600], fontWeight: FontWeight.bold),
                        //         borderWidth: 1,
                        //         unselectedBorderColor: Colors.blue[600],
                        //         radius: 100,
                        //         tabs: [
                        //           Tab(text: "1 To 3 PM",),
                        //           Tab(text: "3 To 5 PM",),
                        //           Tab(text: "5 To 7 PM",),
                        //           Tab(text: "7 To 9 PM",),
                        //           Tab(text: "9 To 11 PM",),
                        //         ],
                        //         controller: timeController,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),

                        SnakeNavigationBar.color(
                          snakeViewColor: defaultColor,
                          selectedItemColor: Colors.white,
                          unselectedItemColor: Colors.grey,
                          showSelectedLabels: true,
                          showUnselectedLabels: true,
                          selectedLabelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          currentIndex: currentIndexPeople,
                          onTap: (index) {
                            TableCubit.get(context).changeIndex2(index);
                          },
                          items: [
                            BottomNavigationBarItem(
                                icon: Text(
                                  '1-2',
                                  style: TextStyle(color: Colors.black),
                                ),
                                label: 'People'),
                            BottomNavigationBarItem(
                                icon: Text('3-4'), label: 'People'),
                            BottomNavigationBarItem(
                                icon: Text('5-6'), label: 'People'),
                            BottomNavigationBarItem(
                                icon: Text('7-8'), label: 'People'),
                            BottomNavigationBarItem(
                                icon: Text('MORE'), label: 'People')
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Center(
                        child: Text(
                          'Choose Your Table',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(height: 5,),
                    Center(
                      child: DropdownButton<String>(
                        hint: Text("Tables"),
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        value: tableValue,
                        onChanged: (String newValue) {
                          setState(() {
                            tableValue = newValue;
                          });
                        },
                        items: <String>[
                          'Table1',
                          'Table2',
                          'Table3',
                          'Table4',
                          'Table5',
                          'Table6'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16),
                      child: defaultTextBox(
                        type: TextInputType.phone,
                        title: 'Phone Number',
                        hint: '01027826885',
                        controller: phoneController,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,right: 25),
                      child: defaultButton(
                          function: (){
                            if(phoneController.text.isEmpty)
                            {
                              showToast(text: 'please enter your phone number', error:  true );
                              return ;
                            }
                            TableCubit.get(context).reserveTable(
                              date: '$formatted',
                              time: '${TableCubit.get(context).times[currentIndexTime].toString()}',
                              number: '${TableCubit.get(context).people[currentIndexPeople].toString()}',
                              tableId: '${tableValue.toString()}',
                              phone: '${phoneController.text}',
                            );
                          },
                          text: 'Reserve Table',
                          radius: 12
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                );
              },
            ),
          );
        },

      ),
    );
  }
}

