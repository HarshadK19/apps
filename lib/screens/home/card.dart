import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app/screens/businfo/businfo.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.routenum, this.from, this.to, this.via, this.stop, this.abv_to, this.abv_from, this.timeto, this.timefrom,});

  //final name;
  final routenum;
  final from;
  final to;
  final via;
  final stop;
  final abv_to;
  final abv_from;
  final timeto;
  final timefrom;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 25,
        margin: EdgeInsets.all(12),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusInfo(routenum: routenum, stop: stop, abv_to: abv_to, abv_from: abv_from, timeto: timeto, timefrom: timefrom,),
                )
            );
          },
          child: Container(
            
            padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            //Text(name),
            Text("Route Number :" +" " + routenum, style: GoogleFonts.baloo(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 15,
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'From : ',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '$from',
                    style: GoogleFonts.viga(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]
              ),
            ),
            Text("via" + " " + via , style: GoogleFonts.poppins(),
            ),
            RichText(
              text: TextSpan(
                text: 'To : ',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '$to',
                    style: GoogleFonts.viga(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]
              ),
            ),
            Text("(or Vice Versa)", style: GoogleFonts.montserrat()),
          ],
        ),
      ),
    ));
  }
}