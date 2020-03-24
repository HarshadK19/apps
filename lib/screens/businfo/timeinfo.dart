import 'package:flutter/material.dart';

class TimeInfo extends StatelessWidget {
  TimeInfo({
    @required this.routenum,
    this.stop,
    this.timeto,
    this.timefrom,
    this.abv_from,
    this.abv_to,
    /*this.from, this.to, this.via*/
  });
  final routenum;
  final stop;
  final timeto;
  final timefrom;
  final abv_from;
  final abv_to;
 List<DataRow> getItems() {
    final dataRows=<DataRow>[];
    for (int i = 0; i < timeto.length; i ++)
      for (int j = 0; j < timefrom.length; j ++)
        dataRows.add(DataRow(
            cells: [
              DataCell(Text(timeto[i])),
              DataCell(Text(timefrom[j])),
            ]
        ));
      return dataRows;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(55.0),
              child: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                  indicatorWeight: 0,
                  //labelStyle: TextStyle(fontSize: 8),
                    unselectedLabelColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.redAccent,
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.redAccent, width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Weekdays"), 
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.redAccent, width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Saturday"),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.redAccent, width: 1)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Sunday&Public Holiday"),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            body: TabBarView(children: [
              //Icon(Icons.games),
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
                            DataColumn(
                              label: Text(abv_from + " - " + abv_to),
                            ),
                          ],
                          rows: getItems(),
                          sortColumnIndex: 0,
                          sortAscending: true,
                        ),
                      ]
                    ),
                  ),
                ),
              Icon(Icons.beach_access),
              Icon(Icons.cloud_download),
            ]),
          )),
    );
  }
}