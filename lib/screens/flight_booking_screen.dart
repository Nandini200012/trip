// import 'package:dropdown_search/dropdown_search.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip/screens/constant.dart';
import 'package:trip/screens/flight_model/multicity_route_model.dart';

import 'package:trip/widgets/Travel_class.dart';
import 'package:trip/widgets/children_count.dart';
import '../api_services/location_list_api.dart';
import '../constants/fonts.dart';
import '../widgets/ault_count.dart';
import '../widgets/infants_count.dart';
import 'Drawer.dart';
import 'header.dart';

class FlightBookingPage extends StatefulWidget {
  List<LocationData> locationList1;
  FlightBookingPage({Key key, this.locationList1}) : super(key: key);

  @override
  _FlightBookingPageState createState() => _FlightBookingPageState();
}

class _FlightBookingPageState extends State<FlightBookingPage>
    with TickerProviderStateMixin {
  OverlayEntry _overlayEntry;
  String selectedRadioButton = 'One Way';
  String selectedRadioButton1 = 'One Way';
  String selectedRadioButton2 = 'Domestic';
  bool showTextField = false;
  bool showTextField1 = false;
  bool textCity1 = true;
  bool adrsCity1 = true;
  bool textCity2 = true;
  bool adrsCity2 = true;
  // multicity 4&5
  // 4
  // ----
  bool show_multicity41 = false;
  bool show_multicity51 = false;
  bool textCity_41 = true;
  bool adrsCity_41 = true;
  bool text41city = true;
  bool adrs41City = true;
  // multicity
  bool show_multicity3 = false;
  bool show_multicity4 = false;
  bool show_multicity5 = false;
  bool showTextField3 = false;
  bool showTextField4 = false;
  bool textCity3 = true;
  bool adrsCity3 = true;
  bool textCity4 = true;
  bool adrsCity4 = true;
  String city3 = "Select an option";
  String address3 = '';
  String city4 = "Select an option";

  String address4 = '';
  String from_code1 = '';
  String to_code1 = '';
  String dayDeparture1;
  String dayReturn1;
  String dateDep1;
  String dateRet1;
  String depformat1;
  String retformat1;
  DateTime selectedDate3 = DateTime.now();
  TextEditingController dateController3 = TextEditingController();
  final DateFormat formatter3 = DateFormat('dd-MM-yyyy');
  final DateFormat reverseDtFormatter3 = DateFormat('yyyy-MM-dd');
  TextEditingController dateForController3 = TextEditingController();

  DateTime selectedDate4 = DateTime.now();
  TextEditingController date1Controller3 = TextEditingController();
  final DateFormat formatter4 = DateFormat('dd-MM-yyyy');
  final DateFormat reverseDtFormatter4 = DateFormat('yyyy-MM-dd');
  TextEditingController dateForController4 = TextEditingController();
  TextEditingController dateController52 = TextEditingController();
  int formDataIndices = 0;
  // ---

  // multicity3
  // bool show_multicity3 = false;
  // bool show_multicity4 = false;
  // bool show_multicity5 = false;
  bool showTextField31 = false;
  bool showTextField41 = false;
  bool textCity31 = true;
  bool adrsCity31 = true;
  bool textCity41 = true;
  bool adrsCity41 = true;
  String city31 = "Select an option";
  String address31 = '';
  String city41 = "Select an option";
  String address41 = '';
  String from_code11 = '';
  String to_code11 = '';
  String dayDeparture11;
  String dayReturn11;
  String dateDep11;
  String dateRet11;
  String depformat11;
  String retformat11;

  String dayDeparture42;
  String dayReturn42;
  String dateDep42;
  String dateRet42;
  String depformat422;
  String retformat42;

  String dayDeparture52;
  String dayReturn52;
  String dateDep52;
  String dateRet52;
  String depformat52;
  String retformat52;

  final DateFormat formatter42 = DateFormat('dd-MM-yyyy');
  final DateFormat formatter52 = DateFormat('dd-MM-yyyy');
  final DateFormat reverseDtFormatter42 = DateFormat('yyyy-MM-dd');
  TextEditingController dateForController42 = TextEditingController();
  final DateFormat reverseDtFormatter52 = DateFormat('yyyy-MM-dd');
  TextEditingController dateForController52 = TextEditingController();

  DateTime selectedDate31 = DateTime.now();
  DateTime selectedDate42 = DateTime.now();
  DateTime selectedDate52 = DateTime.now();
  TextEditingController dateController31 = TextEditingController();
  final DateFormat formatter31 = DateFormat('dd-MM-yyyy');
  final DateFormat reverseDtFormatter31 = DateFormat('yyyy-MM-dd');
  TextEditingController dateForController31 = TextEditingController();

  DateTime selectedDate41 = DateTime.now();
  TextEditingController date1Controller31 = TextEditingController();
  final DateFormat formatter41 = DateFormat('dd-MM-yyyy');
  final DateFormat reverseDtFormatter41 = DateFormat('yyyy-MM-dd');
  TextEditingController dateForController41 = TextEditingController();
  LocationData dropdownvalue31;
  LocationData dropdownvalue41;
  LocationData drop42downvalue;
  LocationData drop41downvalue;
  String c41ity = "Select an option";
  String c42ity = "Select an option";
  String add41ress = "Select an option";
  String add42ress = "Select an option";
  String c51ity = "Select an option";
  String c52ity = "Select an option";
  String add51ress = "Select an option";
  String add52ress = "Select an option";
  String from51code = "";
  String to52code = "";
  String from41code = "";
  String to42code = "";
  bool adrs51city = false;
  bool adrs52city = false;
  bool show41TextField = false;
  bool show52TextField = false;
  bool text52City = true;
  bool text51City = false;
  bool adrs42city = false;
  bool show42TextField = true;
  bool showTextField51 = true;
  bool text42City = true;
  TextEditingController date42Controller = TextEditingController();
  TextEditingController date52Controller = TextEditingController();
// String day42Departure =
// int formDataIndices = 0;
  // ---

  String dayDeparture;
  String dayReturn;
  String dateDep;
  String dateRet;
  String depformat;
  String depformat42;

  String retformat;
  TravellerClass paxinfo =
      TravellerClass(adult: '1', Children: '0', Infants: '0', Class: 'economy');
  // OverlayEntry _overlayEntry;
  GlobalKey<DropdownSearchState<String>> key = GlobalKey();
  GlobalKey _key = GlobalKey();
  String selectedValue = "Select an option";
  String city = "Delhi";
  String address = 'Delhi India Gandhi Intl';
  String city1 = "Mumbai";
  String address1 = '';
  String from_code = 'DEL';
  String to_code = 'BOM';
  LocationData dropdownvalue;
  LocationData dropdownvalue1;
  LocationData dropdownvalue3;
  LocationData dropdownvalue4;
  LocationData dropdownvalue51;
  LocationData dropdownvalue52;
  List<LocationData> locationList = [];

  bool isoneway = false;
  bool isreturn = false;
  bool ismulticity = false;

// expanded
  bool mulheight = false;
  bool mulheight3 = false;
  bool mulheight4 = false;
  bool mulheight5 = false;

  bool show_multicity3_delete = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final DateFormat reverseDtFormatter = DateFormat('yyyy-MM-dd');
  TextEditingController dateForController = TextEditingController();
  DateTime selectedDate1 = DateTime.now();
  TextEditingController date1Controller = TextEditingController();
  final DateFormat formatter1 = DateFormat('dd-MM-yyyy');
  final DateFormat reverseDtFormatter1 = DateFormat('yyyy-MM-dd');
  TextEditingController dateForController1 = TextEditingController();
  int selectedCount;
  // int selectedNumber = 1;
  int selectedNumberChild = 1;
  int selectedNumberInfant = 1;
  TravellerClass traveller_class;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationList();
    selectedCount = 1;
    dateController.text = formatDate(DateTime.now());
    log("dateController.text:$dateController.text");
    depformat = formatData(DateTime.now());
    ;
    log("  depformat:$depformat");
    dateForController.text = formatDate(DateTime.now());

    dateController3.text = formatDate(DateTime.now());
    dateForController3.text = formatDate(DateTime.now());

    dateController31.text = formatDate(DateTime.now());
    dateForController31.text = formatDate(DateTime.now());
    date42Controller.text = formatDate(DateTime.now());
    date52Controller.text = formatDate(DateTime.now());
    Timer(const Duration(seconds: 2), () {
      setState(() {
        // _isLoading = false;
      });
    });
  }

  getLocationList() async {
    print("getLocationList()");
    String res = await getLocationListAPI();
    LocationObj locationObj = LocationObj.fromJson(jsonDecode(res));
    setState(() {
      locationList = locationObj.data;
      print('locationlist');
      print(locationList.length);
    });

    return res;
  }

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        print('picked.day');
        print(picked.weekday);
        print(getDayName(selectedDate));
        dayDeparture = getDayName(selectedDate);
        dateDep = formatDate(selectedDate);

        dateController.text = formatter.format(selectedDate);
        print('Selected date');
        print(formatDate(selectedDate));
        print(selectedDate);
        depformat = formatData(selectedDate);
        print("formatted:$depformat");
        dateForController.text = reverseDtFormatter.format(selectedDate);
        // _dateController.text = DateFormat.yMd().format(selectedDate);
        // visibledate=true;
      });
  }

