import 'package:flutter/material.dart';
import 'package:trip/screens/bus/widgets/bustravellerform.dart';

class DropdownId extends StatefulWidget {
  const DropdownId({Key key}) : super(key: key);

  @override
  _DropdownIdState createState() => _DropdownIdState();
}

class _DropdownIdState extends State<DropdownId> {
  String selectedId;
  List<String> IDOptions = [
    'PanCard',
    'VoterCard',
    'Passport',
    'Driving License',
    'Ration Card',
    'Aadhar Card'
  ];

  @override
  Widget build(BuildContext context) {
    selectedId=IDOptions[0];
    return SizedBox(
      width: 200,
      height: 55,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: DropdownButton<String>(
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
            elevation: 0, underline: Container(),
            isExpanded: true,
            value: selectedId,
            onChanged: (newValue) {
              setState(() {
                selectedId = newValue;
                userIDtype = selectedId;
              });
            },
            items: IDOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({Key key}) : super(key: key);

  @override
  _GenderDropdownState createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  String selectedGender;

  @override
  Widget build(BuildContext context) {
    List<String> genderOptions = [
      'Male',
      'Female',
    ];

    void onGenderChanged(String newValue) {
      setState(() {
        selectedGender = newValue;
        userGender = selectedGender;
      });
    }
selectedGender=genderOptions[0];
    return SizedBox(
      width: 200,
      height: 55,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: DropdownButton<String>(
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
            elevation: 0, underline: Container(),
            isExpanded: true,
            value: selectedGender,
            onChanged: onGenderChanged,
            items: genderOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}








class TitleDropdown extends StatefulWidget {
  const TitleDropdown({Key key}) : super(key: key);

  @override
  _TitleDropdownState createState() => _TitleDropdownState();
}

class _TitleDropdownState extends State<TitleDropdown> {
  String selectedTitle;

  @override
  Widget build(BuildContext context) {
    List<String> titleOptions = ['Mrs', 'Ms', 'Mr', 'Miss'];

    void onTitleChanged(String newValue) {
      setState(() {
        selectedTitle = newValue;
        // userTitle = selectedTitle; // You might uncomment this line if 'userTitle' is declared somewhere
      });
    }
selectedTitle=titleOptions[0];
    return SizedBox(
      width: 200,
      height: 55,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: DropdownButton<String>(
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            dropdownColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
            elevation: 0,
            underline: Container(), // No underline
            isExpanded: true,
            value: selectedTitle,
            onChanged: onTitleChanged,
            items: titleOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}




// class DropdownId extends StatefulWidget {
//   const DropdownId({Key key}) : super(key: key);

//   @override
//   _DropdownIdState createState() => _DropdownIdState();
// }

// class _DropdownIdState extends State<DropdownId> {
//   String selectedId;
//   List<String> IDOptions = [
//     'PanCard',
//     'VoterCard',
//     'Passport',
//     'Driving License',
//     'Ration Card',
//     'Aadhar Card'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Text(
//           "ID Type:",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(
//           width: 20,
//         ),
//         SizedBox(
//           width: 200,
//           height: 50,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               border: Border.all(color: Colors.grey),
//             ),
//             child: Center(
//               child: DropdownButton<String>(
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black,
//                 ),
//                 dropdownColor: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 elevation: 0,
//                 isExpanded: true,
//                 value: selectedId,
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedId = newValue;
//                   });
//                 },
//                 items: IDOptions.map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }