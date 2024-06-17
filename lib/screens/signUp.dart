
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip/screens/signIn.dart';
import '../api_services/login/sign_up_api.dart';
import 'constant.dart';

class signUp extends StatefulWidget {
  const signUp({Key key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool showPassword = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: currentWidth < 600 ? Color(0xFF0d2b4d) : Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return MobileScreen(context);
          } else {
            return DesktopScreen(sheight, swidth, context);
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
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          height: 500.0,
          child: containerForm(context),
        ),
      ),
    );
  }

  Center DesktopScreen(double sheight, double swidth, BuildContext context) {
    return Center(
        child: Container(
      decoration: BoxDecoration(
          color: Color(0xFF0d2b4d), borderRadius: BorderRadius.circular(20)),
      height: sheight / 1.5,
      width: swidth / 1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 50.0),
          Expanded(child: buildContainer()),
          const SizedBox(width: 50.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 30.0, bottom: 30),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: containerForm(context)),
            ),
          )
        ],
      ),
    ));
  }

  Container containerForm(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50.0),
              Center(
                  child: Text(
                'REGISTER HERE',
                style: blackB20,
              )),
              const SizedBox(height: 20.0),
              formField(
                  controller: nameController,
                  hintText: "Enter name",
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  }),
              const SizedBox(height: 10.0),
              formField(
                  controller: mobileController,
                  hintText: "Enter mobile number",
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your mobile number';
                    }else if(value.length!=10){
                      return 'Please enter  valid mobile number';
                    }
                    return null;
                  }),
              const SizedBox(height: 10.0),
              formField(
                  controller: emailController,
                  hintText: "Enter email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  }),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey[200],
                    )),
                height: 40.0,
                child: TextFormField(
                  controller: passwordController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: showPassword
                            ? Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              ),
                      ),
                      border: InputBorder.none,
                      hintText: "Enter Password",
                      hintStyle: grey12),
                ),
              ),
              const SizedBox(height: 10.0),
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
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 40.0,
                    color: Color(0xFF0d2b4d),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _signup(
                            nameController.text,
                            mobileController.text,
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: white15,
                      ),
                    ),
                  )),
                  const SizedBox(width: 20.0),
                  Expanded(
                    child: Container(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signIn()));
                        },
                        child: Text(
                          'Login',
                          style: blackB15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget formField({
    TextEditingController controller,
    String hintText,
    TextInputType keyboardType,
    int maxLength,
    String Function(String) validator,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            width: 1,
            color: Colors.grey[200],
          )),
      height: 40.0,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        validator: validator,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: grey12),
      ),
    );
  }

  void _signup(String name, String mobile, String email, String password) async {
    String res = await signUpAPI(name, mobile, email, password);
    Map<String, dynamic> response = jsonDecode(res);

    if (response['error_message'] == "Success") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text("Sign-up successful."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => signIn()));
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error!"),
            content: Text("Please try again!"),
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
  }
}

Container buildContainer() {
  return Container(
      height: 400.0,
      width: 400.0,
      child: Image.asset(
        'images/mumbai3.jpg',
        fit: BoxFit.fill,
      ));
}











// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:trip/screens/signIn.dart';

// import '../api_services/login/sign_up_api.dart';
// import 'constant.dart';

// class signUp extends StatefulWidget {
//   const signUp({Key key}) : super(key: key);

//   @override
//   State<signUp> createState() => _signUpState();
// }

// bool show_password = false;
// TextEditingController nameController = TextEditingController();
// TextEditingController mobileController = TextEditingController();
// TextEditingController emailController = TextEditingController();
// TextEditingController passwordController = TextEditingController();
// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// class _signUpState extends State<signUp> {
//   @override
//   Widget build(BuildContext context) {
//     final currentwidth = MediaQuery.of(context).size.width;
//     double width = MediaQuery.of(context).size.width;
//     double sheight = MediaQuery.of(context).size.height;
//     double swidth = MediaQuery.of(context).size.width;

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
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(20)),
//           height: 500.0,
//           child: containerForm(context),
//         ),
//       ),
//     );
//   }

//   //MobileScreen(context),
// //  DesktopScreen(sheight, swidth, context),
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
//                   child: containerForm(context)),
//             ),
//           )
//         ],
//       ),
//     ));
//   }

