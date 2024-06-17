import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/screens/header.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import '../../models/flight_ticketmodel.dart';
import '../constant.dart';

class FlightTicketPage extends StatelessWidget {
  final Flightticket ticket;

  FlightTicketPage({Key key, @required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: MediaQuery.of(context).size.width < 600
          ? AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: Colors.white,
              title: Text(
                'Tour',
                style: blackB15,
              ),
            )
          : CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 251, 251, 251),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Flight Booking Details", fontSize: 25),
                    SizedBox(height: 10),
                    _buildBookingDetailsSection(ticket),
                    SizedBox(height: 10),
                    _buildFlightDetailsSection(ticket),
                    SizedBox(height: 10),
                    _buildTravellerDetailsSection(ticket),
                    SizedBox(height: 10),
                    _buildPriceInfoSection(ticket),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {double fontSize = 20}) {
    return Text(
      title,
      style: GoogleFonts.rajdhani(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildBookingDetailsSection(Flightticket ticket) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Booking Details", fontSize: 20),
        Text("Booking ID: ${ticket.order.bookingId}"),
        Text("Amount: ${ticket.order.amount}"),
        Text(
          "Delivery Info: ${ticket.order.deliveryInfo.emails},${ticket.order.deliveryInfo.contacts}",
        ),
      ],
    );
  }

  Widget _buildFlightDetailsSection(Flightticket ticket) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Flight Details", fontSize: 20),
        for (var tripInfo in ticket.itemInfos.air.tripInfos) ...[
          _buildTripInfo(tripInfo),
        ],
      ],
    );
  }

  Widget _buildTripInfo(tripInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Routes: ${tripInfo.sI.length}"),
        for (var segment in tripInfo.sI) ...[
          _buildSegment(segment),
        ],
      ],
    );
  }

  Widget _buildSegment(SI segment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
                height: 25,
                width: 25,
                child: Image.asset(
                  'images/AirlinesLogo/${segment.fD.aI.code}.png',
                  fit: BoxFit.contain,
                )),
            Text(
              " ${segment.fD.aI.name}",
              style: GoogleFonts.rajdhani(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            kwidth30,
            _buildFlightInfo("Departure", segment.da,segment.dt,),
            kwidth10,
            kwidth10,
            Column(
              children: [
                Text("${segment.duration.toString()} min"),
                 Text("${segment.stops.toString()} stop"),
              ],
            ),
            kwidth10,
            kwidth30,
            _buildFlightInfo("Arrival", segment.aa,segment.at,),
            // _buildFlightInfo("Duration", segment.duration.toString()),
            // _buildFlightInfo("Stops", segment.stops.toString()),
          ],
        ),
      ],
    );
  }

  Widget _buildFlightInfo(String title, Aa value ,String timedate,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: GoogleFonts.rajdhani(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.blueGrey,
          ),
        ),
        Text(value.code),
        Text(value.city),
        Text(value.country),
        Text(value.terminal),
         Text(timedate),
      ],
    );
  }

  Widget _buildTravellerDetailsSection(Flightticket ticket) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Traveller Details", fontSize: 20),
        for (var travellerInfo in ticket.itemInfos.air.travellerInfos) ...[
          _buildTravellerInfo(travellerInfo),
        ],
      ],
    );
  }

  Widget _buildTravellerInfo(travellerInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Passenger Type: ${travellerInfo.pt}"),
        Text("Title: ${travellerInfo.ti}"),
        Text("First Name: ${travellerInfo.fN}"),
        Text("Last Name: ${travellerInfo.lN}"),
        // Text("Date of Birth: ${travellerInfo.dob}"),
        // Text("Nationality: ${travellerInfo.pNat}"),
      ],
    );
  }

  Widget _buildPriceInfoSection(Flightticket ticket) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Price Info", fontSize: 20),
        _buildPriceDetail("Total Fare Detail",
            "Taxes and Fees: ${ticket.itemInfos.air.totalPriceInfo.totalFareDetail.fC.taf}"),
        _buildPriceDetail("Total Fare Detail",
            "Total Fare: ${ticket.itemInfos.air.totalPriceInfo.totalFareDetail.fC.tf}"),
        _buildPriceDetail("Total Fare Detail",
            "Non-Refundable Fare: ${ticket.itemInfos.air.totalPriceInfo.totalFareDetail.fC.nf}"),
        _buildPriceDetail("Total Fare Detail",
            "Base Fare: ${ticket.itemInfos.air.totalPriceInfo.totalFareDetail.fC.bf}"),
        _buildPriceDetail("Tax and Fee Details",
            "Taxes and Fees - Taxes and Fees: ${ticket.itemInfos.air.totalPriceInfo.totalFareDetail.afC.taf.agst}"),
        _buildPriceDetail("Tax and Fee Details",
            "Taxes and Fees - Taxes and Fees Other: ${ticket.itemInfos.air.totalPriceInfo.totalFareDetail.afC.taf.ot}"),
        _buildPriceDetail("Tax and Fee Details",
            "Taxes and Fees - Taxes and Fees YQ: ${ticket.itemInfos.air.totalPriceInfo.totalFareDetail.afC.taf.yq}"),
      ],
    );
  }

  Widget _buildPriceDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(value),
      ],
    );
  }
}













// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:trip/screens/header.dart';

// import '../../api_services/flight/Booking Retrieve/booking_details.dart';
// import '../constant.dart';

// class FlightTicketPage extends StatefulWidget {
//   final BookingRetrieveobj ticket;
//   FlightTicketPage({Key key, this.ticket}) : super(key: key);

//   @override
//   State<FlightTicketPage> createState() => _FlightTicketPageState();
// }

// class _FlightTicketPageState extends State<FlightTicketPage> {
//   @override
//   Widget build(BuildContext context) {
//     double sheight = MediaQuery.of(context).size.height;
//     double swidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       appBar: swidth < 600
//           ? AppBar(
//               leading: IconButton(
//                 icon: Icon(Icons.arrow_back, color: Colors.black),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               backgroundColor: Colors.white,
//               title: Text(
//                 'Tour',
//                 style: blackB15,
//               ),
//             )
//           : CustomAppBar(),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: sheight*2,
//               width: swidth * 0.8,
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 251, 251, 251),
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Flight Booking Details",
//                         style: GoogleFonts.rajdhani(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         "Booking Details",
//                         style: GoogleFonts.rajdhani(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.blueGrey,
//                         ),
//                       ),
//                       Text("Booking ID: ${widget.ticket.order.bookingId}"),
//                       Text("Amount: ${widget.ticket.order.amount}"),
//                       Text(
//                           "Delivery Info: ${widget.ticket.order.deliveryInfo.emails},${widget.ticket.order.deliveryInfo.contacts}"),
//                       SizedBox(height: 10),
//                       Text(
//                         "Flight Details",
//                         style: GoogleFonts.rajdhani(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.blueGrey,
//                         ),
//                       ),
//                       Text(
//                           "Routes: ${widget.ticket.itemInfos.air.tripInfos.length}"),
//       // Displaying flight details for each trip info
//                       for (int i = 0;
//                           i < widget.ticket.itemInfos.air.tripInfos.length;
//                           i++)
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Route ${i + 1}"),
//                             for (int j = 0;
//                                 j <
//                                     widget.ticket.itemInfos.air.tripInfos[i].sI
//                                         .length;
//                                 j++)
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Segment ${j + 1}"),
//                                   // Text(
//                                   //     "Flight Code: ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].fD.aI.code}"),
//                                   Row(
//                                     children: [
//                                       Image.asset(
//                                           'images/AirlinesLogo/${widget.ticket.itemInfos.air.tripInfos[i].sI[j].fD.aI.code}.png'),
//                                       Text(
//                                         " ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].fD.aI.name}",
//                                         style: GoogleFonts.rajdhani(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       Column(
//                                         children: [
//                                           Text(
//                                             "Departure ",
//                                             style: GoogleFonts.rajdhani(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w700,
//                                               color: Colors.blueGrey,
//                                             ),
//                                           ),
//                                           Text(
//                                               " ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].da.cityCode}"),
//                                           Text(
//                                               " ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].da.city}"),
//                                           Text(
//                                               " ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].da.country} (${widget.ticket.itemInfos.air.tripInfos[i].sI[j].da.countryCode})"),
//                                           Text(
//                                               " ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].dt}"),
//                                         ],
//                                       ),
//                                       Column(
//                                         children: [
//                                           Text(
//                                               "Duration: ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].duration}"),
//                                           Text(
//                                               "stop: ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].stops}"),
//                                         ],
//                                       ),
//                                       Column(
//                                         children: [
//                                           Text(
//                                             "Arrival ",
//                                             style: GoogleFonts.rajdhani(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w700,
//                                               color: Colors.blueGrey,
//                                             ),
//                                           ),
//                                           Text(
//                                               " ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].aa.cityCode}"),
//                                           Text(
//                                               " ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].aa.city}"),
//                                           Text(
//                                               " ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].aa.country} (${widget.ticket.itemInfos.air.tripInfos[i].sI[j].aa.countryCode})"),
//                                           Text(
//                                               " ${widget.ticket.itemInfos.air.tripInfos[i].sI[j].at}"),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                           ],
//                         ),
      
