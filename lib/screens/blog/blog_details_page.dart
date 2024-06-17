import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/api_services/blog_api/add_comment_api.dart';
import 'package:trip/api_services/blog_api/get_comments_api.dart';
import 'package:trip/screens/Drawer.dart';
import 'package:trip/screens/header.dart';
import 'package:trip/screens/signUp.dart';
import '../../api_services/blog_api/get_blog_byid_api.dart';
import '../footer.dart';

class BlogDetailsPage extends StatefulWidget {
  String id;
  BlogDetailsPage({key, this.id});

  @override
  State<BlogDetailsPage> createState() => _BlogDetailsPageState();
}

BlogDatum blogDetails;
bool expand = true;
TextEditingController commentController = TextEditingController();
TextEditingController EController = TextEditingController();
TextEditingController naController = TextEditingController();
List<Comments> comments = [];

class _BlogDetailsPageState extends State<BlogDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
    getblogdetails();
    naController.clear();
    EController.clear();
    commentController.clear();
  }

  getblogdetails() async {
    Blog res = await getblogByidApi(widget.id);
    if (res.errorCode == '200') {
      List<BlogDatum> obj = res.data;
      setState(() {
        blogDetails = obj[0];
      });
    }
  }

  getComments() async {
    allCommentObj res = await getcommentsAPI(widget.id);
    if (res.errorCode == '200') {
      List<Comments> obj = res.data;
      setState(() {
        comments = obj;
      });
      print("commnts:${comments.length}");
    }
  }

