import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/api_services/activity/getactivity_listapi.dart';
import 'package:trip/screens/activities/activities_booking%20_page.dart';
import 'package:hover_animation/hover_animation.dart';
import '../../api_services/coupons/activity_coupon_api.dart';
import '../Drawer.dart';
import '../footer.dart';
import '../header.dart';

class AcitivitiesPage extends StatefulWidget {
  const AcitivitiesPage({key});

  @override
  State<AcitivitiesPage> createState() => _AcitivitiesPageState();
}

List<Datum> activitydata = [];
int datalength = 0;

class _AcitivitiesPageState extends State<AcitivitiesPage> {
  @override
  void initState() {
    super.initState();
    activitiesapi();
    // coupons();
  }

  activitiesapi() async {
    String res = await getActivitiesAPI();
    getActivitiesobj activityobj = getActivitiesobj.fromJson(jsonDecode(res));
    setState(() {
      activitydata = activityobj.data;
      print('data:$activitydata');
      datalength = activitydata.length;
      print('length:${activitydata.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var sHeight = size.height;
    var sWidth = size.width;

// Convert dimensions from cm to pixels
    final double containerWidthInCm = 15.0;
    final double containerHeightInCm = 20.0;
    final double containerWidthInPixels =
        containerWidthInCm * 20; // 1 cm = 37.7953 pixels
    final double containerHeightInPixels = containerHeightInCm * 20;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: sWidth < 600
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 40),
              backgroundColor: Color.fromARGB(255, 1, 21, 101),
              title: Text(
                "Activities",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            )
          : CustomAppBar(),
      drawer: sWidth < 600 ? drawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: sWidth,
              color: Colors.grey.shade100,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: sWidth,
                        height: sHeight * 0.45,
                        child: Image.network(
                          "https://media2.thrillophilia.com/images/photos/000/057/339/original/1527164695_Goa_Adventure_activities.jpg?w=1400&h=320&dpr=1.0",
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Image.asset(
                              'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png', // Replace with your default image asset path
                              fit: BoxFit.fill,
                            );
                          },
                        ),
                      ),
                    ),
                    // Container(
                    //   height: sHeight * 0.45,
                    //   width: sWidth,
                    //   color: Colors.blue,
                    //   child: Image.network(
                    //     "https://media2.thrillophilia.com/images/photos/000/057/339/original/1527164695_Goa_Adventure_activities.jpg?w=1400&h=320&dpr=1.0",
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Container(
                        width: sWidth,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 150),
                      child: Text(
                        "Activities",
                        style: GoogleFonts.rajdhani(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            // Add other text styles as needed
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150, top: 5),
                      child: Row(
                        children: [
                          Container(
                            height: 2.3, // Thickness of the line
                            width: 25 *
                                MediaQuery.of(context)
                                    .devicePixelRatio, // Width in logical pixels
                            color: Colors.blue,
                          ),
                          Container(
                            height: 2.3, // Thickness of the line
                            width: 880 *
                                MediaQuery.of(context)
                                    .devicePixelRatio, // Width in logical pixels
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 150),
                      child: SizedBox(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 30,
                            childAspectRatio: 95 / 128,
                          ),
                          itemBuilder: (context, index) {
                            Datum item = activitydata[index];
                            // return Container(
                            //   height: 150,
                            //   width: 200,
                            //   color: Colors.red,
                            // );
                            return places(item);
                          },
                          itemCount: datalength,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: sHeight * .1,
            ),
            buildFooter()
          ],
        ),
      ),
    );
  }

  ItemList(Datum item) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 100,
      height: 460,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 350,
              height: 220,
              decoration: BoxDecoration(
                // color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image.network(
                  item.image1,
                  scale: 5.0,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 3, top: 10),
              child: Text(
                item.packageName ?? "",
                style: GoogleFonts.rajdhani(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,

                    // Add other text styles as needed
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 2, bottom: 5),
              child: Text(
                "₹${int.parse(item.price) + 500}",
                // style: TextStyle(
                //   fontSize: 12,
                //   fontWeight: FontWeight.w600,
                //   color: Colors.grey,
                //   decoration: TextDecoration.lineThrough,
                // ),
                style: GoogleFonts.rajdhani(
                  textStyle: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    // Add other text styles as needed
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    "₹${item.price}",
                    style: GoogleFonts.rajdhani(
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        // Add other text styles as needed
                      ),
                    ),
                  ),
                  Text(
                    " Per adult",
                    style: GoogleFonts.rajdhani(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        // Add other text styles as needed
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                child: Container(
                  width: 200,
                  height: 30,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade800],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      // color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Text(
                    "Book Now",
                    style: GoogleFonts.rajdhani(
                      textStyle: TextStyle(
                        fontSize: 15, color: Colors.white,
                        fontWeight: FontWeight.bold,
                        // Add other text styles as needed
                      ),
                    ),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget places(Datum item) {
    return HoverAnimation(
      hoverBackgroundColor: Colors.transparent,
      hoverBorderRadius: BorderRadius.all(Radius.circular(0)),
      primaryColor: Colors.grey.shade100,
      hoverColor: Colors.grey.shade100,
      size: const Size(280, 375),
      border: Border.all(
        color: Colors.grey.shade100,
        width: 0.5,
      ),
      onTap: () {
        print("id:${item.packageId}");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ActivitiesBookingScreen(id: item.packageId)));
      },
      child: ItemList(item),
    );
  }

  Widget images(sHeight, sWidth, image) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(16)),
      width: sWidth * 0.232,
      height: sHeight * 0.314,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)), // Adjust the radius as needed
        child: Image.network(
          image,
          scale: 5.0,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