//                       Text(
//                         "Traveller Details",
//                         style: GoogleFonts.rajdhani(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.blueGrey,
//                         ),
//                       ),
//       // Displaying traveller details for each traveller info
//                       for (int i = 0;
//                           i < widget.ticket.itemInfos.air.travellerInfos.length;
//                           i++)
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Traveller ${i + 1}"),
//                             Text(
//                                 "Passenger Type: ${widget.ticket.itemInfos.air.travellerInfos[i].pt}"),
//                             Text(
//                                 "Title: ${widget.ticket.itemInfos.air.travellerInfos[i].ti}"),
//                             Text(
//                                 "First Name: ${widget.ticket.itemInfos.air.travellerInfos[i].fN}"),
//                             Text(
//                                 "Last Name: ${widget.ticket.itemInfos.air.travellerInfos[i].lN}"),
//                             Text(
//                                 "Date of Birth: ${widget.ticket.itemInfos.air.travellerInfos[i].dob}"),
//                             Text(
//                                 "Nationality: ${widget.ticket.itemInfos.air.travellerInfos[i].pNat}"),
//                           ],
//                         ),
//                       Text(
//                         "Price Info",
//                         style: GoogleFonts.rajdhani(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.blueGrey,
//                         ),
//                       ),
//       // Displaying price details
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Total Fare Detail:"),
//                           Text(
//                               "Taxes and Fees: ${widget.ticket.itemInfos.air.totalPriceInfo.totalFareDetail.fC.taf}"),
//                           Text(
//                               "Total Fare: ${widget.ticket.itemInfos.air.totalPriceInfo.totalFareDetail.fC.tf}"),
//                           Text(
//                               "Non-Refundable Fare: ${widget.ticket.itemInfos.air.totalPriceInfo.totalFareDetail.fC.nf}"),
//                           Text(
//                               "Base Fare: ${widget.ticket.itemInfos.air.totalPriceInfo.totalFareDetail.fC.bf}"),
//                           Text("Tax and Fee Details:"),
//                           Text(
//                               "Taxes and Fees - Taxes and Fees: ${widget.ticket.itemInfos.air.totalPriceInfo.totalFareDetail.afC.taf.agst}"),
//                           Text(
//                               "Taxes and Fees - Taxes and Fees Other: ${widget.ticket.itemInfos.air.totalPriceInfo.totalFareDetail.afC.taf.ot}"),
//                           Text(
//                               "Taxes and Fees - Taxes and Fees YQ: ${widget.ticket.itemInfos.air.totalPriceInfo.totalFareDetail.afC.taf.yr}"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
