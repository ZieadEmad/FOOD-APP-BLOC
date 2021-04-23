import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_project/layout/layout_screen.dart';
import 'package:food_project/screens/table/cubit/cubit.dart';
import 'package:food_project/screens/table/cubit/state.dart';
import 'package:food_project/shared/componentes/components.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class TablesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          SizedBox(width: 10,),
          InkWell(
            onTap: (){navigateTo(context, LayoutScreen());},
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(OMIcons.home,color: Colors.white,),
                  Text('Home'),
                ],
              ),
            ),
          ),
          SizedBox(width: 20,),
        ],
      ),
      body: BlocProvider(
        create: (context)=> TableCubit()..showReserve(),
        child: BlocConsumer<TableCubit,TableStates>(
          listener: (context,state){},
          builder: (context,state){
            List tableReserve = TableCubit.get(context).tableReserve;
            List tableReserveId = TableCubit.get(context).tableReserveId;
            return ListView.separated(
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
                            'Date :  ${tableReserve[index]['ReserveDate']}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Time :  ${tableReserve[index]['UserTableTime'].toString()}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Number of people :  ${tableReserve[index]['NumberPeople']}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Table Number :  ${tableReserve[index]['TableId']}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Your Name :  ${tableReserve[index]['UserFullName']}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Phone Number :  ${tableReserve[index]['UserPhone']}',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if(tableReserve[index]['CanCancel']=='true')
                            Center(
                                child: defaultButton(
                                    function: (){},
                                    text: 'Cancel',background: Colors.red,width: 200),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10.0,
              ),
              itemCount: tableReserve.length,
            );
          },
        ),
      ),
    );
  }
}
