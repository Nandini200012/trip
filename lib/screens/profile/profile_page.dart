import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/login_variables/login_Variables.dart';
import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
import '../../api_services/profile/get_details_api.dart';
import '../constant.dart';
import '../header.dart';

String selectedgender;

class ProfilePage extends StatefulWidget {
  const ProfilePage({key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

TextEditingController _nameController = TextEditingController();
TextEditingController _addressController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _stateController = TextEditingController();
TextEditingController _pincodeController = TextEditingController();
TextEditingController _birthdayController = TextEditingController();
TextEditingController _phoneController = TextEditingController();
profileData profiledata;
String gender;
bool showsubmit = true;

class _ProfilePageState extends State<ProfilePage> {
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    getprofileDetails(user_id);
    _nameController.text = user_name;
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  getprofileDetails(id) async {
    String res = await getDetailsAPI(id);
    if (res != 'failed' && _isMounted) {
      Profileobj obj = Profileobj.fromJson(jsonDecode(res));
      setState(() {
        showsubmit = false;
        profiledata = obj.data[0];
        _addressController.text = profiledata.address;
        _stateController.text = profiledata.state;
        _pincodeController.text = profiledata.pincode;
        _passwordController.text = profiledata.password;
        _phoneController.text = profiledata.mobile;
        _emailController.text = profiledata.email;
        _birthdayController.text = profiledata.dob;
        gender = profiledata.gender;
      });
    }
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to submit the changes?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                // Add your submit logic here
                _submitChanges();
              },
            ),
          ],
        );
      },
    );
  }

  void _submitChanges() {
    // Add your logic for submitting the changes here
    print("Changes submitted");
  }

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
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            color: Colors.white24,
            height: sheight * 0.2,
            width: swidth,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0, bottom: 150),
            child: Container(
              // color: Color.fromARGB(58, 24, 133, 14),
              // height: sheight * 2,
              width: swidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  profileContainer(swidth, sheight),
                  kwidth30,
                  kwidth30,
                  Column(
                    children: [
                      detailsContainer(swidth, sheight),
                      kheight10,
                      kheight3,
                      logindetailsContainer(swidth, sheight),
                      kheight10,
                      kheight3,
                      submitbtn(
                          swidth,
                          sheight,
                          context,
                          selectedgender,
                          _addressController.text,
                          _pincodeController.text,
                          _stateController.text),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
  detailsContainer(double swidth, double sheight) {
  return Container(
    // height: sheight * 05,
    width: swidth * 0.58,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Profile",
              style: GoogleFonts.rajdhani(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          kheight3,
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 25),
            child: Text(
              "Basic info, for a faster booking experience",
              style: GoogleFonts.rajdhani(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          labelContainer(
              swidth, sheight, "Name", _nameController, "Enter the name"),
          // labelContainer(swidth, sheight, "Birthday", _birthdayController,
          //     "Enter the Birthday"),
          GenderContainer(
            swidth,
            sheight,
            "Gender",
          ),
          labelContainer(swidth, sheight, "Address", _addressController,
              "Enter the Address"),
          labelContainer(swidth, sheight, "Pincode", _pincodeController,
              "Enter the Pincode",
              type: TextInputType.number),
          labelContainer(
              swidth, sheight, "State", _stateController, "Enter the State"),
        ],
      ),
    ),
  );
}

  logindetailsContainer(double swidth, double sheight) {
  return Container(
    // height: sheight * 15,
    width: swidth * 0.58,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Login Details",
              style: GoogleFonts.rajdhani(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          kheight3,
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 25),
            child: Text(
              "Manage your email address mobile number and password",
              style: GoogleFonts.rajdhani(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          labelContainer(swidth, sheight, "MOBILE NUMBER", _phoneController,
              "Enter the Mobile Number"),
          labelContainer(swidth, sheight, "EMAIL ID", _emailController,
              "Enter your Email"),
          labelContainer(swidth, sheight, "PASSWORD", _passwordController,
              "Enter Password"),
        ],
      ),
    ),
  );
}
labelContainer(double swidth, double sheight, String title,
    TextEditingController controller, String hint,
    {TextInputType type = TextInputType.text}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0, left: 8, bottom: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.rajdhani(fontSize: 15, color: Colors.grey[500]),
        ),
        kheight3,
        Container(
          // width: swidth * 0.58,
          // height: 60,
          child: TextField(
            controller: controller,
            keyboardType: type,
            decoration: InputDecoration(
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 20.0, horizontal: 10.0), // Adjust the padding here
            ),
          ),
        ),
      ],
    ),
  );
}
}

