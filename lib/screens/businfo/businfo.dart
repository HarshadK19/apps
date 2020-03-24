import 'package:flutter/material.dart';

import 'package:app/screens/businfo/timeinfo.dart';

class BusInfo extends StatelessWidget {
  BusInfo({
    @required 
    this.routenum,
    this.stop,
    this.abv_to,
    this.abv_from,
    this.timeto,
    this.timefrom,
  });

  final routenum;
  final stop;
  final abv_to;
  final abv_from;
  final timeto;
  final timefrom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(routenum),
              backgroundColor: Color(0xFFBDBDBD),
              elevation: 3,
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.label, 
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Route Info"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Timetable"),
                    ),
                  ),
                ]
              ),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        DataTable(
                          columns: [
                            DataColumn(
                              label: Text(abv_to + " - " + abv_from),
                            ),
                          ],
                          rows: [
                            for(int i =0; i< stop.length; i ++)
                            DataRow(
                              cells: [
                                DataCell(Text(stop[i])),
                              ]
                            ),
                          ],
                          sortColumnIndex: 0,
                          sortAscending: true,
                        ),
                      ]
                    ),
                  ),
                ),
                TimeInfo(routenum: routenum, timeto: timeto, timefrom: timefrom, abv_from: abv_from, abv_to: abv_to,),
              ]),
            ),
        ),
    );
  }
}