//   Container containerForm(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 50.0,
//             ),
//             Center(
//                 child: Text(
//               'REGISTER HERE',
//               style: blackB20,
//             )),
//             const SizedBox(
//               height: 20.0,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(2),
//                   border: Border.all(
//                     width: 1, color: Colors.grey[200],
//                     //style: BorderStyle.solid
//                   )),
//               height: 40.0,
//               child: TextFormField(
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//                 controller: nameController,
//                 decoration: InputDecoration(

//                     // focusColor: Colors.grey[200],
//                     border: InputBorder.none,
//                     hintText: "   Enter name",
//                     hintStyle: grey12),
//               ),
//             ),
//             const SizedBox(
//               height: 10.0,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(2),
//                   border: Border.all(
//                     width: 1, color: Colors.grey[200],
//                     //style: BorderStyle.solid
//                   )),
//               height: 40.0,
//               child: TextFormField(
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Please enter your mobile number';
//                   }
//                   return null;
//                 },
//                 maxLength: 10,
//                 controller: mobileController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(

//                     // focusColor: Colors.grey[200],
//                     border: InputBorder.none,
//                     hintText: "   Enter mobile number",
//                     hintStyle: grey12),
//               ),
//             ),
//             const SizedBox(
//               height: 10.0,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(2),
//                   border: Border.all(
//                     width: 1, color: Colors.grey[200],
//                     //style: BorderStyle.solid
//                   )),
//               height: 40.0,
//               child: TextFormField(
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Please enter your email';
//                   } else if (!value.contains('@')) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.emailAddress,
//                 controller: emailController,
//                 decoration: InputDecoration(
//                     // focusColor: Colors.grey[200],
//                     border: InputBorder.none,
//                     hintText: "   Enter email",
//                     hintStyle: grey12),
//               ),
//             ),
//             const SizedBox(
//               height: 10.0,
//             ),
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(2),
//                   border: Border.all(
//                     width: 1, color: Colors.grey[200],
//                     //style: BorderStyle.solid
//                   )),
//               height: 40.0,
//               child: TextFormField(
//                 controller: passwordController,
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Please enter a password';
//                   } else if (value.length < 6) {
//                     return 'Password must be at least 6 characters long';
//                   }
//                   return null;
//                 },
//                 obscureText: show_password,
//                 decoration: InputDecoration(
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           show_password = !show_password;
//                         });
//                       },
//                       icon: show_password
//                           ? Icon(
//                               Icons.visibility,
//                               color: Colors.grey,
//                             )
//                           : Icon(
//                               Icons.visibility_off,
//                               color: Colors.grey,
//                             ),
//                     ),
//                     // focusColor: Colors.grey[200],
//                     border: InputBorder.none,
//                     hintText: "   Enter Password",
//                     hintStyle: grey12),
//               ),
//             ),
//             const SizedBox(
//               height: 10.0,
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Forget Password?',
//                   style: black12,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20.0,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: Container(
//                   height: 40.0,
//                   color: Color(0xFF0d2b4d),
//                   child: TextButton(
//                     onPressed: () {
//                       print("p:${passwordController.text}");
//                       _signup(nameController.text, mobileController.text,
//                           emailController.text, passwordController.text);
//                     },
//                     child: Text(
//                       'Sign Up',
//                       style: white15,
//                     ),
//                   ),
//                 )),
//                 const SizedBox(
//                   width: 20.0,
//                 ),
//                 Expanded(
//                   child: Container(
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => signIn()));
//                       },
//                       child: Text(
//                         'Login ',
//                         style: blackB15,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _signup(String text, String text2, String text3, String text4) {
//     if (text == null ||
//         text2 == null ||
//         text3 == null ||
//        text4 == null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Alert"),
//             content: Text("All fields are required."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       getsignupapi(text, text2, text3, text4);
//     }
//   }

//   Future<void> getsignupapi(
//       String text, String text2, String text3, String text4) async {
//     String res = await signUpAPI(text, text2, text3, text4);
//     Map<String, dynamic> response = jsonDecode(res);

//     String errorMessage = response['error_message'];

//     if (errorMessage == "Success") {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Success"),
//             content: Text("Sign-up successful."),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   // Navigator.of(context).pop();
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => signIn()));
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Error!"),
//             content: Text("Please try again!"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text("OK"),
//               ),
//             ],
//           );
//         },
//       );
//     }
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
