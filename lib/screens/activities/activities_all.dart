import 'package:flutter/material.dart';

import '../Drawer.dart';
import '../header.dart';

class ActivitiesAllPage extends StatefulWidget {
  const ActivitiesAllPage({key});

  @override
  State<ActivitiesAllPage> createState() => _ActivitiesAllPageState();
}

class _ActivitiesAllPageState extends State<ActivitiesAllPage> {
  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
        child: Container(
          width: sWidth,
          // height: sHeight,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Adventure & Water Sports In Goa",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      places(sHeight, sWidth),
                      places(sHeight, sWidth),
                      places(sHeight, sWidth),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      places(sHeight, sWidth),
                      places(sHeight, sWidth),
                      places(sHeight, sWidth),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget places(sHeight, sWidth) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
      width: sWidth * 0.23,
      height: sHeight * 0.65,
      child: Column(
        children: [
          images(sHeight, sWidth),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "2 hours",
                  style: TextStyle(color: Colors.grey.shade800,fontSize: 15,fontWeight: FontWeight.w400),
                ),
                Spacer(),
                Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 5, 152, 81),
                ),
                Text(
                  "4.7",
                  style: TextStyle(
                      color: Color.fromARGB(255, 5, 152, 81),
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "(155)",
                   style: TextStyle(color: Colors.grey.shade800,fontSize: 15,fontWeight: FontWeight.w400),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget images(sHeight, sWidth) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(16)),
      width: sWidth * 0.23,
      height: sHeight * 0.45,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5.0,
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(10), // Adjust the radius as needed
            child: Image.network(
              "https://media1.thrillophilia.com/filestore/xkdrj0ytpe6vh0212p6k8k1e4q5c_two-people-riding-a-jet-ski-1430676---Copy_B7D73AF0-0845-4A0F-81696433CBA5F5B1_1c2855bb-8136-4185-b44a6944ee1f12a0.jpg",
              scale: 5.0,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          )),
    );
  }
}
 // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.star,
            //         size: 18,
            //         color: Colors.orangeAccent,
            //       ),
            //       Icon(
            //         Icons.star,
            //         size: 18,
            //         color: Colors.orangeAccent,
            //       ),
            //       Icon(
            //         Icons.star,
            //         size: 18,
            //         color: Colors.orangeAccent,
            //       ),
            //       Icon(
            //         Icons.star,
            //         size: 18,
            //         color: Colors.orangeAccent,
            //       ),
            //       Icon(
            //         Icons.star,
            //         size: 18,
            //         color: Colors.grey,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "155 Ratings",
            //         style: TextStyle(fontWeight: FontWeight.w200),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     "Water Sports in GOA",
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       Text(
            //         "₹ 1599",
            //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         "per adult",
            //         style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            //   child: Container(
            //     width: sWidth * 0.14,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => ActivitiesAllPage()));
            //       },
            //       style: ElevatedButton.styleFrom(
            //         primary: Color.fromARGB(255, 244, 122, 0), //
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //       ),
            //       child: Text("Book Now"),
            //     ),
            //   ),
            // ),