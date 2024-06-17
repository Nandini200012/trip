import 'package:flutter/material.dart';

import '../constant.dart';
import '../header.dart';

class ActivityTicketPage extends StatefulWidget {
  const ActivityTicketPage({key});

  @override
  State<ActivityTicketPage> createState() => _ActivityTicketPageState();
}

class _ActivityTicketPageState extends State<ActivityTicketPage> {
  @override
  Widget build(BuildContext context) {
   double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: swidth < 600
          ? AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
              title: Text(
                'Tour',
                style: blackB15,
              ),
            )
          : CustomAppBar(),
      body: Container(

        child: Card(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}