// multi dep
  void _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate3,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate3 = picked;
        print('picked.day');
        print(picked.weekday);
        print(getDayName(selectedDate3));
        dayDeparture1 = getDayName(selectedDate3);
        dateDep1 = formatDate(selectedDate3);

        dateController3.text = formatter3.format(selectedDate3);
        print('Selected date');
        print(formatDate(selectedDate3));
        print(selectedDate3);
        depformat1 = formatData(selectedDate3);
        print("formatted:$depformat1");
        dateForController3.text = reverseDtFormatter3.format(selectedDate3);
        // _dateController.text = DateFormat.yMd().format(selectedDate);
        // visibledate=true;
      });
  }

// multi 3

  void _selectDate3(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate31,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate31 = picked;
        print('picked.day');
        print(picked.weekday);
        print(getDayName(selectedDate31));
        dayDeparture11 = getDayName(selectedDate31);
        dateDep11 = formatDate(selectedDate31);

        dateController31.text = formatter31.format(selectedDate31);
        print('Selected date');
        print(formatDate(selectedDate31));
        print(selectedDate31);
        depformat11 = formatData(selectedDate31);
        print("formatted 3:$depformat11");
        dateForController31.text = reverseDtFormatter31.format(selectedDate31);
        // _dateController.text = DateFormat.yMd().format(selectedDate);
        // visibledate=true;
      });
  }

// multi4
  void _selectDate4(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate42,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate42 = picked;
        print('picked.day');
        print(picked.weekday);
        print(getDayName(selectedDate42));
        dayDeparture42 = getDayName(selectedDate42);
        dateDep42 = formatDate(selectedDate42);

        date42Controller.text = formatter42.format(selectedDate42);
        print('Selected date');
        print(formatDate(selectedDate42));
        print(selectedDate42);
        depformat42 = formatData(selectedDate42);
        print("formatted 3:$depformat42");
        dateForController42.text = reverseDtFormatter42.format(selectedDate42);
        // _dateController.text = DateFormat.yMd().format(selectedDate);
        // visibledate=true;
      });
  }

