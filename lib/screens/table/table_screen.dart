import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:food_project/screens/table/cubit/cubit.dart';
import 'package:food_project/screens/table/cubit/state.dart';
import 'package:food_project/shared/colors/colors.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:intl/intl.dart';

class TableScreen extends StatefulWidget {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  final String formatted = TableScreen.formatter.format(TableScreen.now);

  var currentHour = new DateTime(TableScreen.now.hour);

  var currentMinute = new DateTime(TableScreen.now.minute);

  var currentTime = new DateTime(
      TableScreen.now.year,
      TableScreen.now.month,
      TableScreen.now.day,
      TableScreen.now.hour,
      TableScreen.now.minute,
      TableScreen.now.second);

  TabController timeController;

  String tableValue = 'Table1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TableCubit, TableStates>(
        listener: (context, state) {},
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
                            fontSize: 30, fontWeight: FontWeight.bold),
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
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Row(
              //       children: [
              //         SizedBox(
              //           width: 5,
              //         ),
              //         Text(
              //           'Time',
              //           style: TextStyle(
              //               fontSize: 30, fontWeight: FontWeight.bold),
              //         ),
              //       ],
              //     ),
              //     // SizedBox(height: 20,),
              //     // // Row(
              //     // //   crossAxisAlignment: CrossAxisAlignment.center,
              //     // //   mainAxisAlignment: MainAxisAlignment.center,
              //     // //   children: [
              //     // //     SizedBox(width: 3,),
              //     // //     FlatButton(onPressed: (){} , child: Text('1 to 3'),),
              //     // //     SizedBox(width: 3,),
              //     // //     FlatButton(onPressed: (){} , child: Text('3 to 5'),),
              //     // //     SizedBox(width: 3,),
              //     // //     FlatButton(onPressed: (){} , child: Text('5 to 7'),),
              //     // //     SizedBox(width: 3,),
              //     // //     FlatButton(onPressed: (){} , child: Text('7 to 9'),),
              //     // //   ],
              //     // // ),
              //     // DefaultTabController(
              //     //   length: 5,
              //     //   initialIndex: 0,
              //     //   child: Column(
              //     //     children: <Widget>[
              //     //       ButtonsTabBar(
              //     //         backgroundColor: Colors.blue[600],
              //     //         unselectedBackgroundColor: Colors.white,
              //     //         labelStyle:
              //     //         TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              //     //         unselectedLabelStyle: TextStyle(
              //     //             color: Colors.blue[600], fontWeight: FontWeight.bold),
              //     //         borderWidth: 1,
              //     //         unselectedBorderColor: Colors.blue[600],
              //     //         radius: 100,
              //     //         tabs: [
              //     //           Tab(text: "1 To 3 PM",),
              //     //           Tab(text: "3 To 5 PM",),
              //     //           Tab(text: "5 To 7 PM",),
              //     //           Tab(text: "7 To 9 PM",),
              //     //           Tab(text: "9 To 11 PM",),
              //     //         ],
              //     //         controller: timeController,
              //     //       ),
              //     //     ],
              //     //   ),
              //     // ),
              //     SizedBox(
              //       height: 20,
              //     ),
              //
              //     FFNavigationBar(
              //       theme: FFNavigationBarTheme(
              //         barBackgroundColor: Colors.white,
              //         selectedItemBorderColor: Colors.green,
              //         selectedItemBackgroundColor: defaultColor,
              //         selectedItemIconColor: Colors.white,
              //         selectedItemLabelColor: Colors.black,
              //       ),
              //       selectedIndex: currentIndexTime,
              //       onSelectTab: (index) {
              //         TableCubit.get(context).changeIndex1(index);
              //       },
              //       items: [
              //         FFNavigationBarItem(
              //           iconData: Icons.looks_one,
              //           label: '1 To 3 PM',
              //         ),
              //         FFNavigationBarItem(
              //           iconData: Icons.looks_two,
              //           label: '3 To 5 PM',
              //         ),
              //         FFNavigationBarItem(
              //           iconData: Icons.looks_3,
              //           label: '5 To 7 PM',
              //         ),
              //         FFNavigationBarItem(
              //           iconData: Icons.looks_4,
              //           label: '7 To 9 PM',
              //         ),
              //         FFNavigationBarItem(
              //           iconData: Icons.looks_5,
              //           label: '9 To 11 PM',
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
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
                            fontSize: 30, fontWeight: FontWeight.bold),
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
                            fontSize: 30, fontWeight: FontWeight.bold),
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
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 5,),
              Center(
                child: DropdownButton<String>(
                  hint: Text("Tables"),
                  style: TextStyle(fontSize: 25, color: Colors.black),
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
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: defaultButton(
                    function: (){},
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
  }
}
// ListView(
//      physics: BouncingScrollPhysics(),
//      scrollDirection: Axis.horizontal,
//      children: [
//      Container(
//        width: 50,
//        decoration: BoxDecoration(
//        borderRadius: BorderRadius.circular(16),
//        ),
//      ),
//      ],
//    ),
