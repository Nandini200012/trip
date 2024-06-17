import 'package:flutter/material.dart';
import 'package:trip/screens/bus/models/usermodel.dart';
import 'package:trip/screens/bus/widgets/dropdownID_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api_services/bus apis/block_ticket_api.dart';

import '../../../common/print_funtions.dart';
import '../../../login_variables/login_Variables.dart';
import '../bus_tripdetail.dart';

List<User> passengers = [];
String userGender;
String userTitle;
String userIDtype;
bool _showSubmit = false;

class BusTravellerForm extends StatefulWidget {
  @override
  _BusTravellerFormState createState() => _BusTravellerFormState();
}

class _BusTravellerFormState extends State<BusTravellerForm> {
  List<bool> isDataSaved = [];
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> ageControllers = [];
  List<TextEditingController> emailControllers = [];
  List<TextEditingController> mobileControllers = [];
  List<TextEditingController> addressControllers = [];
  List<TextEditingController> idNumberControllers = [];
  TextStyle formtitle =
      TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500);
  @override
  void initState() {
    super.initState();
    isDataSaved = List.generate(selectedSeats.length, (_) => false);
    initializeControllers();
  }

  // Initialize text editing controllers
  void initializeControllers() {
    for (int i = 0; i < selectedSeats.length; i++) {
      nameControllers.add(TextEditingController());
      ageControllers.add(TextEditingController());
      emailControllers.add(TextEditingController());
      mobileControllers.add(TextEditingController());
      addressControllers.add(TextEditingController());
      idNumberControllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 156.0, right: 156, top: 20, bottom: 20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Passenger Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(),
                SizedBox(height: 20),
                for (var index = 0; index < selectedSeats.length; index++)
                  buildPassengerForm(
                      index,
                      (index == (selectedSeats.length - 1) ? true : false),
                      selectedSeats.length),
                SizedBox(height: 20),
                // Center(
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       primary: Color.fromARGB(255, 248, 87, 51),
                //       elevation: 10,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     onPressed: () {

                //       // Save data
                // showSubmit=true;
                // saveData();
                //     },
                //     child: Container(
                //       alignment: Alignment.center,
                //       width: 70,
                //       height: 35,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Center(
                //         child: Text(
                //           "Save",
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===buidform
  Widget buildPassengerForm(int index, bool last, int length) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // height: 80,
          width: 280,
          child: Row(
            children: [
              // SizedBox(
              //   width: 10,
              // ),
              Container(
                  width: 28,
                  color: Color.fromARGB(255, 158, 150, 150),
                  child: Center(
                    child: Text(
                      selectedSeats[index],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Text(
                'Passenger ${index + 1}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title:', style: formtitle),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 280,
                      height: 50,
                      child: TitleDropdown(),
                    ),
                    // SizedBox(width: 10),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name:', style: formtitle),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: nameControllers[index],
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Age:", style: formtitle),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: ageControllers[index],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      hintText: 'Enter Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Gender:", style: formtitle),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: 280,
                  child: GenderDropdown(),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email:", style: formtitle),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: emailControllers[index],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                )
              ],
            ),

            //  SizedBox(
            //   width: 20,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Address:", style: formtitle),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: addressControllers[index],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      hintText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(
            //   width: 60,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID Type:", style: formtitle),
                SizedBox(
                  height: 12,
                ),
                SizedBox(width: 280, child: DropdownId()),
              ],
            ),
            // SizedBox(
            //   width: 60,
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ID Number:", style: formtitle),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: idNumberControllers[index],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'ID Number',
                      hintText: 'ID Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Mobile Number:", style: formtitle),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: mobileControllers[index],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      hintText: 'Mobile Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Visibility(
          visible: last,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:Colors.blue[
                                        700],
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  print(index);
                  for (int i = 0; i < length; i++) {
                    savePassengerData(i);
                    print("savedpassenger$i");
                  }
                  if (last) {
                    // sace data
                    _showSubmit = true;
                    saveData();
                    print("savedall");
                  
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 70,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // icon: isDataSaved[index] ? Icon(Icons.delete) : Icon(Icons.done),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }

  void savePassengerData(int index) {
    setState(() {
      isDataSaved[index] = true;
    });
  }

  void saveData() {
    passengers.clear();
    print("---Dropdown Selections ---");
    print("ID Type: $userIDtype");
    print("Gender: $userGender");
    print("Title: $userTitle");

    if (selectedSeats.isEmpty) {
      print("Error: No seats selected.");
      return;
    }

    for (int i = 0; i < selectedSeats.length; i++) {
      print("isDataSaved[$i]: ${isDataSaved[i]}");
      if (isDataSaved[i]) {
        print(
            "$i--\n---seat: ${selectedSeats[i]},\n name: ${nameControllers[i].text} \n age : ${ageControllers[i].text}\n email:${emailControllers[i].text}\n mobile: ${mobileControllers[i].text}\n address : ${addressControllers[i].text}\n id: ${idNumberControllers[i].text}");

        String name = nameControllers[i].text;
        String age = ageControllers[i].text;
        String email = emailControllers[i].text;
        String mobile = mobileControllers[i].text;
        String address = addressControllers[i].text;
        String idNumber = idNumberControllers[i].text;

        if (name.isEmpty ||
            age.isEmpty ||
            email.isEmpty ||
            mobile.isEmpty ||
            address.isEmpty ||
            idNumber.isEmpty) {
          print("Error: Missing required field for passenger $i.");
          continue; // Skip this passenger and proceed with the next one
        }

        User newUser = User(
          seatNo: selectedSeats[i],
          name: name,
          age: age,
          email: email,
          mobile: mobile,
          address: address,
          idNumber: idNumber,
          gender: userGender,
          idType: userIDtype,
          title: userTitle,
          ladiesSeat: false,
          // Populate with data from form fields
        );
        passengers.add(newUser);
        print("Passenger $i added successfully: $newUser");
      }
    }
    print("Final Passengers List: $passengers");
    // Call your save data function here if needed
  }
}

Future<String> submitForm(List<User> passengers, String id, String boardingpnt,
    String droppingpnt, String source, String destination, context) async {
  if (passengers == null ||
      id == null ||
      boardingpnt == null ||
      droppingpnt == null ||
      source == null ||
      destination == null ||
      busFare == null) {
    print('Error: One or more parameters are null.');
    print(
        "submitform: id:$id, \nfare: $busFare, \nsource: $source,\n des:$destination,");
    print(
        "brdng pnt: $boardingpnt, \ndepng pnt : $droppingpnt, \nsource: $source,\n passengers: ${passengers.length},");
    return null;
  }

  String res = await blockTicketAPI(
    id: id,
    boardingpnt: boardingpnt,
    droppingpnt: droppingpnt,
    source: source,
    destination: destination,
    fare: busFare,
    passengers: passengers,
  );

  if (res == "failed" || res.contains("Error")) {
    showAlert(res, context);
  } else {
    double totalfare = double.parse(busFare) * (passengers.length);
    payment(totalfare, passengers.first, res);
  }
  return res;
}

payment(totalfare, User passengers, String res) {
  printWhite("submit blkkey:$res");
  if (res != null || res != "failed" || res.contains("Error")) {
    Uri _uri = Uri.parse(
        'http://gotodestination.in/api/payment_api/payment/payment_api/NON_SEAMLESS_KIT/ccavRequestHandler.php?block_key=${res}&booking_id=null&rpax_pricing=false&package_details=null&package_id=null&user_id=${user_id}&order_id=11&amount=1&customer_id=${user_id}&user_type=bus&billing_name=${user_name}&billing_address=kerala&billing_city=palakkad&billing_tel=9526751850&billing_email=nandhininatarajan04@gmail.com');
    launchUrl(_uri);
  }
}

void showAlert(String message, context) {
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

// --------------------
  


