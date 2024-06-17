import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../api_services/activity/get_activity_details.dart';
import '../../../api_services/payment_api/cancellation_api.dart';
import '../../../api_services/payment_api/completed_payment_api.dart';
import '../../holiday_Packages/widgets/constants_holiday.dart';

class ActivityList extends StatelessWidget {
  final double swidth;
  final double sheight;
  final List<Datum> activityData;
  final List<SuccessPaymentData> activitySuccessData;

  const ActivityList({
    Key key,
       this.swidth,
       this.sheight,
       this.activityData,
       this.activitySuccessData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 25, bottom: 25, right: 8),
      child: Container(
        width: swidth * 0.6,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: swidth * 0.6,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Number of columns in the grid
                  crossAxisSpacing: 10.0, // Spacing between columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                  childAspectRatio: 1.0 / 1.2, // Aspect ratio of the items
                ),
                itemCount: activityData.length,
                itemBuilder: (context, index) {
                  List<SuccessPaymentData> data = activitySuccessData.where((successData) {
                    return successData.packageId == activityData[index].packageId;
                  }).toList();

                  return Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: Column(
                      children: [
                        Image.network("${activityData[index].image1}"),
                        kheight10,
                        Text(
                          activityData[index].packageName,
                          style: GoogleFonts.rajdhani(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        kheight5,
                        Text(
                          "Status: Paid ₹${data.isNotEmpty ? data[0].amount : 'N/A'}",
                          style: GoogleFonts.rajdhani(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.green,
                          ),
                        ),
                        kheight10,
                        GestureDetector(
                          onTap: () {
                            if (data.isNotEmpty) {
                              cancellationAPI("${data[0].tid}");
                            }
                          },
                          child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.deepOrangeAccent,
                            ),
                            child: Center(
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.rajdhani(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