// multi5
  void _selectDate5(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate52,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate52 = picked;
        print('picked.day');
        print(picked.weekday);
        print(getDayName(selectedDate31));
        dayDeparture52 = getDayName(selectedDate52);
        dateDep52 = formatDate(selectedDate52);

        date52Controller.text = formatter52.format(selectedDate52);
        print('Selected date');
        print(formatDate(selectedDate52));
        print(selectedDate52);
        depformat52 = formatData(selectedDate52);
        print("formatted 3:$depformat52");
        dateForController52.text = reverseDtFormatter52.format(selectedDate52);
        // _dateController.text = DateFormat.yMd().format(selectedDate);
        // visibledate=true;
      });
  }

  String getDayName(DateTime date) {
    return DateFormat('EEEE').format(date); // EEEE represents the full day name
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yy').format(date);
  }

  String formatData(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

//  multi return
  void _selectDateReturn1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate4,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate4 = picked;
        dayReturn1 = getDayName(selectedDate4);
        dateRet1 = formatDate(selectedDate4);

        date1Controller3.text = formatter4.format(selectedDate4);
        print('Selected date');
        print(selectedDate4);
        retformat1 = formatData(selectedDate4);
        print("retformat:$retformat1");
        dateForController4.text = reverseDtFormatter4.format(selectedDate4);
        // _dateController.text = DateFormat.yMd().format(selectedDate);
        // visibledate=true;
      });
  }

  void _selectDateReturn(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate1,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate1 = picked;
        dayReturn = getDayName(selectedDate1);
        dateRet = formatDate(selectedDate1);

        date1Controller.text = formatter1.format(selectedDate1);
        print('Selected date');
        print(selectedDate1);
        retformat = formatData(selectedDate1);
        print("retformat:$retformat");
        dateForController1.text = reverseDtFormatter1.format(selectedDate1);
        // _dateController.text = DateFormat.yMd().format(selectedDate);
        // visibledate=true;
      });
  }

  @override
  Widget build(BuildContext context) {
    // expanded width
//  mulheight=MediaQuery.of(context).size.height* 0.35;
    final sHeight = MediaQuery.of(context).size.height;
    final sWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        //  Color(0xFF0d2b4d),
        appBar: sWidth < 600
            ? AppBar(
                iconTheme: const IconThemeData(color: Colors.black, size: 40),
                backgroundColor: Colors.white,
                title: Text(
                  'Tour',
                  style: blackB15,
                ),
              )
            : CustomAppBar(),
        drawer: sWidth < 700 ? drawer() : null,
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Container(
              height: mulheight
                  ? (mulheight3
                      ? (mulheight5
                          ? sHeight + 250
                          : (mulheight4 ? sHeight + 110 : sHeight * 0.86))
                      : sHeight * 0.7)
                  : sHeight * 0.45,
              // mulheight?:

              width: sWidth,
              color: Colors.black,
              child: Opacity(
                opacity: 0.6,
                child: Image.network(
                  'https://images.hdqwalls.com/download/1/airplane-flying-over-beach-shore-sunset-5k-l9.jpg',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    height: mulheight
                        ? (mulheight3
                            ? (mulheight5
                                ? sHeight * 1.165
                                : (mulheight4
                                    ? sHeight * 0.99
                                    : sHeight * 0.75))
                            : sHeight * 0.565)
                        : sHeight * 0.35,
                    // sHeight * 0.35,
                    width: sWidth * 0.85,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(35, 15, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  value: 'One Way',
                                  groupValue: selectedRadioButton,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadioButton = value.toString();
                                      isoneway = true;
                                      ismulticity = false;
                                      isreturn = false;
                                      mulheight = false;
                                      mulheight3 = false;
                                      mulheight4 = false;
                                    });
                                  },
                                ),
                                Text(
                                  'One Way',
                                  style: rajdhani15W5,
                                ),
                                Radio(
                                  value: 'Round Trip',
                                  groupValue: selectedRadioButton,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadioButton = value.toString();
                                      isoneway = false;
                                      ismulticity = false;
                                      isreturn = true;
                                      mulheight = false;
                                      mulheight3 = false;
                                      mulheight4 = false;
                                    });
                                  },
                                ),
                                Text(
                                  'Round Trip',
                                  style: rajdhani15W5,
                                ),
                                Radio(
                                  value: 'Multi City',
                                  groupValue: selectedRadioButton,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadioButton = value.toString();
                                      isoneway = false;
                                      ismulticity = true;
                                      isreturn = false;
                                      mulheight = true;
                                    });
                                  },
                                ),
                                Text(
                                  'Multi City',
                                  style: rajdhani15W5,
                                ),
                                Spacer(),
                                Text(
                                  'Book International and Domestic Flights',
                                  style: rajdhaniB12,
                                ),
                                SizedBox(
                                  width: 35,
                                )
                              ],
                            ),
                          ),

                          Visibility(
                            // visible: isoneway,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 0.3),
                                    borderRadius: BorderRadius.circular(8)),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showTextField = true;
                                              textCity1 = false;
                                              adrsCity1 = false;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'From',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: textCity2,
                                                    child: SizedBox(height: 8)),
                                                Visibility(
                                                  visible: textCity2,
                                                  child: Text(
                                                    city,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                // Text(widget.locationList1.length.toString()),
                                                Expanded(
                                                  child: Visibility(
                                                    visible: showTextField,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: DropdownSearch<
                                                          LocationData>(
                                                        // mode: Mode.MENU,
                                                        // showSearchBox: true,
                                                        compareFn: (LocationData
                                                                item,
                                                            LocationData
                                                                selectedItem) {
                                                          return item ==
                                                              selectedItem;
                                                        },
                                                        popupProps:
                                                            PopupProps.menu(
                                                          showSearchBox: true,
                                                          showSelectedItems:
                                                              true,
                                                        ),
                                                        dropdownDecoratorProps:
                                                            DropDownDecoratorProps(
                                                          dropdownSearchDecoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Search for a location',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                        items: widget
                                                            .locationList1,
                                                        // label: 'Location',
                                                        onChanged: (value) {
                                                          setState(() {
                                                            dropdownvalue =
                                                                value;
                                                            showTextField =
                                                                false;
                                                            textCity1 = true;
                                                            adrsCity1 = true;
                                                            city = value.city;
                                                            address =
                                                                value.name;
                                                            from_code =
                                                                value.code;
                                                            print(
                                                                "code: $from_code");
                                                            print(
                                                                'city - $city');
                                                            print(
                                                                'address - $address');
                                                          });
                                                        },
                                                        selectedItem:
                                                            dropdownvalue,
                                                        itemAsString:
                                                            (LocationData
                                                                    location) =>
                                                                location.name,
                                                      ),
                                                      // DropdownSearch<String>(
                                                      //   popupProps: PopupProps.menu(
                                                      //     showSearchBox: true,
                                                      //     showSelectedItems: true,
                                                      //   ),
                                                      //   dropdownDecoratorProps: DropDownDecoratorProps(
                                                      //     dropdownSearchDecoration: InputDecoration(
                                                      //       // labelText: "Menu mode",
                                                      //       hintText: "Select City",
                                                      //     ),
                                                      //   ),
                                                      //   items:
                                                      //   ["New Delhi", "Mumbai", "Pune"],
                                                      //   onChanged: (value) {
                                                      //     setState(() {
                                                      //       city = value;
                                                      //       showTextField = false;
                                                      //       textCity1 = true;
                                                      //       adrsCity1 = true;
                                                      //     });
                                                      //   },
                                                      //   selectedItem: 'New Delhi',
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: adrsCity1,
                                                    child: SizedBox(height: 4)),
                                                Visibility(
                                                  visible: adrsCity1,
                                                  child: Text(
                                                    address /*'DEL,Indira International Airport'*/,
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showTextField1 = true;
                                              textCity2 = false;
                                              adrsCity2 = false;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'To',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: textCity2,
                                                    child: SizedBox(height: 8)),
                                                Visibility(
                                                  visible: textCity2,
                                                  child: Text(
                                                    city1,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                // Text(widget.locationList1.length.toString()),
                                                Expanded(
                                                  child: Visibility(
                                                    visible: showTextField1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: DropdownSearch<
                                                          LocationData>(
                                                        compareFn: (LocationData
                                                                item,
                                                            LocationData
                                                                selectedItem) {
                                                          return item ==
                                                              selectedItem;
                                                        },
                                                        popupProps:
                                                            PopupProps.menu(
                                                          showSearchBox: true,
                                                          showSelectedItems:
                                                              true,
                                                        ),
                                                        dropdownDecoratorProps:
                                                            DropDownDecoratorProps(
                                                          dropdownSearchDecoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Search for a location',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                        items: locationList,
                                                        // label: 'Location',
                                                        onChanged: (value) {
                                                          setState(() {
                                                            dropdownvalue1 =
                                                                value;
                                                            showTextField1 =
                                                                false;
                                                            textCity2 = true;
                                                            adrsCity1 = true;
                                                            city1 = value.city;
                                                            address1 =
                                                                value.name;
                                                            to_code =
                                                                value.code;
                                                            print(
                                                                "code:$to_code");
                                                            print(
                                                                'city - $city1');
                                                            print(
                                                                'address - $address1');
                                                          });
                                                        },
                                                        selectedItem:
                                                            dropdownvalue1,
                                                        itemAsString:
                                                            (LocationData
                                                                    location) =>
                                                                location.name,
                                                      ),
                                                      // DropdownSearch<String>(
                                                      //   popupProps: PopupProps.menu(
                                                      //     showSearchBox: true,
                                                      //     showSelectedItems: true,
                                                      //   ),
                                                      //   dropdownDecoratorProps: DropDownDecoratorProps(
                                                      //     dropdownSearchDecoration: InputDecoration(
                                                      //       // labelText: "Menu mode",
                                                      //       hintText: "Select City",
                                                      //     ),
                                                      //   ),
                                                      //   items:
                                                      //   ["New Delhi", "Mumbai", "Pune"],
                                                      //   onChanged: (value) {
                                                      //     setState(() {
                                                      //       city = value;
                                                      //       showTextField = false;
                                                      //       textCity1 = true;
                                                      //       adrsCity1 = true;
                                                      //     });
                                                      //   },
                                                      //   selectedItem: 'New Delhi',
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: adrsCity2,
                                                    child: SizedBox(height: 4)),
                                                Visibility(
                                                  visible: adrsCity2,
                                                  child: Text(
                                                    address1 /*'DEL,Indira International Airport'*/,
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectDate(context);
                                              // showTextField = true;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Departure',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  dateDep ??
                                                      dateController.text,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                // Visibility(
                                                //   visible: showTextField,
                                                //   child: Padding(
                                                //     padding: EdgeInsets.all(16.0),
                                                //     child: TextField(
                                                //       decoration: InputDecoration(
                                                //         labelText: 'Enter Text',
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                SizedBox(height: 4),
                                                Text(
                                                  dayDeparture ?? '',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                          visible: isreturn,
                                          child: VerticalDivider()),
                                      Visibility(
                                        visible: isreturn,
                                        child: Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // showTextField = true;
                                                _selectDateReturn(context);
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Return',
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    dateRet ??
                                                        dateForController.text,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    dayReturn ?? '',
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        child: GestureDetector(
                                          onTapDown: (details) {
                                            // TravellerCountOverlay();
                                            // setState(() {
                                            // showTextField = true;
                                            traveller_class =
                                                showTravellerCount(context,
                                                    details.globalPosition);
                                            // });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Traveler & Class',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${total_count(paxinfo)} ',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Travellers',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // Visibility(
                                                //   visible: showTextField,
                                                //   child: Padding(
                                                //     padding: EdgeInsets.all(16.0),
                                                //     child: TextField(
                                                //       decoration: InputDecoration(
                                                //         labelText: 'Enter Text',
                                                //       ),
                                                //     ),
                                                //   ),
                                                // ),
                                                SizedBox(height: 4),
                                                Text(
                                                  paxinfo != null
                                                      ? " ${paxinfo.Class}"
                                                      : 'Economy',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // multi
                          Visibility(
                              visible: ismulticity,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.3),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: IntrinsicHeight(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showTextField3 = true;
                                                    textCity3 = false;
                                                    adrsCity3 = false;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'From',
                                                        style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Visibility(
                                                          visible: textCity4,
                                                          child: SizedBox(
                                                              height: 8)),
                                                      Visibility(
                                                        visible: textCity4,
                                                        child: Text(
                                                          city3,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                      // Text(widget.locationList1.length.toString()),
                                                      Expanded(
                                                        child: Visibility(
                                                          visible:
                                                              showTextField3,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: DropdownSearch<
                                                                LocationData>(
                                                              // mode: Mode.MENU,
                                                              // showSearchBox: true,
                                                              compareFn: (LocationData
                                                                      item1,
                                                                  LocationData
                                                                      selectedItem3) {
                                                                return item1 ==
                                                                    selectedItem3;
                                                              },
                                                              popupProps:
                                                                  PopupProps
                                                                      .menu(
                                                                showSearchBox:
                                                                    true,
                                                                showSelectedItems:
                                                                    true,
                                                              ),
                                                              dropdownDecoratorProps:
                                                                  DropDownDecoratorProps(
                                                                dropdownSearchDecoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Search for a location',
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                ),
                                                              ),
                                                              items: widget
                                                                  .locationList1,
                                                              // label: 'Location',
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  dropdownvalue3 =
                                                                      value;
                                                                  showTextField3 =
                                                                      false;
                                                                  textCity3 =
                                                                      true;
                                                                  adrsCity3 =
                                                                      true;
                                                                  city3 = value
                                                                      .city;
                                                                  address3 =
                                                                      value
                                                                          .name;
                                                                  from_code1 =
                                                                      value
                                                                          .code;
                                                                  print(
                                                                      "code: $from_code1");
                                                                  print(
                                                                      'city - $city3');
                                                                  print(
                                                                      'address - $address3');
                                                                });
                                                              },
                                                              selectedItem:
                                                                  dropdownvalue3,
                                                              itemAsString:
                                                                  (LocationData
                                                                          location3) =>
                                                                      location3
                                                                          .name,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                          visible: adrsCity3,
                                                          child: SizedBox(
                                                              height: 4)),
                                                      Visibility(
                                                        visible: adrsCity3,
                                                        child: Text(
                                                          address3 /*'DEL,Indira International Airport'*/,
                                                          style: TextStyle(
                                                            // fontWeight: FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showTextField4 = true;
                                                    textCity4 = false;
                                                    adrsCity4 = false;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'To',
                                                        style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Visibility(
                                                          visible: textCity4,
                                                          child: SizedBox(
                                                              height: 8)),
                                                      Visibility(
                                                        visible: textCity4,
                                                        child: Text(
                                                          city4,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                      // Text(widget.locationList1.length.toString()),
                                                      Expanded(
                                                        child: Visibility(
                                                          visible:
                                                              showTextField4,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: DropdownSearch<
                                                                LocationData>(
                                                              compareFn: (LocationData
                                                                      item,
                                                                  LocationData
                                                                      selectedItem) {
                                                                return item ==
                                                                    selectedItem;
                                                              },
                                                              popupProps:
                                                                  PopupProps
                                                                      .menu(
                                                                showSearchBox:
                                                                    true,
                                                                showSelectedItems:
                                                                    true,
                                                              ),
                                                              dropdownDecoratorProps:
                                                                  DropDownDecoratorProps(
                                                                dropdownSearchDecoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Search for a location',
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                ),
                                                              ),
                                                              items:
                                                                  locationList,
                                                              // label: 'Location',
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  dropdownvalue4 =
                                                                      value;
                                                                  showTextField4 =
                                                                      false;
                                                                  textCity4 =
                                                                      true;
                                                                  adrsCity4 =
                                                                      true;
                                                                  city4 = value
                                                                      .city;
                                                                  address4 =
                                                                      value
                                                                          .name;
                                                                  to_code1 =
                                                                      value
                                                                          .code;
                                                                  print(
                                                                      "code:$to_code");
                                                                  print(
                                                                      'city - $city4');
                                                                  print(
                                                                      'address - $address4');
                                                                });
                                                              },
                                                              selectedItem:
                                                                  dropdownvalue4,
                                                              itemAsString:
                                                                  (LocationData
                                                                          location4) =>
                                                                      location4
                                                                          .name,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                          visible: adrsCity4,
                                                          child: SizedBox(
                                                              height: 4)),
                                                      Visibility(
                                                        visible: adrsCity4,
                                                        child: Text(
                                                          address4 /*'DEL,Indira International Airport'*/,
                                                          style: TextStyle(
                                                            // fontWeight: FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _selectDate1(context);
                                                    // showTextField = true;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Departure',
                                                        style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Text(
                                                        dateDep1 ??
                                                            dateController3
                                                                .text,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        dayDeparture1 ?? '',
                                                        style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]))))),

                          // multi3

                          Visibility(
                            visible: show_multicity3,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 0.5),
                                    borderRadius: BorderRadius.circular(8)),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showTextField31 = true;
                                              textCity31 = false;
                                              adrsCity31 = false;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'From',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: textCity41,
                                                    child: SizedBox(height: 8)),
                                                Visibility(
                                                  visible: textCity41,
                                                  child: Text(
                                                    city31,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Text(widget.locationList1.length
                                                    .toString()),
                                                Expanded(
                                                  child: Visibility(
                                                    visible: showTextField31,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: DropdownSearch<
                                                          LocationData>(
                                                        // mode: Mode.MENU,
                                                        // showSearchBox: true,
                                                        compareFn: (LocationData
                                                                item,
                                                            LocationData
                                                                selectedItem) {
                                                          return item ==
                                                              selectedItem;
                                                        },
                                                        popupProps:
                                                            PopupProps.menu(
                                                          showSearchBox: true,
                                                          showSelectedItems:
                                                              true,
                                                        ),
                                                        dropdownDecoratorProps:
                                                            DropDownDecoratorProps(
                                                          dropdownSearchDecoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Search for a location',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                        items: widget
                                                            .locationList1,
                                                        // label: 'Location',
                                                        onChanged: (value) {
                                                          setState(() {
                                                            dropdownvalue31 =
                                                                value;
                                                            showTextField31 =
                                                                false;
                                                            textCity31 = true;
                                                            adrsCity31 = true;
                                                            city31 = value.city;
                                                            address31 =
                                                                value.name;
                                                            from_code11 =
                                                                value.code;
                                                            print(
                                                                "code: $from_code11");
                                                            print(
                                                                'city - $city31');
                                                            print(
                                                                'address - $address31');
                                                          });
                                                        },
                                                        selectedItem:
                                                            dropdownvalue31,
                                                        itemAsString:
                                                            (LocationData
                                                                    location) =>
                                                                location.name,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: adrsCity41,
                                                    child: SizedBox(height: 4)),
                                                Visibility(
                                                  visible: adrsCity41,
                                                  child: Text(
                                                    address1 /*'DEL,Indira International Airport'*/,
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showTextField41 = true;
                                              textCity41 = false;
                                              adrsCity41 = false;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'To',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: textCity41,
                                                    child: SizedBox(height: 8)),
                                                Visibility(
                                                  visible: textCity41,
                                                  child: Text(
                                                    city41,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                // Text(widget.locationList1.length.toString()),
                                                Expanded(
                                                  child: Visibility(
                                                    visible: showTextField41,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: DropdownSearch<
                                                          LocationData>(
                                                        compareFn: (LocationData
                                                                item,
                                                            LocationData
                                                                selectedItem) {
                                                          return item ==
                                                              selectedItem;
                                                        },
                                                        popupProps:
                                                            PopupProps.menu(
                                                          showSearchBox: true,
                                                          showSelectedItems:
                                                              true,
                                                        ),
                                                        dropdownDecoratorProps:
                                                            DropDownDecoratorProps(
                                                          dropdownSearchDecoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Search for a location',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                        items: locationList,
                                                        // label: 'Location',
                                                        onChanged: (value) {
                                                          setState(() {
                                                            dropdownvalue41 =
                                                                value;
                                                            showTextField41 =
                                                                false;
                                                            textCity41 = true;
                                                            adrsCity41 = true;
                                                            city41 = value.city;
                                                            address41 =
                                                                value.name;
                                                            to_code11 =
                                                                value.code;
                                                            print(
                                                                "code:$to_code11");
                                                            print(
                                                                'city - $city41');
                                                            print(
                                                                'address - $address41');
                                                          });
                                                        },
                                                        selectedItem:
                                                            dropdownvalue41,
                                                        itemAsString:
                                                            (LocationData
                                                                    location41) =>
                                                                location41.name,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: adrsCity41,
                                                    child: SizedBox(height: 4)),
                                                Visibility(
                                                  visible: adrsCity41,
                                                  child: Text(
                                                    address41 /*'DEL,Indira International Airport'*/,
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectDate3(context);
                                              // showTextField = true;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Departure',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  dateDep11 ??
                                                      dateController31.text,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  dayDeparture11 ?? '',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: show_multicity3_delete,
                                child: IconButton(
                                  icon: Icon(Icons.delete,
                                      size: 18, color: Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      if (formDataIndices >= 1) {
                                        show_multicity3_delete = false;
                                        show_multicity3 = false;
                                        formDataIndices -= 1;
                                        mulheight3 = false;
                                      }
                                      print("delete");
                                      print("isShow3: $show_multicity3");
                                      print("formindices: $formDataIndices");
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: show_multicity3_delete,
                            child: SizedBox(
                              height: 10,
                            ),
                          ),

                          // multi4

                          Visibility(
                            visible: show_multicity4,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 0.5),
                                    borderRadius: BorderRadius.circular(8)),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              show41TextField = true;
                                              textCity_41 = false;
                                              adrsCity_41 = false;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'From',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: textCity_41,
                                                    child: SizedBox(height: 8)),
                                                Visibility(
                                                  visible: textCity_41,
                                                  child: Text(
                                                    c41ity,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Text(widget.locationList1.length
                                                    .toString()),
                                                Expanded(
                                                  child: Visibility(
                                                    visible: show41TextField,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: DropdownSearch<
                                                          LocationData>(
                                                        // mode: Mode.MENU,
                                                        // showSearchBox: true,
                                                        compareFn: (LocationData
                                                                item,
                                                            LocationData
                                                                selectedItem41) {
                                                          return item ==
                                                              selectedItem41;
                                                        },
                                                        popupProps:
                                                            PopupProps.menu(
                                                          showSearchBox: true,
                                                          showSelectedItems:
                                                              true,
                                                        ),
                                                        dropdownDecoratorProps:
                                                            DropDownDecoratorProps(
                                                          dropdownSearchDecoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Search for a location',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                        items: widget
                                                            .locationList1,
                                                        // label: 'Location',
                                                        onChanged: (value) {
                                                          setState(() {
                                                            drop41downvalue =
                                                                value;
                                                            show41TextField =
                                                                false;
                                                            textCity_41 = true;
                                                            adrsCity_41 = true;
                                                            c41ity = value.city;
                                                            add41ress =
                                                                value.name;
                                                            from41code =
                                                                value.code;
                                                            print(
                                                                "code: $from41code");
                                                            print(
                                                                'city - $c41ity');
                                                            print(
                                                                'address - $add41ress');
                                                          });
                                                        },
                                                        selectedItem:
                                                            drop41downvalue,
                                                        itemAsString:
                                                            (LocationData
                                                                    location) =>
                                                                location.name,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: adrsCity_41,
                                                    child: SizedBox(height: 4)),
                                                Visibility(
                                                  visible: adrsCity_41,
                                                  child: Text(
                                                    address1 /*'DEL,Indira International Airport'*/,
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              show42TextField = true;
                                              text42City = false;
                                              adrs42city = false;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'To',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: text42City,
                                                    child: SizedBox(height: 8)),
                                                Visibility(
                                                  visible: text42City,
                                                  child: Text(
                                                    c42ity,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                // Text(widget.locationList1.length.toString()),
                                                Expanded(
                                                  child: Visibility(
                                                    visible: show42TextField,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
                                                      child: DropdownSearch<
                                                          LocationData>(
                                                        compareFn: (LocationData
                                                                item,
                                                            LocationData
                                                                selectedItem) {
                                                          return item ==
                                                              selectedItem;
                                                        },
                                                        popupProps:
                                                            PopupProps.menu(
                                                          showSearchBox: true,
                                                          showSelectedItems:
                                                              true,
                                                        ),
                                                        dropdownDecoratorProps:
                                                            DropDownDecoratorProps(
                                                          dropdownSearchDecoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Search for a location',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                        items: locationList,
                                                        // label: 'Location',
                                                        onChanged: (value) {
                                                          setState(() {
                                                            drop42downvalue =
                                                                value;
                                                            show42TextField =
                                                                false;
                                                            text42City = true;
                                                            adrs42city = true;
                                                            c42ity = value.city;
                                                            add42ress =
                                                                value.name;
                                                            to42code =
                                                                value.code;
                                                            print(
                                                                "code:$to42code");
                                                            print(
                                                                'city - $c42ity');
                                                            print(
                                                                'address - $add42ress');
                                                          });
                                                        },
                                                        selectedItem:
                                                            drop42downvalue,
                                                        itemAsString:
                                                            (LocationData
                                                                    location4) =>
                                                                location4.name,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: adrs42city,
                                                    child: SizedBox(height: 4)),
                                                Visibility(
                                                  visible: adrs42city,
                                                  child: Text(
                                                    address4 /*'DEL,Indira International Airport'*/,
                                                    style: TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectDate4(context);
                                              // showTextField = true;
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Departure',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  dateDep ??
                                                      date42Controller.text,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  dayDeparture ?? '',
                                                  style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: show_multicity4,
                                child: IconButton(
                                  icon: Icon(Icons.delete,
                                      size: 18, color: Colors.grey),
                                  onPressed: () {
                                    setState(() {
                                      if (formDataIndices >= 1) {
                                        show_multicity3_delete = true;
                                        show_multicity4 = false;
                                        formDataIndices -= 1;
                                        mulheight4 = false;
                                      }
                                      print("delete");
                                      print("isShow4: $show_multicity4");
                                      print("formindices: $formDataIndices");
                                    });
                                    // setState(() {

                                    //   show_multicity4 = false;
                                    // });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: show_multicity4,
                            child: SizedBox(
                              height: 10,
                            ),
                          ),

                          // )),
                          // multi 5
                          Visibility(
                              visible: show_multicity5,
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 10, 20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.3),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: IntrinsicHeight(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showTextField51 = true;
                                                    text51City = false;
                                                    adrs51city = false;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'From',
                                                        style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Visibility(
                                                          visible: text51City,
                                                          child: SizedBox(
                                                              height: 8)),
                                                      Visibility(
                                                        visible: text51City,
                                                        child: Text(
                                                          c51ity,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                      // Text(widget.locationList1.length.toString()),
                                                      Expanded(
                                                        child: Visibility(
                                                          visible:
                                                              showTextField51,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: DropdownSearch<
                                                                LocationData>(
                                                              // mode: Mode.MENU,
                                                              // showSearchBox: true,
                                                              compareFn: (LocationData
                                                                      item1,
                                                                  LocationData
                                                                      selectedItem3) {
                                                                return item1 ==
                                                                    selectedItem3;
                                                              },
                                                              popupProps:
                                                                  PopupProps
                                                                      .menu(
                                                                showSearchBox:
                                                                    true,
                                                                showSelectedItems:
                                                                    true,
                                                              ),
                                                              dropdownDecoratorProps:
                                                                  DropDownDecoratorProps(
                                                                dropdownSearchDecoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Search for a location',
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                ),
                                                              ),
                                                              items: widget
                                                                  .locationList1,
                                                              // label: 'Location',
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  dropdownvalue51 =
                                                                      value;
                                                                  showTextField51 =
                                                                      false;
                                                                  text51City =
                                                                      true;
                                                                  adrs51city =
                                                                      true;
                                                                  c51ity = value
                                                                      .city;
                                                                  add51ress =
                                                                      value
                                                                          .name;
                                                                  from51code =
                                                                      value
                                                                          .code;
                                                                  print(
                                                                      "code: $from51code");
                                                                  print(
                                                                      'city - $c51ity');
                                                                  print(
                                                                      'address - $add51ress');
                                                                });
                                                              },
                                                              selectedItem:
                                                                  dropdownvalue51,
                                                              itemAsString:
                                                                  (LocationData
                                                                          location3) =>
                                                                      location3
                                                                          .name,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                          visible: adrs51city,
                                                          child: SizedBox(
                                                              height: 4)),
                                                      Visibility(
                                                        visible: adrs51city,
                                                        child: Text(
                                                          add51ress /*'DEL,Indira International Airport'*/,
                                                          style: TextStyle(
                                                            // fontWeight: FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    show52TextField = true;
                                                    text52City = false;
                                                    adrs52city = false;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'To',
                                                        style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Visibility(
                                                          visible: text52City,
                                                          child: SizedBox(
                                                              height: 8)),
                                                      Visibility(
                                                        visible: text52City,
                                                        child: Text(
                                                          c52ity,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                      // Text(widget.locationList1.length.toString()),
                                                      Expanded(
                                                        child: Visibility(
                                                          visible:
                                                              show52TextField,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16.0),
                                                            child: DropdownSearch<
                                                                LocationData>(
                                                              compareFn: (LocationData
                                                                      item,
                                                                  LocationData
                                                                      selectedItem) {
                                                                return item ==
                                                                    selectedItem;
                                                              },
                                                              popupProps:
                                                                  PopupProps
                                                                      .menu(
                                                                showSearchBox:
                                                                    true,
                                                                showSelectedItems:
                                                                    true,
                                                              ),
                                                              dropdownDecoratorProps:
                                                                  DropDownDecoratorProps(
                                                                dropdownSearchDecoration:
                                                                    InputDecoration(
                                                                  labelText:
                                                                      'Search for a location',
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                ),
                                                              ),
                                                              items:
                                                                  locationList,
                                                              // label: 'Location',
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  dropdownvalue52 =
                                                                      value;
                                                                  show52TextField =
                                                                      false;
                                                                  text52City =
                                                                      true;
                                                                  adrs52city =
                                                                      true;
                                                                  c52ity = value
                                                                      .city;
                                                                  add52ress =
                                                                      value
                                                                          .name;
                                                                  to52code =
                                                                      value
                                                                          .code;
                                                                  print(
                                                                      "code:$to52code");
                                                                  print(
                                                                      'city - $c52ity');
                                                                  print(
                                                                      'address - $add52ress');
                                                                });
                                                              },
                                                              selectedItem:
                                                                  dropdownvalue4,
                                                              itemAsString:
                                                                  (LocationData
                                                                          location4) =>
                                                                      location4
                                                                          .name,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Visibility(
                                                          visible: adrs52city,
                                                          child: SizedBox(
                                                              height: 4)),
                                                      Visibility(
                                                        visible: adrs52city,
                                                        child: Text(
                                                          add52ress /*'DEL,Indira International Airport'*/,
                                                          style: TextStyle(
                                                            // fontWeight: FontWeight.bold,
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            VerticalDivider(),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _selectDate5(context);
                                                    // showTextField = true;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Departure',
                                                        style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Text(
                                                        dateDep52 ??
                                                            date52Controller
                                                                .text,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Text(
                                                        dayDeparture52 ?? '',
                                                        style: TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.grey,
                                                          fontSize: 12,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]))))),

                          // -------5
                          Visibility(
                            visible: ismulticity,
                            child: Container(
                              height: 30,
                              // width: 50,
                              child:
                                  //    Padding(
                                  // padding:
                                  //     const EdgeInsets.symmetric(
                                  //         vertical: 10,
                                  //         horizontal: 30),
                                  // child:
                                  Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          onPrimary:
                                              Color.fromARGB(255, 16, 180, 234),
                                          side: BorderSide(color: Colors.blue),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (formDataIndices <= 2) {
                                              formDataIndices += 1;
                                              if (formDataIndices == 1) {
                                                show_multicity3 = true;
                                                show_multicity3_delete = true;
                                                mulheight3 = true;
                                              } else if (formDataIndices == 2) {
                                                show_multicity4 = true;
                                                show_multicity3_delete = false;
                                                mulheight4 = true;
                                              } else if (formDataIndices == 3) {
                                                show_multicity5 = true;
                                                show_multicity3_delete = false;
                                                mulheight5 = true;
                                              }
                                            }

                                            print("add");
                                            print(
                                                "show_multicity3: $show_multicity3");
                                            print(
                                                "formindices: $formDataIndices");

                                            // if ( formindices<=2)
                                            //   show_multicity3 = true;
                                          });
                                        },
                                        child: Text("Add Another City")),
                                  ),
                                ],
                              ),
                            ),
                          ),

// -----------
                          Container(
                            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                            child: Row(
                              children: [
                                Text(
                                  'Select a Type:',
                                  style: rajdhani15W5,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 'Domestic',
                                      groupValue: selectedRadioButton2,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedRadioButton2 =
                                              value.toString();
                                        });
                                      },
                                    ),
                                    Text(
                                      'Domestic',
                                      style: rajdhani15W5,
                                    ),
                                  ],
                                ),
                                Radio(
                                  value: 'International',
                                  groupValue: selectedRadioButton2,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedRadioButton2 = value.toString();
                                    });
                                  },
                                ),
                                Text(
                                  'International',
                                  style: rajdhani15W5,
                                ),
                              ],
                            ),
                          ),
                          // Positioned(
                          //   bottom: 0.0,
                          //   left: 0,
                          //   right: 0,
                          //   child: Center(
                          //     child: Container(
                          //       width: sWidth * 0.075,
                          //       height: sHeight * 0.0457,
                          //       decoration: BoxDecoration(
                          //           shape: BoxShape.rectangle,
                          //           color: Color.fromARGB(255, 81, 145, 248),
                          //           borderRadius: BorderRadius.circular(8)),
                          //       child: ElevatedButton(
                          //         style: ButtonStyle(
                          //           backgroundColor:
                          //               MaterialStateProperty.all<Color>(
                          //                   Colors.transparent),
                          //           elevation:
                          //               MaterialStateProperty.all<double>(0),
                          //           shape: MaterialStateProperty.all<
                          //               OutlinedBorder>(
                          //             RoundedRectangleBorder(
                          //               borderRadius:
                          //                   BorderRadius.circular(45.0),
                          //             ),
                          //           ),
                          //         ),
                          //  onPressed: () {
                          //   print('-------search-------');
                          //   print("travel type :$selectedRadioButton");
                          //   print("fare type: $selectedRadioButton1");
                          //   print("type:$selectedRadioButton2");
                          //   print("from: $from_code");
                          //   print("to: $to_code");
                          //   print("dayReturn: $retformat");
                          //   print("dateDep $depformat");
                          //   print("2 from: $from_code1");
                          //   print("2 to: $to_code1");
                          //   // print("dayReturn: $retformat");
                          //   print("2 dateDep $depformat1");

                          //   if (paxinfo != null) {
                          //     print("paxinfo.adult:${paxinfo.adult}");
                          //     print(
                          //         "paxinfo.Children: ${paxinfo.Children}");
                          //     print(
                          //         "paxinfo.Infants: ${paxinfo.Infants}");
                          //     print(
                          //         "paxinfo.Class: ${paxinfo.Class.toUpperCase()}");
                          //   }

                          //   if (selectedRadioButton == 'One Way') {
                          //     if (selectedRadioButton2 == 'Domestic') {
                          //       searchDomesticOneway1(
                          //           city,
                          //           city1,
                          //           paxinfo.Class.toUpperCase(),
                          //           paxinfo.adult,
                          //           paxinfo.Children,
                          //           paxinfo.Infants,
                          //           from_code,
                          //           to_code,
                          //           depformat,
                          //           total_count(paxinfo),
                          //           context);
                          //     } else {
                          //       getinter1waysearch_api(
                          //           city,
                          //           city1,
                          //           paxinfo.Class.toUpperCase(),
                          //           paxinfo.adult,
                          //           paxinfo.Children,
                          //           paxinfo.Infants,
                          //           from_code,
                          //           to_code,
                          //           depformat,
                          //           total_count(paxinfo),
                          //           context);
                          //     }
                          //   } else if (selectedRadioButton ==
                          //       'Multi City') {
                          //     if (selectedRadioButton2 == 'Domestic') {
                          //       multiRoutes.clear();
                          //       // route1
                          //       routes newroute1 = routes(
                          //         fromCode: from_code,
                          //         toCode: to_code,
                          //         date: depformat,
                          //       );
                          //       multiRoutes.add(newroute1);
                          //       print(
                          //           "Passenger 1 data: ${newroute1.fromCode},${newroute1.toCode}, ${newroute1.date}");
                          //       print(
                          //           "Passenger 2 added successfully: $newroute1");
                          //       // route2

                          //       routes newroute2 = routes(
                          //         fromCode: from_code1,
                          //         toCode: to_code1,
                          //         date: depformat1,
                          //       );
                          //       multiRoutes.add(newroute2);
                          //       print(
                          //           "Passenger 2 data: ${newroute2.fromCode},${newroute2.toCode}, ${newroute2.date}");
                          //       print(
                          //           "Passenger 2 added successfully: $newroute2");

                          //       if (show_multicity3) {
                          //         print("route3");

                          //         routes newroute3 = routes(
                          //             fromCode: from_code11,
                          //             toCode: to_code11,
                          //             date: depformat11);
                          //         multiRoutes.add(newroute3);
                          //         print(
                          //             "Passenger 3 data: ${newroute3.date}");
                          //         print(
                          //             "Passenger 3 added successfully:  ${newroute3.fromCode},${newroute3.toCode}, ${newroute3.date}");

                          //         if (show_multicity4) {
                          //           print("route4");
                          //         }
                          //       }
                          //       getMulticity(
                          //         paxinfo.Class.toUpperCase(),
                          //         paxinfo.adult,
                          //         paxinfo.Children,
                          //         paxinfo.Infants,
                          //         context,
                          //       );
                          //       // getDomestic_multiwaysearchapi(

                          //       //     3,
                          //       //     paxinfo.Class.toUpperCase(),
                          //       //     paxinfo.adult,
                          //       //     paxinfo.Children,
                          //       //     paxinfo.Infants,
                          //       //     from_code,
                          //       //     to_code,
                          //       //     depformat,
                          //       //     from_code1,
                          //       //     to_code1,
                          //       //     depformat1,
                          //       //     from_code11,
                          //       //     to_code11,
                          //       //     depformat11,
                          //       //     context);
                          //     } else {
                          //       // getinternational_multi_searchapi(
                          //       //     paxinfo.Class.toUpperCase(),
                          //       //     paxinfo.adult,
                          //       //     paxinfo.Children,
                          //       //     paxinfo.Infants,
                          //       //     from_code,
                          //       //     to_code,
                          //       //     depformat,
                          //       //     from_code1,
                          //       //     to_code1,
                          //       //     depformat1,
                          //       //     context);
                          //     }
                          //   } else {
                          //     if (selectedRadioButton2 == 'Domestic') {
                          //       getReturnSearchApi(
                          //           true,
                          //           total_count(paxinfo),
                          //           city,
                          //           city1,
                          //           paxinfo.Class.toUpperCase(),
                          //           paxinfo.adult,
                          //           paxinfo.Children,
                          //           paxinfo.Infants,
                          //           from_code,
                          //           to_code,
                          //           depformat,
                          //           retformat,
                          //           context);
                          //     } else {
                          //       getReturnSearchApi(
                          //           false,
                          //           total_count(paxinfo),
                          //           city,
                          //           city1,
                          //           paxinfo.Class.toUpperCase(),
                          //           paxinfo.adult,
                          //           paxinfo.Children,
                          //           paxinfo.Infants,
                          //           from_code,
                          //           to_code,
                          //           depformat,
                          //           retformat,
                          //           context);
                          //       // getinternational_return_search(
                          //       //     paxinfo.Class.toUpperCase(),
                          //       //     paxinfo.adult,
                          //       //     paxinfo.Children,
                          //       //     paxinfo.Infants,
                          //       //     from_code,
                          //       //     to_code,
                          //       //     depformat,
                          //       //     retformat,
                          //       //     context);
                          //     }
                          //   }
                          //         },
                          //         child: Text('Search'),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )),
            ),
            Searchcontainer(sWidth, sHeight, widget.locationList1)
          ],
        )));
    //   ),
    // ))
    // ]))
    // ]))));
  }
  void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Timer(Duration(seconds:2), () {
        Navigator.of(context).pop(); // Auto dismiss after 5 seconds
      });

      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
Searchcontainer(sWidth, sHeight, List<LocationData> locationList1) {
  return Positioned(
    bottom: mulheight ? (mulheight3 ? (mulheight4 ? 75 : 45) : 64) : 40,
    left: 660,
    child: GestureDetector(
      onTap: () {
        print('-------search-------');
        print("travel type: $selectedRadioButton");
        print("fare type: $selectedRadioButton1");
        print("type: $selectedRadioButton2");
        print("from: $from_code");
        print("to: $to_code");
        print("dayReturn: $retformat");
        print("dateDep: $depformat");
        print("2 from: $from_code1");
        print("2 to: $to_code1");
        print("2 dateDep: $depformat1");

        if (paxinfo != null) {
          print("paxinfo.adult: ${paxinfo.adult}");
          print("paxinfo.Children: ${paxinfo.Children}");
          print("paxinfo.Infants: ${paxinfo.Infants}");
          print("paxinfo.Class: ${paxinfo.Class.toUpperCase()}");
        }
// showLoadingDialog(context);
      

        if (selectedRadioButton == 'One Way') {
          if (selectedRadioButton2 == 'Domestic') {
            searchDomesticOneway1(
              widget.locationList1,
              city,
              city1,
              paxinfo.Class.toUpperCase(),
              paxinfo.adult,
              paxinfo.Children,
              paxinfo.Infants,
              from_code,
              to_code,
              depformat,
              total_count(paxinfo),
              context,
            ).catchError((error) {
              print("Error in domestic one way search: $error");
              Navigator.pop(context); // Close the loading dialog on error
              _showErrorDialog(context, "Error", "Failed to perform search.");
            });
          } else {
            searchDomesticOneway1(
              widget.locationList1,
              city,
              city1,
              paxinfo.Class.toUpperCase(),
              paxinfo.adult,
              paxinfo.Children,
              paxinfo.Infants,
              from_code,
              to_code,
              depformat,
              total_count(paxinfo),
              context,
            ).catchError((error) {
              print("Error in international one way search: $error");
              Navigator.pop(context); // Close the loading dialog on error
              _showErrorDialog(context, "Error", "Failed to perform search.");
            });
          }
        } else if (selectedRadioButton == 'Multi City') {
          multiRoutes.clear();
          routes newroute1 = routes(
            fromCode: from_code,
            toCode: to_code,
            date: depformat,
            fromcity: city,
            tocity: city1,
          );
          multiRoutes.add(newroute1);

          routes newroute2 = routes(
            fromCode: from_code1,
            toCode: to_code1,
            date: depformat1,
            fromcity: city3,
            tocity: city4,
          );
          multiRoutes.add(newroute2);

          if (show_multicity3) {
            routes newroute3 = routes(
              fromCode: from_code11,
              toCode: to_code11,
              date: depformat11,
              fromcity: city31,
              tocity: city41,
            );
            multiRoutes.add(newroute3);

            if (show_multicity4) {
              routes newroute4 = routes(
                fromCode: from41code,
                toCode: to42code,
                date: depformat42,
                fromcity: c41ity,
                tocity: c42ity,
              );
              multiRoutes.add(newroute4);
            }
            if (show_multicity5) {
              routes newroute5 = routes(
                fromCode: from51code,
                toCode: to52code,
                date: depformat52,
                fromcity: c51ity,
                tocity: c52ity,
              );
              multiRoutes.add(newroute5);
            }
          }

          if (selectedRadioButton2 == 'Domestic') {
            getMulticity(
              widget.locationList1,
              paxinfo.Class.toUpperCase(),
              paxinfo.adult,
              paxinfo.Children,
              paxinfo.Infants,
              context,
            ).catchError((error) {
              print("Error in domestic multi city search: $error");
              Navigator.pop(context); // Close the loading dialog on error
              _showErrorDialog(context, "Error", "Failed to perform search.");
            });
          } else {
            getinternational_multi_searchapi(
              widget.locationList1,
              paxinfo.Class.toUpperCase(),
              paxinfo.adult,
              paxinfo.Children,
              paxinfo.Infants,
              context,
            ).catchError((error) {
              print("Error in international multi city search: $error");
              Navigator.pop(context); // Close the loading dialog on error
              _showErrorDialog(context, "Error", "Failed to perform search.");
            });
          }
        } else {
          if (selectedRadioButton2 == 'Domestic') {
            getReturnSearchApi(
              widget.locationList1,
              true,
              total_count(paxinfo),
              city,
              city1,
              paxinfo.Class.toUpperCase(),
              paxinfo.adult,
              paxinfo.Children,
              paxinfo.Infants,
              from_code,
              to_code,
              depformat,
              retformat,context,
            );
          } else {
            getInternationalReturnSearch(
              widget.locationList1,
              total_count(paxinfo),
              city,
              city1,
              paxinfo.Class.toUpperCase(),
              paxinfo.adult,
              paxinfo.Children,
              paxinfo.Infants,
              from_code,
              to_code,
              depformat,
              retformat,
              context,
            ).catchError((error) {
              print("Error in international return search: $error");
              Navigator.pop(context); // Close the loading dialog on error
              _showErrorDialog(context, "Error", "Failed to perform search.");
            });
          }
        }
      },
      child: Container(
        height: sHeight * 0.06,
        width: sWidth * 0.153,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 44, 44, 44).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "SEARCH",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}

void _showErrorDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  // Searchcontainer(sWidth, sHeight, List<LocationData> locationList1) {
  //   return Positioned(
  //     bottom: mulheight ? (mulheight3 ? (mulheight4 ? 75 : 45) : 64) : 40,
  //     // mulheight?:,
  //     left: 660,
  //     child: GestureDetector(
  //       onTap: () {
  //         print('-------search-------');
  //         print("travel type :$selectedRadioButton");
  //         print("fare type: $selectedRadioButton1");
  //         print("type:$selectedRadioButton2");
  //         print("from: $from_code");
  //         print("to: $to_code");
  //         print("dayReturn: $retformat");
  //         print("dateDep $depformat");
  //         print("2 from: $from_code1");
  //         print("2 to: $to_code1");
  //         // print("dayReturn: $retformat");
  //         print("2 dateDep $depformat1");

  //         if (paxinfo != null) {
  //           print("paxinfo.adult:${paxinfo.adult}");
  //           print("paxinfo.Children: ${paxinfo.Children}");
  //           print("paxinfo.Infants: ${paxinfo.Infants}");
  //           print("paxinfo.Class: ${paxinfo.Class.toUpperCase()}");
  //         }

  //         if (selectedRadioButton == 'One Way') {
  //           showDialog(
  //             context: context,
  //             barrierDismissible: false,
  //             builder: (BuildContext context) {
  //               return Center(
  //                 child:
  //                     CircularProgressIndicator(), // Show a circular progress indicator
  //               );
  //             },
  //           );
  //           if (selectedRadioButton2 == 'Domestic') {
  //             searchDomesticOneway1(
  //                 widget.locationList1,
  //                 city,
  //                 city1,
  //                 paxinfo.Class.toUpperCase(),
  //                 paxinfo.adult,
  //                 paxinfo.Children,
  //                 paxinfo.Infants,
  //                 from_code,
  //                 to_code,
  //                 depformat,
  //                 total_count(paxinfo),
  //                 context);
  //           } else {
  //             showDialog(
  //               context: context,
  //               barrierDismissible: false,
  //               builder: (BuildContext context) {
  //                 return Center(
  //                   child:
  //                       CircularProgressIndicator(), // Show a circular progress indicator
  //                 );
  //               },
  //             );
  //             searchDomesticOneway1(
  //                 widget.locationList1,
  //                 city,
  //                 city1,
  //                 paxinfo.Class.toUpperCase(),
  //                 paxinfo.adult,
  //                 paxinfo.Children,
  //                 paxinfo.Infants,
  //                 from_code,
  //                 to_code,
  //                 depformat,
  //                 total_count(paxinfo),
  //                 context);
  //             // getinter1waysearch_api( widget.locationList1,
  //             //     city,
  //             //     city1,
  //             //     paxinfo.Class.toUpperCase(),
  //             //     paxinfo.adult,
  //             //     paxinfo.Children,
  //             //     paxinfo.Infants,
  //             //     from_code,
  //             //     to_code,
  //             //     depformat,
  //             //     total_count(paxinfo),
  //             //     context);
  //           }
  //         } else if (selectedRadioButton == 'Multi City') {
  //           showDialog(
  //             context: context,
  //             barrierDismissible: false,
  //             builder: (BuildContext context) {
  //               return Center(
  //                 child:
  //                     CircularProgressIndicator(), // Show a circular progress indicator
  //               );
  //             },
  //           );
  //           if (selectedRadioButton2 == 'Domestic') {
  //             multiRoutes.clear();
  //             // route1
  //             routes newroute1 = routes(
  //                 fromCode: from_code,
  //                 toCode: to_code,
  //                 date: depformat,
  //                 fromcity: city,
  //                 tocity: city1);
  //             multiRoutes.add(newroute1);
  //             print(
  //                 "Passenger 1 data: ${newroute1.fromCode},${newroute1.toCode}, ${newroute1.date}");
  //             print("Passenger 2 added successfully: $newroute1");
  //             // route2

  //             routes newroute2 = routes(
  //                 fromCode: from_code1,
  //                 toCode: to_code1,
  //                 date: depformat1,
  //                 fromcity: city3,
  //                 tocity: city4);
  //             multiRoutes.add(newroute2);
  //             print(
  //                 "Passenger 2 data: ${newroute2.fromCode},${newroute2.toCode}, ${newroute2.date}");
  //             print("Passenger 2 added successfully: $newroute2");

  //             if (show_multicity3) {
  //               print("route3");

  //               routes newroute3 = routes(
  //                   fromCode: from_code11,
  //                   toCode: to_code11,
  //                   date: depformat11,
  //                   fromcity: city31,
  //                   tocity: city41);
  //               multiRoutes.add(newroute3);
  //               print("Passenger 3 data: ${newroute3.date}");
  //               print(
  //                   "Passenger 3 added successfully:  ${newroute3.fromCode},${newroute3.toCode}, ${newroute3.date}");

  //               if (show_multicity4) {
  //                 print("route4");

  //                 routes newroute4 = routes(
  //                     fromCode: from41code,
  //                     toCode: to42code,
  //                     date: depformat42,
  //                     fromcity: c41ity,
  //                     tocity: c42ity);
  //                 multiRoutes.add(newroute4);
  //                 print("Passenger 4 data: ${newroute4.date}");
  //                 print(
  //                     "Passenger 4 added successfully:  ${newroute4.fromCode},${newroute4.toCode}, ${newroute4.date}");
  //               }
  //               if (show_multicity5) {
  //                 print("route5");

  //                 routes newroute5 = routes(
  //                     fromCode: from51code,
  //                     toCode: to52code,
  //                     date: depformat52,
  //                     fromcity: c51ity,
  //                     tocity: c52ity);
  //                 multiRoutes.add(newroute5);
  //                 print("Passenger 4 data: ${newroute5.date}");
  //                 print(
  //                     "Passenger 4 added successfully:  ${newroute5.fromCode},${newroute5.toCode}, ${newroute5.date}");
  //               }
  //             }
  //             getMulticity(
  //               widget.locationList1,
  //               paxinfo.Class.toUpperCase(),
  //               paxinfo.adult,
  //               paxinfo.Children,
  //               paxinfo.Infants,
  //               context,
  //             );
  //             // getDomestic_multiwaysearchapi(

  //             //     3,
  //             //     paxinfo.Class.toUpperCase(),
  //             //     paxinfo.adult,
  //             //     paxinfo.Children,
  //             //     paxinfo.Infants,
  //             //     from_code,
  //             //     to_code,
  //             //     depformat,
  //             //     from_code1,
  //             //     to_code1,
  //             //     depformat1,
  //             //     from_code11,
  //             //     to_code11,
  //             //     depformat11,
  //             //     context);
  //           } else {
  //             multiRoutes.clear();
  //             // route1
  //             routes newroute1 = routes(
  //                 fromCode: from_code,
  //                 toCode: to_code,
  //                 date: depformat,
  //                 fromcity: city,
  //                 tocity: city1);
  //             multiRoutes.add(newroute1);
  //             print(
  //                 "Passenger 1 data: ${newroute1.fromCode},${newroute1.toCode}, ${newroute1.date}");
  //             print("Passenger 2 added successfully: $newroute1");
  //             // route2

  //             routes newroute2 = routes(
  //                 fromCode: from_code1,
  //                 toCode: to_code1,
  //                 date: depformat1,
  //                 fromcity: city3,
  //                 tocity: city4);
  //             multiRoutes.add(newroute2);
  //             print(
  //                 "Passenger 2 data: ${newroute2.fromCode},${newroute2.toCode}, ${newroute2.date}");
  //             print("Passenger 2 added successfully: $newroute2");

  //             if (show_multicity3) {
  //               print("route3");

  //               routes newroute3 = routes(
  //                   fromCode: from_code11,
  //                   toCode: to_code11,
  //                   date: depformat11,
  //                   fromcity: city31,
  //                   tocity: city41);
  //               multiRoutes.add(newroute3);
  //               print("Passenger 3 data: ${newroute3.date}");
  //               print(
  //                   "Passenger 3 added successfully:  ${newroute3.fromCode},${newroute3.toCode}, ${newroute3.date}");

  //               if (show_multicity4) {
  //                 print("route4");

  //                 routes newroute4 = routes(
  //                     fromCode: from41code,
  //                     toCode: to42code,
  //                     date: depformat42,
  //                     fromcity: c41ity,
  //                     tocity: c42ity);
  //                 multiRoutes.add(newroute4);
  //                 print("Passenger 4 data: ${newroute4.date}");
  //                 print(
  //                     "Passenger 4 added successfully:  ${newroute4.fromCode},${newroute4.toCode}, ${newroute4.date}");
  //               }
  //               if (show_multicity5) {
  //                 print("route5");

  //                 routes newroute5 = routes(
  //                     fromCode: from51code,
  //                     toCode: to52code,
  //                     date: depformat52,
  //                     fromcity: c51ity,
  //                     tocity: c52ity);
  //                 multiRoutes.add(newroute5);
  //                 print("Passenger 4 data: ${newroute5.date}");
  //                 print(
  //                     "Passenger 4 added successfully:  ${newroute5.fromCode},${newroute5.toCode}, ${newroute5.date}");
  //               }
  //             }
  //             showDialog(
  //               context: context,
  //               barrierDismissible: false,
  //               builder: (BuildContext context) {
  //                 return Center(
  //                   child:
  //                       CircularProgressIndicator(), // Show a circular progress indicator
  //                 );
  //               },
  //             );
  //             getinternational_multi_searchapi(
  //               widget.locationList1,
  //               paxinfo.Class.toUpperCase(),
  //               paxinfo.adult,
  //               paxinfo.Children,
  //               paxinfo.Infants,
  //               context,
  //             );
  //             // getinternational_multi_searchapi(
  //             //     paxinfo.Class.toUpperCase(),
  //             //     paxinfo.adult,
  //             //     paxinfo.Children,
  //             //     paxinfo.Infants,
  //             //     from_code,
  //             //     to_code,
  //             //     depformat,
  //             //     from_code1,
  //             //     to_code1,
  //             //     depformat1,
  //             //     context);
  //           }
  //         } else {
  //           if (selectedRadioButton2 == 'Domestic') {
  //             showDialog(
  //               context: context,
  //               barrierDismissible: false,
  //               builder: (BuildContext context) {
  //                 return Center(
  //                   child:
  //                       CircularProgressIndicator(), // Show a circular progress indicator
  //                 );
  //               },
  //             );
  //             getReturnSearchApi(
  //                 widget.locationList1,
  //                 true,
  //                 total_count(paxinfo),
  //                 city,
  //                 city1,
  //                 paxinfo.Class.toUpperCase(),
  //                 paxinfo.adult,
  //                 paxinfo.Children,
  //                 paxinfo.Infants,
  //                 from_code,
  //                 to_code,
  //                 depformat,
  //                 retformat,
  //                 context);
  //           } else {
  //             //  getReturnSearchApi(
  //             // widget.locationList1,
  //             // false,
  //             // total_count(paxinfo),
  //             // city,
  //             // city1,
  //             // paxinfo.Class.toUpperCase(),
  //             // paxinfo.adult,
  //             // paxinfo.Children,
  //             // paxinfo.Infants,
  //             // from_code,
  //             // to_code,
  //             // depformat,
  //             // retformat,
  //             // context);
  //             showDialog(
  //               context: context,
  //               barrierDismissible: false,
  //               builder: (BuildContext context) {
  //                 return Center(
  //                   child:
  //                       CircularProgressIndicator(), // Show a circular progress indicator
  //                 );
  //               },
  //             );
  //             getInternationalReturnSearch(
  //                 widget.locationList1,
  //                 // false,
  //                 total_count(paxinfo),
  //                 city,
  //                 city1,
  //                 paxinfo.Class.toUpperCase(),
  //                 paxinfo.adult,
  //                 paxinfo.Children,
  //                 paxinfo.Infants,
  //                 from_code,
  //                 to_code,
  //                 depformat,
  //                 retformat,
  //                 context);
  //           }
  //         }
  //       },
  //       child: Container(
  //         height: sHeight * 0.06,
  //         width: sWidth * 0.153,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(30),
  //           gradient: LinearGradient(
  //             colors: [Colors.blue, Colors.blueAccent, Colors.lightBlueAccent],

  //             /// Define your gradient colors
  //             begin: Alignment
  //                 .topLeft, // Define the gradient begin and end points as per your requirement
  //             end: Alignment.bottomRight,
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Color.fromARGB(255, 44, 44, 44)
  //                   .withOpacity(0.5), // Define shadow color
  //               spreadRadius: 1, // Define the spread radius of the shadow
  //               blurRadius: 3, // Define the blur radius of the shadow
  //               offset: Offset(0, 0), // Define the offset of the shadow
  //             ),
  //           ],
  //         ),
  //         child: Center(
  //           child: Text("SEARCH",
  //               style: TextStyle(
  //                   fontSize: 25,
  //                   fontWeight: FontWeight.w700,
  //                   color: Colors.white)),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  int total_count(paxinfo) {
    int adult = 1;
    int child = 0;
    int infant = 0;

    if (paxinfo != null) {
      if (paxinfo.adult != null) {
        adult = int.parse(paxinfo.adult);
      }

      if (paxinfo.Children != null) {
        child = int.parse(paxinfo.Children);
      }

      if (paxinfo.Infants != null) {
        infant = int.parse(paxinfo.Infants);
      }
    }

    int total = adult + child + infant;
    print("total travellers : $total");
    return total;
  }

  // int total_count(paxinfo) {
  //   int adult = 1;
  //   int child = 0;
  //   int infant = 0;
  //   if (paxinfo != null) {
  //     //    String adult;
  //     // String Children;
  //     // String Infants;
  //     // String Class;

  //     if (paxinfo.adult == null) {
  //       int adult = 1;
  //     } else {
  //       int adult = int.parse(paxinfo.adult);
  //     }
  //     if (paxinfo.Children == null) {
  //       int child = 0;
  //     } else {
  //       int child = int.parse(paxinfo.Children);
  //     }

  //     if (paxinfo.Infants == null) {
  //       int infant = 0;
  //     } else {
  //       int infant = int.parse(paxinfo.Infants);
  //     }

  //     int total = adult + child + infant;
  //     print("total travellers : $total");
  //     return total;
  //   }
  //   return 1;
  // }

  TravellerClass showTravellerCount(
      BuildContext context, Offset containerPosition) {
    TravellerClass traveller = TravellerClass(
        adult: '1',
        Children: null,
        Infants: null,
        Class: 'Economy/Premium Economy');

    // int adultnumber =1;
    // int childnumber =null;
    // int infantnumber = null;
    // String Travelclass = 'Economy/Premium Economy';
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: containerPosition.dy + 70, // Adjust as needed
        left: containerPosition.dy + 740,
        child: Material(
          color: Colors.white,
          child: Container(
            width: 490,
            // height: 200,
            padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white70,
              border: Border.all(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
                  child: Text(
                    'ADULTS(12y +)',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
                  child: Text(
                    'On the day travel',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                //Adults
                Adultcount((selectedNumber) {
                  traveller.adult =
                      selectedNumber.toString(); // Update selected adult count

                  print('Selected number: $selectedNumber');
                  print('adultnumber: ${traveller.adult}');
                }),
                //Children

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'CHILDREN(2y-12y)',
                    style: TextStyle(fontSize: 12),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'On the day travel',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ChildrensCount((selectedNumberChild) {
                  traveller.Children = selectedNumberChild
                      .toString(); // Update selected adult count

                  print('Selected number: $selectedNumberChild');
                  print('adultnumber: ${traveller.Children}');
                }),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                  child: Text(
                    'INFANTS(below 2y)',
                    style: TextStyle(fontSize: 12),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                  child: Text(
                    'On the day travel',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                InfantsCount((selectedNumberInfant) {
                  traveller.Infants = selectedNumberInfant
                      .toString(); // Update selected adult count

                  print('Selected number: $selectedNumberInfant');
                  print('adultnumber: ${traveller.Infants}');
                }),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Text(
                    'CHOOSE TRAVEL CLASS',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                TravelClass((selectedclass) {
                  int value = selectedclass;
                  print("selectedvalue:$selectedclass");
                  print("value: $value");
                  switch (value) {
                    case 0:
                      traveller.Class = 'Economy';
                      break;
                    case 1:
                      traveller.Class = 'Premium Economy';
                      break;
                    case 2:
                      traveller.Class = 'Business';
                      break;
                    default:
                      traveller.Class = '';
                      break;
                  }
                }),

                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: ElevatedButton(
                    onPressed: () {
                      overlayEntry.remove();

                      print("adult: ${traveller.adult}");
                      print("children: ${traveller.Children}");
                      print("infant: ${traveller.Infants}");
                      print("Travel class: ${traveller.Class}");
                      setState(() {
                        paxinfo = traveller;
                      });
                      // return traveller;
                    },
                    child: Text('APPLY'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);
  }
}

class TravellerClass {
  String adult;
  String Children;
  String Infants;
  String Class;

  TravellerClass({
    this.adult,
    this.Children,
    this.Infants,
    this.Class,
  });
}
