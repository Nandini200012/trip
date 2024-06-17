import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trip/api_services/login/sign_in_api.dart';
import 'package:trip/screens/signUp.dart';
import '../login_variables/login_Variables.dart';
import 'Home.dart';
import 'constant.dart';

class signIn extends StatefulWidget {
  const signIn({Key key}) : super(key: key);

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
bool obsuretext=false;
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: currentWidth < 600 ? Color(0xFF0d2b4d) : Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return MobileScreen(context);
          } else {
            return DesktopScreen(context);
          }
        },
      ),
    );
  }

  Center MobileScreen(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 500.0,
          child: signInForm(context),
        ),
      ),
    );
  }

  Center DesktopScreen(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0d2b4d),
          borderRadius: BorderRadius.circular(20),
        ),
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 1.5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 50.0),
            Expanded(child: buildImageContainer()),
            SizedBox(width: 50.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: signInForm(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildImageContainer() {
    return Container(
      height: 400.0,
      width: 400.0,
      child: Image.asset(
        'images/mumbai3.jpg',
        fit: BoxFit.fill,
      ),
    );
  }
  obsurefunction(){
    setState(() {
      obsuretext=!obsuretext;
    });
  }

  Form signInForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100.0),
            Center(
              child: Text(
                'SIGN IN',
                style: blackB20,
              ),
            ),
            SizedBox(height: 20.0),
            buildTextField1(
              controller: emailController,
              hintText: "   Enter Mobile Number",
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your Mobile Number';
                } else if (value.length != 10) {
                  return 'Please enter a valid Mobile Number';
                }
                return null;
              },
            ),
            SizedBox(height: 10.0),
            buildTextField(
              controller: passwordController,
              hintText: "   Enter Password",
              obscureText: obsuretext,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forget Password?',
                  style: black12,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: buildSignInButton(context),
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: buildRegisterButton(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

Container buildTextField({
    TextEditingController controller,
    String hintText,
    bool obscureText,
    Function(String) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          width: 1,
          color: Colors.grey[200],
        ),
      ),
      height: 50.0,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText, // Use the state variable here
        validator: validator,
        decoration: InputDecoration(
          suffix: IconButton(
            onPressed: () {
               obsurefunction();
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: obscureText
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: grey12,
        ),
      ),
    );
  }
  // Container buildTextField({
  //   TextEditingController controller,
  //   String hintText,
  //   bool obscureText ,
  //   Function(String) validator,
  // }) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(2),
  //       border: Border.all(
  //         width: 1,
  //         color: Colors.grey[200],
  //       ),
  //     ),
  //     height: 50.0,
  //     child: TextFormField(
  //       controller: controller,
  //       obscureText: obscureText,
  //       validator: validator,
  //       decoration: InputDecoration(
  //         suffix: IconButton(
  //             onPressed: () {
  //               setState(() {
  //                 obscureText = !obscureText;
  //               });
  //             },
  //             icon: obscureText
  //                 ? Icon(Icons.visibility_off)
  //                 : Icon(Icons.visibility)),
  //         border: InputBorder.none,
  //         hintText: hintText,
  //         hintStyle: grey12,
  //       ),
  //     ),
  //   );
  // }

  Container buildTextField1({
    TextEditingController controller,
    String hintText,
    bool obscureText = false,
    Function(String) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          width: 1,
          color: Colors.grey[200],
        ),
      ),
      height: 50.0,
      child: TextFormField(
        maxLength: 10,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: grey12,
        ),
      ),
    );
  }

  Container buildSignInButton(BuildContext context) {
    return Container(
      height: 40.0,
      color: Color(0xFF0d2b4d),
      child: TextButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _signIn(emailController.text, passwordController.text, context);
          }
        },
        child: Text(
          'Sign In',
          style: white15,
        ),
      ),
    );
  }

  Container buildRegisterButton(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => signUp()),
          );
        },
        child: Text(
          'Register here',
          style: blackB15,
        ),
      ),
    );
  }

  void _signIn(String email, String password, BuildContext context) {
    if (email == null || password == null) {
      _showAlertDialog(context, "Alert", "All fields are required.");
    } else {
      getSignInApi(email, password, context);
    }
  }

  Future<void> getSignInApi(String email, String password, context) async {
    String res = await signInAPI(email, password);
    Map<String, dynamic> response = jsonDecode(res);

    String errorMessage = response['error_message'];
    String name = response['Name'];
    String id = response['id'];

    if (errorMessage == "Login Success") {
      user_id = id;
      user_name = name;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Login successful."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      _showAlertDialog(context, "Error!", "Please try again!");
    }
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
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
}











// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:trip/api_services/login/sign_in_api.dart';
// import 'package:trip/login_variables/login_Variables.dart';
// import 'package:trip/screens/filter_screen.dart';
// import 'package:trip/screens/signUp.dart';

// import 'Home.dart';
// import 'constant.dart';

// class signIn extends StatefulWidget {
//   const signIn({Key key}) : super(key: key);

//   @override
//   State<signIn> createState() => _signInState();
// }

// TextEditingController email_Controller = TextEditingController();
// TextEditingController password_Controller = TextEditingController();