// Inside your build method
  Widget build(BuildContext context) {
    var sheight = MediaQuery.of(context).size.height;
    var swidth = MediaQuery.of(context).size.width;

    // Future that resolves after 2 seconds
    Future<void> _delayedFuture = Future.delayed(Duration(seconds: 1));

    return Scaffold(
      appBar: swidth < 600
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 40),
              backgroundColor: Color.fromARGB(255, 1, 21, 101),
              title: Text(
                "Blog",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            )
          : CustomAppBar(),
      drawer: swidth < 600 ? drawer() : null,
      body: FutureBuilder(
        future: _delayedFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show circular progress indicator while waiting
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            // After 2 seconds delay, show the content
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 0, right: 0,top: 45),
                  // child: Container(
                  //   width: swidth * 0.8,
                  //   height: sheight * 0.55,
                  //   // color: Colors.amber,
                  //   child: Image.network(
                  //     "https://gotodestination.in/api/images/blog_img/${blogDetails.images}" ??
                  //         'https://hsoftech.com/wp-content/uploads/2024/03/Importance-Graphic-Design_Video_Business-Growth.jpg',
                  //     filterQuality: FilterQuality.high,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  //   ),
                  // ),
                  Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, top: 45),
                      child: Container(
                        width: swidth * 0.8,
                        height: sheight * 0.55,
                        // color: Colors.amber,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: swidth,
                                height: sheight * 0.55,
                                child: Image.network(
                                  'https://gotodestination.in/api/images/blog_img/${blogDetails.images}',
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace stackTrace) {
                                    return Image.network(
                                      'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png', // Replace with your default image asset path
                                      fit: BoxFit.contain,
                                    );
                                  },
                                ),
                              ),
                            ),
                            // Container(
                            //   width: swidth * 0.8,
                            //   height: sheight * 0.55,
                            //   child: Image.network(
                            //     "https://gotodestination.in/api/images/blog_img/${blogDetails.images}" ??
                            //         'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png',
                            //     filterQuality: FilterQuality.high,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            // Positioned(
                            //   left: 230,
                            //   bottom: 20,
                            //   child: Center(
                            //     child: Text(
                            //       blogDetails.blogName ??
                            //           'The Importance of Graphic Design and Video for Business Growth',
                            //       style: GoogleFonts.rajdhani(
                            //         textStyle: TextStyle(
                            //           fontSize: 38,
                            //           fontWeight: FontWeight.w700,
                            //           color: Colors.black
                            //           // Add other text styles as needed
                            //         ),
                            //       ),
                            //       textAlign: TextAlign.center,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      description(sheight, swidth),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget description(sheight, swidth) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Container(
                //   width: swidth * 0.3,
                //   height: sheight * 0.3,
                //   // color: Colors.amber,
                //   child: Image.network(
                //     "https://gotodestination.in/api/images/blog_img/${blogDetails.images}" ??
                //         'https://hsoftech.com/wp-content/uploads/2024/03/Importance-Graphic-Design_Video_Business-Growth.jpg',
                //     filterQuality: FilterQuality.high,
                //     fit: BoxFit.contain,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: SizedBox(
                    width: swidth * 0.5,
                    // height: sheight * 0.55,
                    // height: sheight * 0.3,
                    child: Text(
                      blogDetails.blogName ??
                          'The Importance of Graphic Design and Video for Business Growth',
                      style: GoogleFonts.rajdhani(
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          // Add other text styles as needed
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: swidth * 0.8,
                  // height: sheight * 0.3,
                  child: Text(
                    blogDetails.description ??
                        'In today’s digital age, where attention spans are shrinking, visual content has become paramount for businesses aiming to stand out in a crowded marketplace. Among the various visual mediums, graphic design and video content play pivotal roles in capturing audience attention, conveying brand messages effectively, and ultimately driving business growthHere are several reasons why graphic design and video are essential for business success:First Impressions Matter: Graphic design creates the first impression of your brand. A professionally designed logo, website, or marketing materials can instantly convey the quality and personality of your business, helping to build trust and credibility with potential customers',
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        // Add other text styles as needed
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            "COMMENTS",
            style:
                GoogleFonts.rajdhani(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        showCommennts(swidth, sheight),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            "LEAVE A COMMENT",
            style:
                GoogleFonts.rajdhani(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        // Container(
        //   width: swidth * 0.68,
        //   child: Row(
        //     children: [
        //       Text(
        //         'Write a Comment',
        //         style: TextStyle(
        //             color: Color.fromARGB(255, 255, 137, 64),
        //             fontSize: 15,
        //             fontWeight: FontWeight.w600),
        //       ),
        //       IconButton(
        //           onPressed: () {
        //             setState(() {
        //               expand = !expand;
        //             });
        //           },
        //           icon: expand
        //               ? Icon(Icons.arrow_drop_up_rounded)
        //               : Icon(Icons.arrow_drop_down))
        //     ],
        //   ),
        // ),
        Visibility(visible: expand, child: Comment(sheight, swidth)),
        SizedBox(height: sheight * 0.3),
        buildFooter(),
      ],
    );
  }

  Widget showCommennts(sWidth, sHeight) {
    return Center(
      child: Container(
        width: sWidth * 0.68,
        // height: sHeight * 0.5,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: comments.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: sHeight * .125,
                  width: sWidth * 0.76,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 3),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade500,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comments[index].name ?? "LEXI CAMERON",
                                style: GoogleFonts.notoSans(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                comments[index].comment ??
                                    "I adore delving into your insights on traveling the world. Your experiences sound exhilarating!",
                                style: GoogleFonts.notoSans(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                      VerticalDivider()
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

// SingleChildScrollView(
//         child: Column(
//           children: [
//             Center(
//               child: Container(
//                 height: sheight * 0.6,
//                 width: swidth * 0.8,
//                 color: Color.fromARGB(255, 205, 196, 196),
//                 child: Image.network(
//                   "https://gotodestination.in/api/images/blog_img/${blogDetails.images}" ??
//                       'https://www.hdwallpaper.nu/wp-content/uploads/2017/03/facebook-17.jpg',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             SizedBox(
//               width: swidth * 0.38,
//               child: Text(
//                 blogDetails.blogName ??
//                     'Maximizing Cost Efficiency with Hybrid Development Using Flutter Technology',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Container(
//               width: swidth * 0.35,
//               child: Text(
//                 blogDetails.description ??
//                     'In the rapidly evolving landscape of mobile application development, businesses are continually seeking ways to optimize their resources while delivering high-quality products to their users. One approach gaining significant traction in recent years is hybrid development, leveraging frameworks like Flutter to create cost-effective solutions without compromising on performance or user experience. Understanding Hybrid DevelopmentHybrid […]',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             Container(
//               width: swidth * 0.35,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'All Comments',
//                     style: TextStyle(
//                         // color: Color.fromARGB(255, 255, 137, 64),
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     'View all(${comments.length})',
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 255, 137, 64),
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 25,
//             ),
//             HorizontalListViewContainer(comments: comments),
//             // Container(
//             //   height: sheight * 0.53,
//             //   width: swidth * 0.5,
//             //   color: Color.fromARGB(255, 222, 221, 218),
//             //   child: Center(
//             //     child: ListView.builder(
//             //       scrollDirection: Axis.horizontal,
//             //       shrinkWrap: true,
//             //       itemCount: 3,
//             //       itemBuilder: (context, index) {
//             //         var comment = comments[index];
//             //         return Container(
//             //           height: 100,
//             //           width: 500,
//             //           child: Card(
//             //             child: Center(
//             //               child: Text(comment.comment),
//             //             ),
//             //           ),
//             //         );
//             //       },
//             //     ),
//             //   ),
//             // ),
  // SizedBox(
  //   height: 15,
  // ),
  // Container(
  //   width: swidth * 0.35,
  //   child: Row(
  //     children: [
  //       Text(
  //         'Write a Comment',
  //         style: TextStyle(
  //             color: Color.fromARGB(255, 255, 137, 64),
  //             fontSize: 15,
  //             fontWeight: FontWeight.w600),
  //       ),
  //       IconButton(
  //           onPressed: () {
  //             setState(() {
  //               expand = !expand;
  //             });
  //           },
  //           icon: expand
  //               ? Icon(Icons.arrow_drop_up_rounded)
  //               : Icon(Icons.arrow_drop_down))
  //     ],
  //   ),
  // ),
  // Visibility(visible: expand, child: Comment(sheight, swidth)),
//             SizedBox(height: 50),
//           ],
//         ),
//       ),

  Widget Comment(sHeight, sWidth) {
    return Container(
      // height: sHeight * 0.18,
      width: sWidth * 0.68,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: 'Your Comment',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              maxLines: 5,
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: naController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextFormField(
                    controller: EController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else if (!value.contains('@')) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Center(
              child: SizedBox(
                width: 80,
                height: 35,
                child: ElevatedButton(
                  onPressed: () async {
                    if (commentController.text.isNotEmpty &&
                        EController.text.isNotEmpty &&
                        naController.text.isNotEmpty) {
                      String msg = await addcommentApi(commentController.text,
                          widget.id, naController.text, EController.text);
                      if (msg == 'comment added successfully') {
                        // Show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog(
                              title: 'Success!',
                              content: msg,
                              onConfirm: () {
                                naController.clear();
                                EController.clear();
                                commentController.clear();
                                // Do something when confirmed
                                Navigator.of(context).pop();

                                // Close the dialog
                              },
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog(
                              title: 'Error',
                              content: 'Please Try again..',
                              onConfirm: () {
                                naController.clear();
                                EController.clear();
                                commentController.clear();
                                // Do something when confirmed
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            );
                          },
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomAlertDialog(
                            title: 'Error',
                            content: 'All fields are required..',
                            onConfirm: () {
                              // Do something when confirmed
                              Navigator.of(context).pop(); // Close the dialog
                            },
                          );
                        },
                      );
                    }

                    // commentController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text("Submit"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  CustomAlertDialog({
    this.title,
    this.content,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
        // TextButton(
        //   onPressed: onConfirm,
        //   child: Text('Confirm'),
        // ),
      ],
    );
  }
}