submitbtn(double swidth, double sheight, BuildContext context,
    String _selectedGender, String address, String pincode, String state) {
  return Container(
    width: 150,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [Color.fromARGB(255, 0, 81, 148), Colors.blueAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 126, 132, 142).withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: InkWell(
      onTap: () {
        // _showAlertDialog(context);
        
        print("-------");
        print("_selectedGender: $_selectedGender");
        print("addressr: $address");
        print("pincode: $pincode");
        print("state: $state");
        print("-------");
      },
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
        child: Center(
          child: Text(
            'Submit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}





profileContainer(double swidth, double sheight) {
  return Container(
    height: sheight * 0.6,
    width: swidth * 0.2,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: swidth * 0.1,
          height: sheight * 0.2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green.shade400, Colors.green.shade900],
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              user_name.isNotEmpty ? user_name[0].toUpperCase() : '',
              style: GoogleFonts.rajdhani(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        kheight10,
        Text(
          user_name.isNotEmpty ? user_name : '',
          style: GoogleFonts.rajdhani(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        // kheight2,
        Text(
          'Personal Profile',
          style: GoogleFonts.rajdhani(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        kheight20,
        Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    // Colors.blue[50],
                    borderRadius: BorderRadius.circular(5)),
                height: sheight * .055,
                width: swidth * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kwidth10,
                    kwidth8,
                    Icon(
                      Icons.person_outlined,
                      color: Colors.blue.shade700,
                      size: 27,
                    ),
                    kwidth10,
                    kwidth5,
                    Text(
                      "Profile",
                      style: GoogleFonts.rajdhani(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              kheight10,
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    // color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(5)),
                height: sheight * .055,
                width: swidth * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kwidth10,
                    kwidth8,
                    Icon(
                      Icons.login_outlined,
                      color: Colors.blue.shade700,
                      size: 27,
                    ),
                    kwidth10,
                    kwidth5,
                    Text(
                      "Login Details",
                      style: GoogleFonts.rajdhani(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              kheight10,
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    // color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(5)),
                height: sheight * .055,
                width: swidth * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    kwidth10,
                    kwidth8,
                    Icon(
                      Icons.logout_outlined,
                      color: Colors.blue.shade700,
                      size: 27,
                    ),
                    kwidth10,
                    kwidth5,
                    Text(
                      "Logout",
                      style: GoogleFonts.rajdhani(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}



class GenderContainer extends StatefulWidget {
  double swidth;
  double sheight;
  String title;
  GenderContainer(this.swidth, this.sheight, this.title);

  @override
  State<GenderContainer> createState() => _GenderContainerState();
}

class _GenderContainerState extends State<GenderContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.rajdhani(fontSize: 15, color: Colors.grey[500]),
          ),
          kheight3,
          Row(
            children: [
              Row(
                children: [
                  Radio(
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                      selectedgender=value;
                    },
                  ),
                  Text('Male', style: GoogleFonts.rajdhani(fontSize: 15)),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });    selectedgender=value;
                    },
                    
                  ),
                  Text('Female', style: GoogleFonts.rajdhani(fontSize: 15)),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 'Other',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                  Text('Other', style: GoogleFonts.rajdhani(fontSize: 15)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}















// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:trip/login_variables/login_Variables.dart';
// import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
// import '../../api_services/profile/get_details_api.dart';
// import '../constant.dart';
// import '../header.dart';

// String selectedgender = 'Female';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// TextEditingController _nameController = TextEditingController();
// TextEditingController _addressController = TextEditingController();
// TextEditingController _emailController = TextEditingController();
// TextEditingController _passwordController = TextEditingController();
// TextEditingController _stateController = TextEditingController();
// TextEditingController _pincodeController = TextEditingController();
// TextEditingController _birthdayController = TextEditingController();
// TextEditingController _phoneController = TextEditingController();
// profileData profiledata;
// String gender;
// bool showsubmit = true;

// class _ProfilePageState extends State<ProfilePage> {
//   getprofileDetails(id) async {
//     String res = await getDetailsAPI(id);
//     if (res != 'failed') {
//       Profileobj obj = Profileobj.fromJson(jsonDecode(res));
//       setState(() {
//         showsubmit = false;
//         profiledata = obj.data[0];
//         _addressController.text = profiledata.address;
//         _stateController.text = profiledata.state;
//         _pincodeController.text = profiledata.pincode;
//         _passwordController.text = profiledata.password;
//         _phoneController.text = profiledata.mobile;
//         _emailController.text = profiledata.email;
//         _birthdayController.text = profiledata.dob;
//         gender = profiledata.gender;
//       });
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getprofileDetails(user_id);
//     _nameController.text = user_name;
//   }

//   void _showAlertDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirmation'),
//           content: Text('Are you sure you want to submit the changes?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Dismiss the dialog
//               },
//             ),
//             ElevatedButton(
//               child: Text('Submit'),
//               onPressed: () {
//                 Navigator.of(context).pop(); // Dismiss the dialog
//                 // Add your submit logic here
//                 _submitChanges();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _submitChanges() {
//     // Add your logic for submitting the changes here
//     print("Changes submitted");
//   }

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
//         child: Stack(children: [
//           Container(
//             color: Colors.white24,
//             height: sheight * 0.2,
//             width: swidth,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 100.0, bottom: 150),
//             child: Container(
//               // color: Color.fromARGB(58, 24, 133, 14),
//               // height: sheight * 2,
//               width: swidth,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   profileContainer(swidth, sheight),
//                   kwidth30,
//                   kwidth30,
//                   Column(
//                     children: [
//                       detailsContainer(swidth, sheight),
//                       kheight10,
//                       kheight3,
//                       logindetailsContainer(swidth, sheight),
//                       kheight10,
//                       kheight3,
//                       submitbtn(
//                           swidth,
//                           sheight,
//                           context,
//                           selectedgender,
//                           _addressController.text,
//                           _pincodeController.text,
//                           _stateController.text),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// submitbtn(double swidth, double sheight, BuildContext context,
//     String _selectedGender, String address, String pincode, String state) {
//   return Container(
//     width: 150,
//     height: 50,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       gradient: LinearGradient(
//         colors: [Color.fromARGB(255, 0, 81, 148), Colors.blueAccent],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//       boxShadow: [
//         BoxShadow(
//           color: Color.fromARGB(255, 126, 132, 142).withOpacity(0.5),
//           spreadRadius: 2,
//           blurRadius: 7,
//           offset: Offset(0, 3), // changes position of shadow
//         ),
//       ],
//     ),
//     child: InkWell(
//       onTap: () {
//         // _showAlertDialog(context);
//         //        String _selectedGender,
//         // String address,
//         // String pincode,
//         // String state
//         print("-------");
//         print("_selectedGender: $_selectedGender");
//         print("addressr: $address");
//         print("pincode: $pincode");
//         print("state: $state");
//         print("-------");
//       },
//       borderRadius: BorderRadius.circular(10),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
//         child: Center(
//           child: Text(
//             'Submit',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// logindetailsContainer(double swidth, double sheight) {
//   return Container(
//     // height: sheight * 15,
//     width: swidth * 0.58,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Text(
//               "Login Details",
//               style: GoogleFonts.rajdhani(
//                   fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//           ),
//           kheight3,
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0, bottom: 25),
//             child: Text(
//               "Manage your email address mobile number and password",
//               style: GoogleFonts.rajdhani(
//                   fontSize: 15, fontWeight: FontWeight.w500),
//             ),
//           ),
//           labelContainer(swidth, sheight, "MOBILE NUMBER", _phoneController,
//               "Enter the Mobile Number"),
//           labelContainer(swidth, sheight, "EMAIL ID", _emailController,
//               "Enter your Email"),
//           labelContainer(swidth, sheight, "PASSWORD", _passwordController,
//               "Enter Password"),
//         ],
//       ),
//     ),
//   );
// }

// detailsContainer(double swidth, double sheight) {
//   return Container(
//     // height: sheight * 05,
//     width: swidth * 0.58,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Text(
//               "Profile",
//               style: GoogleFonts.rajdhani(
//                   fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//           ),
//           kheight3,
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0, bottom: 25),
//             child: Text(
//               "Basic info, for a faster booking experience",
//               style: GoogleFonts.rajdhani(
//                   fontSize: 15, fontWeight: FontWeight.w500),
//             ),
//           ),
//           labelContainer(
//               swidth, sheight, "Name", _nameController, "Enter the name"),
//           // labelContainer(swidth, sheight, "Birthday", _birthdayController,
//           //     "Enter the Birthday"),
//           GenderContainer(
//             swidth,
//             sheight,
//             "Gender",
//           ),
//           labelContainer(swidth, sheight, "Address", _addressController,
//               "Enter the Address"),
//           labelContainer(swidth, sheight, "Pincode", _pincodeController,
//               "Enter the Pincode",
//               type: TextInputType.number),
//           labelContainer(
//               swidth, sheight, "State", _stateController, "Enter the State"),
//         ],
//       ),
//     ),
//   );
// }

// GenderContainer(
//   double swidth,
//   double sheight,
//   String title,
// ) {
//   return Container(
//     width: swidth * 0.75,
//     // height: sheight * 0.13,
//     decoration: BoxDecoration(color: Colors.white),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             kwidth10,
//             SizedBox(
//               width: 150,
//               child: Text(
//                 title,
//                 // "Name",
//                 style: GoogleFonts.rajdhani(
//                     fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//             ),
//             Container(
//               width: swidth * 0.3,
//               // height: sheight*0.08,
//               child: GenderDropdownn(gender: gender ?? null),
//             )
//           ],
//         ),
//         // kheight10,
//         kheight5,
//         Divider()
//       ],
//     ),
//   );
// }

// labelContainer(double swidth, double sheight, String title,
//     TextEditingController controller, String label,
//     {TextInputType type}) {
//   return Container(
//     width: swidth * 0.75,
//     decoration: BoxDecoration(color: Colors.white),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             SizedBox(width: 10),
//             SizedBox(
//               width: 150,
//               child: Text(
//                 title,
//                 style: GoogleFonts.rajdhani(
//                     fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//             ),
//             Container(
//               width: swidth * 0.3,
//               child: TextFormField(
//                 keyboardType: type ?? TextInputType.text,
//                 controller: controller, // Attach the controller here
//                 decoration: InputDecoration(
//                   labelText: label,
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter this field';
//                   }
//                   return null;
//                 },
//               ),
//             )
//           ],
//         ),
//         SizedBox(height: 5),
//         Divider()
//       ],
//     ),
//   );
// }

// // labelContainer(double swidth, double sheight, String title,
// //     TextEditingController controller, String label,
// //     {TextInputType type}) {
// //   return Container(
// //     width: swidth * 0.75,
// //     // height: sheight * 0.13,
// //     decoration: BoxDecoration(color: Colors.white),
// //     child: Column(
// //       mainAxisAlignment: MainAxisAlignment.start,
// //       children: [
// //         Row(
// //           children: [
// //             kwidth10,
// //             SizedBox(
// //               width: 150,
// //               child: Text(
// //                 title,
// //                 // "Name",
// //                 style: GoogleFonts.rajdhani(
// //                     fontSize: 15, fontWeight: FontWeight.w600),
// //               ),
// //             ),
// //             Container(
// //               width: swidth * 0.3,
// //               // height: sheight*0.08,
// //               child: TextFormField(
// //                 keyboardType: type != null ? type : TextInputType.text,
// //                 // controller: _nameController,
// //                 decoration: InputDecoration(
// //                   labelText: label,
// //                   // 'Enter your name',
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter this field';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //             )
// //           ],
// //         ),
// //         // kheight10,
// //         kheight5,
// //         Divider()
// //       ],
// //     ),
// //   );
// // }

// enum Gender { Male, Female, Other }

// class GenderDropdownn extends StatefulWidget {
//   String gender;
//   GenderDropdownn({this.gender});
//   @override
//   _GenderDropdownnState createState() => _GenderDropdownnState();
// }

// class _GenderDropdownnState extends State<GenderDropdownn> {
//   Gender _selectedGender;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getgender(widget.gender);
//   }

//   getgender(String gender) {
//     if (gender != null) {
//       if (gender.toLowerCase() == 'male') {
//         _selectedGender = Gender.Male;
//         selectedgender = _selectedGender.toString();
//       } else {
//         _selectedGender = Gender.Female;
//         selectedgender = _selectedGender.toString();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<Gender>(
//       value: _selectedGender,
//       items: Gender.values.map((Gender gender) {
//         return DropdownMenuItem<Gender>(
//           value: gender,
//           child: Text(_getDisplayText(gender)),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           _selectedGender = value;
//         });
//       },
//       decoration: InputDecoration(
//         labelText: 'Select your gender',
//         border: OutlineInputBorder(),
//       ),
//     );
//   }

//   String _getDisplayText(Gender gender) {
//     switch (gender) {
//       case Gender.Male:
//         return 'Male';
//       case Gender.Female:
//         return 'Female';
//       case Gender.Other:
//         return 'Other';
//     }
//   }
// }

// profileContainer(double swidth, double sheight) {
//   return Container(
//     height: sheight * 0.6,
//     width: swidth * 0.2,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Column(
//       children: [
//         SizedBox(
//           height: 20,
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Container(
//           width: swidth * 0.1,
//           height: sheight * 0.2,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Colors.green.shade400, Colors.green.shade900],
//             ),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Center(
//             child: Text(
//               user_name.isNotEmpty ? user_name[0].toUpperCase() : '',
//               style: GoogleFonts.rajdhani(
//                   fontSize: 45,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//           ),
//         ),
//         kheight10,
//         Text(
//           user_name.isNotEmpty ? user_name : '',
//           style: GoogleFonts.rajdhani(
//               fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         // kheight2,
//         Text(
//           'Personal Profile',
//           style: GoogleFonts.rajdhani(
//               fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
//         ),
//         kheight20,
//         Padding(
//           padding: const EdgeInsets.all(22.0),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     // Colors.blue[50],
//                     borderRadius: BorderRadius.circular(5)),
//                 height: sheight * .055,
//                 width: swidth * 0.2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     kwidth10,
//                     kwidth8,
//                     Icon(
//                       Icons.person_outlined,
//                       color: Colors.blue.shade700,
//                       size: 27,
//                     ),
//                     kwidth10,
//                     kwidth5,
//                     Text(
//                       "Profile",
//                       style: GoogleFonts.rajdhani(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               kheight10,
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     // color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(5)),
//                 height: sheight * .055,
//                 width: swidth * 0.2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     kwidth10,
//                     kwidth8,
//                     Icon(
//                       Icons.login_outlined,
//                       color: Colors.blue.shade700,
//                       size: 27,
//                     ),
//                     kwidth10,
//                     kwidth5,
//                     Text(
//                       "Login Details",
//                       style: GoogleFonts.rajdhani(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               kheight10,
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     // color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(5)),
//                 height: sheight * .055,
//                 width: swidth * 0.2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     kwidth10,
//                     kwidth8,
//                     Icon(
//                       Icons.logout_outlined,
//                       color: Colors.blue.shade700,
//                       size: 27,
//                     ),
//                     kwidth10,
//                     kwidth5,
//                     Text(
//                       "Logout",
//                       style: GoogleFonts.rajdhani(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }

// void _showAlertDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Confirmation'),
//         content: Text('Are you sure you want to submit the changes?'),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Cancel'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Dismiss the dialog
//             },
//           ),
//           ElevatedButton(
//             child: Text('Submit'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Dismiss the dialog
//               // Add your submit logic here
//               _submitChanges();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// void _submitChanges() {
//   // Add your logic for submitting the changes here
//   print("Changes submitted");
// }
















// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:trip/login_variables/login_Variables.dart';
// import 'package:trip/screens/holiday_Packages/widgets/constants_holiday.dart';
// import '../../api_services/profile/get_details_api.dart';
// import '../constant.dart';
// import '../header.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// TextEditingController _nameController = TextEditingController();
// TextEditingController _addressController = TextEditingController();
// TextEditingController _emailController = TextEditingController();
// TextEditingController _passwordController = TextEditingController();
// TextEditingController _stateController = TextEditingController();
// TextEditingController _pincodeController = TextEditingController();
// TextEditingController _birthdayController = TextEditingController();
// TextEditingController _phoneController = TextEditingController();
// profileData profiledata;

// class _ProfilePageState extends State<ProfilePage> {
//   getprofileDetails(id) async {
//     String res = await getDetailsAPI(id);
//     if (res != 'failed') {
//       Profileobj obj = Profileobj.fromJson(jsonDecode(res));
//       setState(() {
//         profiledata = obj.data[0];
//         _addressController.text = profiledata.address;
//         _stateController.text = profiledata.state;
//         _pincodeController.text = profiledata.pincode;
//         _passwordController.text = profiledata.password;
//         _phoneController.text = profiledata.mobile;
//         _emailController.text = profiledata.email;
//         _birthdayController.text = profiledata.dob;
//       });
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getprofileDetails(user_id);
//     _nameController.text = user_name;
//   }

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
//         child: Stack(children: [
//           Container(
//             color: Colors.white24,
//             height: sheight * 0.2,
//             width: swidth,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 100.0, bottom: 150),
//             child: Container(
//               // color: Color.fromARGB(58, 24, 133, 14),
//               // height: sheight * 2,
//               width: swidth,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   profileContainer(swidth, sheight),
//                   kwidth30,
//                   kwidth30,
//                   Column(
//                     children: [
//                       detailsContainer(swidth, sheight),
//                       kheight10,
//                       kheight3,
//                       logindetailsContainer(swidth, sheight),
//                       kheight10,
//                       kheight3,
//                       submitbtn(swidth, sheight),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// submitbtn(double swidth, double sheight) {
//   return ElevatedButton(
//     onPressed: () {},
//     style: ElevatedButton.styleFrom(
//       primary: Colors.blue,
//       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 5,
//       shadowColor: Colors.blueAccent,
//     ),
//     child: Text(
//       'Submit',
//       style: TextStyle(
//         fontSize: 18,
//         color: Colors.white,
//       ),
//     ),
//   );
// }

// logindetailsContainer(double swidth, double sheight) {
//   return Container(
//     // height: sheight * 15,
//     width: swidth * 0.58,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Text(
//               "Login Details",
//               style: GoogleFonts.rajdhani(
//                   fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//           ),
//           kheight3,
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0, bottom: 25),
//             child: Text(
//               "Manage your email address mobile number and password",
//               style: GoogleFonts.rajdhani(
//                   fontSize: 15, fontWeight: FontWeight.w500),
//             ),
//           ),
//           labelContainer(swidth, sheight, "MOBILE NUMBER", _phoneController,
//               "Enter the Mobile Number"),
//           labelContainer(swidth, sheight, "EMAIL ID", _emailController,
//               "Enter your Email"),
//           labelContainer(swidth, sheight, "PASSWORD", _passwordController,
//               "Enter Password"),
//         ],
//       ),
//     ),
//   );
// }

// detailsContainer(double swidth, double sheight) {
//   return Container(
//     // height: sheight * 05,
//     width: swidth * 0.58,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Text(
//               "Profile",
//               style: GoogleFonts.rajdhani(
//                   fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//           ),
//           kheight3,
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0, bottom: 25),
//             child: Text(
//               "Basic info, for a faster booking experience",
//               style: GoogleFonts.rajdhani(
//                   fontSize: 15, fontWeight: FontWeight.w500),
//             ),
//           ),
//           labelContainer(
//               swidth, sheight, "Name", _nameController, "Enter the name"),
//           labelContainer(swidth, sheight, "Birthday", _birthdayController,
//               "Enter the Birthday"),
//           GenderContainer(
//             swidth,
//             sheight,
//             "Gender",
//           ),
//           labelContainer(swidth, sheight, "Address", _addressController,
//               "Enter the Address"),
//           labelContainer(swidth, sheight, "Pincode", _pincodeController,
//               "Enter the Pincode",
//               type: TextInputType.number),
//           labelContainer(
//               swidth, sheight, "State", _stateController, "Enter the State"),
//         ],
//       ),
//     ),
//   );
// }

// GenderContainer(
//   double swidth,
//   double sheight,
//   String title,
// ) {
//   return Container(
//     width: swidth * 0.75,
//     // height: sheight * 0.13,
//     decoration: BoxDecoration(color: Colors.white),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             kwidth10,
//             SizedBox(
//               width: 150,
//               child: Text(
//                 title,
//                 // "Name",
//                 style: GoogleFonts.rajdhani(
//                     fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//             ),
//             Container(
//               width: swidth * 0.3,
//               // height: sheight*0.08,
//               child: GenderDropdownn(),
              
//             )
//           ],
//         ),
//         // kheight10,
//         kheight5,
//         Divider()
//       ],
//     ),
//   );
// }

// labelContainer(double swidth, double sheight, String title,
//     TextEditingController controller, String label,
//     {TextInputType type}) {
//   return Container(
//     width: swidth * 0.75,
//     // height: sheight * 0.13,
//     decoration: BoxDecoration(color: Colors.white),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             kwidth10,
//             SizedBox(
//               width: 150,
//               child: Text(
//                 title,
//                 // "Name",
//                 style: GoogleFonts.rajdhani(
//                     fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//             ),
//             Container(
//               width: swidth * 0.3,
//               // height: sheight*0.08,
//               child: TextFormField(
//                 keyboardType: type != null ? type : TextInputType.text,
//                 // controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: label,
//                   // 'Enter your name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter this field';
//                   }
//                   return null;
//                 },
//               ),
//             )
//           ],
//         ),
//         // kheight10,
//         kheight5,
//         Divider()
//       ],
//     ),
//   );
// }

// enum Gender { Male, Female, Other }

// class GenderDropdownn extends StatefulWidget {
//   @override
//   _GenderDropdownnState createState() => _GenderDropdownnState();
// }

// class _GenderDropdownnState extends State<GenderDropdownn> {
//   Gender _selectedGender;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<Gender>(
//       value: _selectedGender,
//       items: Gender.values.map((Gender gender) {
//         return DropdownMenuItem<Gender>(
//           value: gender,
//           child: Text(_getDisplayText(gender)),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           _selectedGender = value;
//         });
//       },
//       decoration: InputDecoration(
//         labelText: 'Select your gender',
//         border: OutlineInputBorder(),
//       ),
//     );
//   }

//   String _getDisplayText(Gender gender) {
//     switch (gender) {
//       case Gender.Male:
//         return 'Male';
//       case Gender.Female:
//         return 'Female';
//       case Gender.Other:
//         return 'Other';
//     }
//   }
// }

// profileContainer(double swidth, double sheight) {
//   return Container(
//     height: sheight * 0.6,
//     width: swidth * 0.2,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: Column(
//       children: [
//         SizedBox(
//           height: 20,
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Container(
//           width: swidth * 0.1,
//           height: sheight * 0.2,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Colors.green.shade400, Colors.green.shade900],
//             ),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Center(
//             child: Text(
//               user_name.isNotEmpty ? user_name[0].toUpperCase() : '',
//               style: GoogleFonts.rajdhani(
//                   fontSize: 45,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//           ),
//         ),
//         kheight10,
//         Text(
//           user_name.isNotEmpty ? user_name : '',
//           style: GoogleFonts.rajdhani(
//               fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//         // kheight2,
//         Text(
//           'Personal Profile',
//           style: GoogleFonts.rajdhani(
//               fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
//         ),
//         kheight20,
//         Padding(
//           padding: const EdgeInsets.all(22.0),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(5)),
//                 height: sheight * .055,
//                 width: swidth * 0.2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     kwidth10,
//                     kwidth8,
//                     Icon(
//                       Icons.person_outlined,
//                       color: Colors.blue.shade700,
//                       size: 27,
//                     ),
//                     kwidth10,
//                     kwidth5,
//                     Text(
//                       "Profile",
//                       style: GoogleFonts.rajdhani(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               kheight10,
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(5)),
//                 height: sheight * .055,
//                 width: swidth * 0.2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     kwidth10,
//                     kwidth8,
//                     Icon(
//                       Icons.login_outlined,
//                       color: Colors.blue.shade700,
//                       size: 27,
//                     ),
//                     kwidth10,
//                     kwidth5,
//                     Text(
//                       "Login Details",
//                       style: GoogleFonts.rajdhani(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               kheight10,
//               Container(
//                 decoration: BoxDecoration(
//                     color: Colors.blue[50],
//                     borderRadius: BorderRadius.circular(5)),
//                 height: sheight * .055,
//                 width: swidth * 0.2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     kwidth10,
//                     kwidth8,
//                     Icon(
//                       Icons.logout_outlined,
//                       color: Colors.blue.shade700,
//                       size: 27,
//                     ),
//                     kwidth10,
//                     kwidth5,
//                     Text(
//                       "Logout",
//                       style: GoogleFonts.rajdhani(
//                         fontSize: 17,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.blue.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     ),
//   );
// }
