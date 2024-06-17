import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_services/holiday_packages/get_all_packages_api.dart';

import '../holiday_Packages/holiday_booking_page.dart';

Widget PackageRow(swidth, sheight, List<Package> packageList) {
  return Center(
    child: Container(
      width: swidth / 1.1,
      // height: 325.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Best Seller Destination',
                    style: GoogleFonts.rajdhani(
                        fontSize: 25, fontWeight: FontWeight.w700)),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, right: 10),
                  child: Row(
                    children: [
                      // Container(
                      //     decoration: BoxDecoration(
                      //         border: Border.all(
                      //           width: 1, color: Colors.grey[200],
                      //           //style: BorderStyle.solid
                      //         ),
                      //         borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(20),
                      //             bottomLeft: Radius.circular(20))),
                      //     child: IconButton(
                      //       icon: Icon(
                      //         Icons.arrow_back_ios_outlined,
                      //         color: Colors.blue,
                      //         size: 15,
                      //       ),
                      //       onPressed: () {},
                      //     )),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       border: Border.all(
                      //         width: 1, color: Colors.grey[200],
                      //         //style: BorderStyle.solid
                      //       ),
                      //       borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(20),
                      //           topRight: Radius.circular(20))),
                      //   child: IconButton(
                      //     icon: Icon(
                      //       Icons.arrow_forward_ios,
                      //       color: Colors.blue,
                      //       size: 15,
                      //     ),
                      //     onPressed: () {},
                      //   ),
                      // ),
                    ],
                  ),
                )
              ],
            ),
            // SizedBox(height: 5.0),
            Text('Book Now',
                style: GoogleFonts.rajdhani(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey)),
            SizedBox(height: 10.0),
            listPackage(packageList),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    ),
  );
}

Widget listPackage(List<Package> packageList) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 0),
    // height: 200,
    color: Colors.white,
    child: GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        childAspectRatio: 7 / 9.5,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 0.0,
      ),
      itemCount: packageList.length,
      itemBuilder: (context, index) {
        final packageName = packageList[index].name;
        final packageprice = packageList[index].packagePrice;
        final id = packageList[index].pId;
        final image = packageList[index].photoVideo;
        return GestureDetector(
          onTap: () {
            print("id:$id");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HolidayBookingPage(
                          pid: id,
                        )));
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //  builder: (context) => holidayPackageDetailPage(pid: id,)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 150,
                width: 150, // Width of each item
                // color: Color.fromARGB(255, 244, 54, 225),
                child: Image.network(
                  image ?? 'https://wallpapercave.com/wp/wp4054006.jpg',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                packageName,
                style: GoogleFonts.rajdhani(
                    fontSize: 15, fontWeight: FontWeight.w800),
              ),SizedBox(
                height: 1,
              ),
              Text(
                'Starting at ',
                style: GoogleFonts.rajdhani(
                    fontSize: 12, fontWeight: FontWeight.w600),
              ),SizedBox(
                height: 1,
              ),
              Row(
                children: [
                  Text(
                    '₹ $packageprice ',
                    style: GoogleFonts.rajdhani(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Per person',
                    style: GoogleFonts.rajdhani(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              
            ],
          ),
        );
      },
    ),
  );
}
