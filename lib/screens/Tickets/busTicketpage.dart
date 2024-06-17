import 'package:flutter/material.dart';
import 'package:trip/screens/header.dart';

import '../../api_services/bus apis/print_ticket_api.dart';
import '../constant.dart';

class BusTicketPage extends StatefulWidget {
  Tickectobj ticket;
   BusTicketPage({this.ticket,
    key});

  @override
  State<BusTicketPage> createState() => _BusTicketPageState();
}

class _BusTicketPageState extends State<BusTicketPage> {
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