// class _signInState extends State<signIn> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double sheight = MediaQuery.of(context).size.height;
//     double swidth = MediaQuery.of(context).size.width;
//     final currentwidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: currentwidth < 600 ? Color(0xFF0d2b4d) : Colors.white,
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth < 600) {
//             return MobileScreen(context);
//           } else {
//             return DesktopScreen(sheight, swidth, context);
//           }
//         },
//       ),
//     );
//   }

//   Center MobileScreen(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Container(
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(20)),
//             height: 500.0,
//             child: container(context)),
//       ),
//     );
//   }

//   Center DesktopScreen(double sheight, double swidth, BuildContext context) {
//     return Center(
//         child: Container(
//       decoration: BoxDecoration(
//           color: Color(0xFF0d2b4d), borderRadius: BorderRadius.circular(20)),
//       height: sheight / 1.5,
//       width: swidth / 1.5,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           SizedBox(
//             width: 50.0,
//           ),
//           Expanded(
//             child: buildContainer(),
//           ),
//           const SizedBox(
//             width: 50.0,
//           ),
//           Expanded(
//             child: Padding(
//               padding:
//                   const EdgeInsets.only(top: 30.0, right: 30.0, bottom: 30),
//               child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20)),
//                   child: container(context)),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }

// Container buildContainer() {
//   return Container(
//       height: 400.0,
//       width: 400.0,
//       child: Image.asset(
//         'images/mumbai3.jpg',
//         fit: BoxFit.fill,
//       ));
// }

// Container container(context) {
//   return Container(
//     child: Padding(
//       padding: const EdgeInsets.all(30.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 100.0,
//           ),
//           Center(
//               child: Text(
//             'SIGN IN',
//             style: blackB20,
//           )),
//           const SizedBox(
//             height: 20.0,
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(2),
//                 border: Border.all(
//                   width: 1, color: Colors.grey[200],
//                   //style: BorderStyle.solid
//                 )),
//             height: 40.0,
//             child: TextFormField(
//               maxLength: 10,
//               controller: password_Controller,
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please enter a password';
//                 } else if (value.length < 6) {
//                   return 'Password must be at least 6 characters long';
//                 }
//                 return null;
//               },
//               decoration: InputDecoration(
//                   // focusColor: Colors.grey[200],
//                   border: InputBorder.none,
//                   hintText: "   Enter Phone Number",
//                   hintStyle: grey12),
//             ),
//           ),
//           const SizedBox(
//             height: 10.0,
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(2),
//                 border: Border.all(
//                   width: 1, color: Colors.grey[200],
//                   //style: BorderStyle.solid
//                 )),
//             height: 40.0,
//             child: TextFormField(
//               validator: (value) {
//                 if (value.isEmpty) {
//                   return 'Please enter your email';
//                 } else if (!value.contains('@')) {
//                   return 'Please enter a valid email';
//                 }
//                 return null;
//               },
//               keyboardType: TextInputType.emailAddress,
//               controller: email_Controller,
//               decoration: InputDecoration(
//                   // focusColor: Colors.grey[200],
//                   border: InputBorder.none,
//                   hintText: "   Enter Password",
//                   hintStyle: grey12),
//             ),
//           ),
//           const SizedBox(
//             height: 10.0,
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: TextButton(
//               onPressed: () {},
//               child: Text(
//                 'Forget Password?',
//                 style: black12,
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20.0,
//           ),
//           Row(
//             children: [
//               Expanded(
//                   child: Container(
//                 height: 40.0,
//                 color: Color(0xFF0d2b4d),
//                 child: TextButton(
//                   onPressed: () {
//                     if (email_Controller.text == null ||
//                         email_Controller.text.isEmpty ||
//                         email_Controller.text.length != 10) {
//                       _showAlertDialog(context, "Error",
//                           "Email field cannot be empty and must be exactly 10 characters long.");
//                     } else if (password_Controller.text == null ||
//                         password_Controller.text.isEmpty) {
//                       _showAlertDialog(
//                           context, "Error", "Password field cannot be empty.");
//                     } else {
//                       _signIn(email_Controller.text, password_Controller.text,
//                           context);
//                       email_Controller.clear();
//                       password_Controller.clear();
//                     }
//                   },
//                   child: Text(
//                     'Sign In',
//                     style: white15,
//                   ),
//                 ),
//               )),
//               const SizedBox(
//                 width: 20.0,
//               ),
//               Expanded(
//                 child: Container(
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => signUp()));
//                     },
//                     child: Text(
//                       'Register here',
//                       style: blackB15,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }

// void _showAlertDialog(BuildContext context, String title, String message) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: [
//           TextButton(
//             child: Text("OK"),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// void _signIn(String text, String text2, BuildContext context) {
//   if (text == null || text2 == null) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Alert"),
//           content: Text("All fields are required."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   } else {
//     getsignupapi(text, text2, context);
//   }
// }

// Future<void> getsignupapi(String text, String text2, context) async {
//   String res = await signInAPI(
//     text,
//     text2,
//   );
//   Map<String, dynamic> response = jsonDecode(res);

//   String errorMessage = response['error_message'];
//   String _name = response['Name'];
//   String _id = response['id'];
//   if (errorMessage == "Login Success") {
//     print("Login succesfull");
//     user_id = _id;
//     user_name = _name;
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Success"),
//           content: Text("Sign-up successful."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => HomePage()));
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   } else {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Error!"),
//           content: Text("Please try again!"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
