import 'package:flutter/material.dart';
import 'package:trip/screens/constant.dart';
import 'package:trip/screens/signUp.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api_services/activity/get_activity_details.dart';
import 'globalcontroller.dart';

Widget form(double sWidth, List<PackageOption> packagelist, sHeight) {
  bool isclicked = false;
  return Container(
    // width: sWidth * 0.35,
    width: sWidth,
    child: Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: sWidth * 0.35,
                child: buildTextFormField(
                    'Name', usernamecontroller, 'Please enter your name'),
              ),
              SizedBox(
                width: sWidth * 0.35,
                child: buildTextFormField('Email', useremailcontroller,
                    'Please enter your email'),
              ),
              SizedBox(
                width: sWidth * 0.35,
                child: buildTextFormField('Mobile', mobilecontroller,
                    'Please enter your mobile number'),
              ),
              SizedBox(
                width: sWidth * 0.35,
                child: buildTextFormField(
                    'City', citycontroller, 'Please enter your city'),
              ),
              SizedBox(
                width: sWidth * 0.35,
                child: buildTextFormField('Address', useraddresscontroller,
                    'Please enter your address'),
              ),
              PackageOptionWidget(
                  package: packagelist, sWidth: sWidth, sHeight: sHeight),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget submitButton(price, id) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 10, 350, 10),
    child: SizedBox(
      width: 120,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Uri _uri = Uri.parse(
              'https://boys.org.in/API/payment_api/payment_api/NON_SEAMLESS_KIT/ccavRequestHandler.php?order_id=${id}&amount=${price}&customer_id=11&user_type=userType&billing_name=${usernamecontroller.text}&billing_address=${useraddresscontroller.text}&billing_city=${citycontroller.text}&billing_tel=${mobilecontroller.text}&billing_email=${useremailcontroller.text}');

          launchUrl(_uri);
        },
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 224, 90, 67),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text("Pay ₹${price}"),
      ),
    ),
  );
}

Widget buildTextFormField(
    String labelText, TextEditingController controller, String errorMessage) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return errorMessage;
        }
        return null;
      },
    ),
  );
}

class PackageOptionWidget extends StatefulWidget {
  final List<PackageOption> package;
  final double sHeight;
  final double sWidth;

  PackageOptionWidget({
    Key key,
    @required this.package,
    @required this.sHeight,
    @required this.sWidth,
  }) : super(key: key);

  @override
  _PackageOptionWidgetState createState() => _PackageOptionWidgetState();
}

String price = "";
String id="";
class _PackageOptionWidgetState extends State<PackageOptionWidget> {
  int selectedPackageIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: widget.package.asMap().entries.map((entry) {
            final index = entry.key;
            final packageOption = entry.value;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPackageIndex = index;
                    price = widget.package[index].price;
                    id=widget.package[index].packageId;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: selectedPackageIndex == index
                        ? Colors.deepOrangeAccent
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1.0,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  // height: widget.sHeight * 0.07,
                  width: widget.sWidth * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(height: 8),
                      Text(
                        packageOption.description,
                        style: TextStyle(
                          color: selectedPackageIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Price: ₹${packageOption.price}',
                        style: TextStyle(
                          color: selectedPackageIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Duration: ${packageOption.timeDuration}',
                        style: TextStyle(
                          color: selectedPackageIndex == index
                              ? Colors.white70
                              : Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Age Limit: ${packageOption.agePolicy}',
                        style: TextStyle(
                          color: selectedPackageIndex == index
                              ? Colors.white70
                              : Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        if (price != "")
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              submitButton(price,id),
            ],
          )
      ],
    );
  }
}
