import 'package:flutter/material.dart';
import 'package:trip/screens/footer.dart';

import '../../api_services/bus apis/confirm_booking_api.dart';
import '../header.dart';

class TicketSelectList extends StatefulWidget {
  const TicketSelectList({Key key});

  @override
  State<TicketSelectList> createState() => _TicketSelectListState();
}

class _TicketSelectListState extends State<TicketSelectList> {
  bool showFlightContainer = false;
  bool showBusContainer = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: sWidth < 600
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 40),
              backgroundColor: const Color.fromARGB(255, 1, 21, 101),
              title: Text(
                " ",
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          : const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height *
                  0.2, // Adjust the height as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  columnItem('Flights', Icons.flight, () {
                    setState(() {
                      showFlightContainer = !showFlightContainer;
                      showBusContainer = false;
                    });
                  }),
                  columnItem('Bus', Icons.directions_bus, () {
                    setState(() {
                      showBusContainer = !showBusContainer;
                      showFlightContainer = false;
                    });
                  }),
                  columnItem('Holiday Packages', Icons.card_giftcard, () {}),
                  columnItem('Activities', Icons.sports_soccer, () {}),
                ],
              ),
            ),
            Visibility(
              visible: showFlightContainer,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: sWidth * 0.7,
                        child: TextField(
                          
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(3)),
                            hintText: 'Search Flights',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: showBusContainer,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: sWidth * 0.7,
                      child: TextField(controller: searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3)),
                          hintText: 'Search Bus',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              print("search: ${searchController.text}");
                            ConfirmTicket(searchController.text,context);
      
      
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
         SizedBox(height: sHeight*0.5,),
          buildFooter(),
          ],
        ),
      ),
      // bottomSheet:  buildFooter(),
    );
  }
}



Future<void> ConfirmTicket(String text,context) async {
  String res = await ConfirmBookingAPI(text);
  if (res != 'failed') {
    if(res.contains('Error')){
showAlert(res,context);
    }else{
      showAlert("Confirmation Successfull...",context);
    }
   
    
  }
}

void showAlert(String message,context) {
  // Show alert box with the provided message
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirmation"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}


Widget columnItem(String label, IconData icon, Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 50), // Adjust the size as needed
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    ),
  );
}
