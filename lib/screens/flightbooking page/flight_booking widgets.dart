
int globalindex=1;

addindex(index){
globalindex=index+1;
print('globalindex');
print(globalindex);
return globalindex;
}
















//  import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../api_services/location_list_api.dart';
// import '../flight_booking_screen.dart';

// OverlayEntry _overlayEntry;
//   String selectedRadioButton = '';
//   String selectedRadioButton1 = '';
//   String selectedRadioButton2 = '';
//   bool showTextField = false;
//   bool showTextField1 = false;
//   bool textCity1 = true;
//   bool adrsCity1 = true;
//   bool textCity2 = true;
//   bool adrsCity2 = true;
//   // multicity
//   bool showTextField3 = false;
//   bool showTextField4 = false;
//   bool textCity3 = true;
//   bool adrsCity3 = true;
//   bool textCity4 = true;
//   bool adrsCity4 = true;
//   String city3 ='Select a location';
//   String address3 = '';
//   String city4 = 'Select a location';
//   String address4 = '';
//   String from_code1 = '';
//   String to_code1 = '';
//   String dayDeparture1;
//   String dayReturn1;
//   String dateDep1;
//   String dateRet1;
//   String depformat1;
//   String retformat1;
//   DateTime selectedDate3 = DateTime.now();
//   TextEditingController dateController3 = TextEditingController();
//   final DateFormat formatter3 = DateFormat('dd-MM-yyyy');
//   final DateFormat reverseDtFormatter3 = DateFormat('yyyy-MM-dd');
//   TextEditingController dateForController3 = TextEditingController();

//   DateTime selectedDate4 = DateTime.now();
//   TextEditingController date1Controller3 = TextEditingController();
//   final DateFormat formatter4 = DateFormat('dd-MM-yyyy');
//   final DateFormat reverseDtFormatter4 = DateFormat('yyyy-MM-dd');
//   TextEditingController dateForController4 = TextEditingController();

//   // ---
//   String dayDeparture;
//   String dayReturn;
//   String dateDep;
//   String dateRet;
//   String depformat;
//   String retformat;
//   TravellerClass paxinfo;
//   // OverlayEntry _overlayEntry;
//   GlobalKey<DropdownSearchState<String>> key = GlobalKey();
//   GlobalKey _key = GlobalKey();
//   String selectedValue = "Select an option";
//   String city = 'Select a location';
//   String address = '';
//   String city1 = 'Select a location';
//   String address1 = '';
//   String from_code = '';
//   String to_code = '';
//   LocationData dropdownvalue;
//   LocationData dropdownvalue1;
//   LocationData dropdownvalue3;
//   LocationData dropdownvalue4;
//   List<LocationData> locationList = [];

//   bool isoneway = false;
//   bool isreturn = false;
//   bool ismulticity = false;

//   DateTime selectedDate = DateTime.now();
//   TextEditingController dateController = TextEditingController();
//   final DateFormat formatter = DateFormat('dd-MM-yyyy');
//   final DateFormat reverseDtFormatter = DateFormat('yyyy-MM-dd');
//   TextEditingController dateForController = TextEditingController();
//   DateTime selectedDate1 = DateTime.now();
//   TextEditingController date1Controller = TextEditingController();
//   final DateFormat formatter1 = DateFormat('dd-MM-yyyy');
//   final DateFormat reverseDtFormatter1 = DateFormat('yyyy-MM-dd');
//   TextEditingController dateForController1 = TextEditingController();
//   int selectedCount;
//   // int selectedNumber = 1;
//   int selectedNumberChild = 1;
//   int selectedNumberInfant = 1;
//   TravellerClass traveller_class;



