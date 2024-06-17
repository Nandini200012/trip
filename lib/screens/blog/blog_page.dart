import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip/api_services/blog_api/get_blog_details_api.dart';
import 'package:trip/screens/blog/blog_details_page.dart';


import '../Drawer.dart';
import '../footer.dart';
import '../header.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
   Future<List<Datum>> _blogDataFuture;

  @override
  void initState() {
    super.initState();
    _blogDataFuture = fetchBlogData();
  }

  Future<List<Datum>> fetchBlogData() async {
    BlogObj obj = await getblog();
    return obj.data;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var sheight = MediaQuery.of(context).size.height;
    var swidth = MediaQuery.of(context).size.width;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 3;

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
      body: FutureBuilder<List<Datum>>(
        future: _blogDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading data'),
            );
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          } else {
            List<Datum> blogdata = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Center(
                    child: Container(
                      width: swidth,
                      height: sheight * 0.55,
                      child: Image.network(
                        'https://wallpaperbat.com/img/44615-beautiful-travel-destination-landscape-wallpaper-4k.jpg',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                          return Image.network(
                            'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png', // Replace with your default image asset path
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
                  ),
                  // Center(
                  //   child: Container(
                  //     width: swidth,
                  //     height: sheight * 0.55,
                  //     child: Image.network(
                  //       'https://wallpaperbat.com/img/44615-beautiful-travel-destination-landscape-wallpaper-4k.jpg',
                  //       filterQuality: FilterQuality.high,
                  //       fit: BoxFit.fill,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.only(left: 150),
                    child: Text(
                      "BLOG POSTS",
                      style: GoogleFonts.rajdhani(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 150, top: 5),
                    child: Row(
                      children: [
                        Container(
                          height: 2.3,
                          width: 25 *
                              MediaQuery.of(context)
                                  .devicePixelRatio,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 2.3,
                          width: 936 *
                              MediaQuery.of(context)
                                  .devicePixelRatio,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 120, right: 150),
                    child: Container(
                      child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: (itemHeight / itemWidth),
                        controller: ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: List.generate(blogdata.length, (index) {
                          final blog = blogdata[index];
                          return Container(
                            color: Colors.transparent,
                            margin: EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    margin: EdgeInsets.all(0.2),
                                    height: sheight * 0.295,
                                    width: swidth * 0.23,
                                    child: Image.network(
                                      blog.images != null && blog.images.isNotEmpty
                                          ? 'https://gotodestination.in/api/images/blog_img/${blog.images}'
                                          : 'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png',
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception, StackTrace stackTrace) {
                                        return Image.network(
                                          'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png',
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  width: swidth * 0.23,
                                  child: Center(
                                    child: Text(
                                      blog.blogName ??
                                          'Maximizing Cost Efficiency with Hybrid Development Using Flutter Technology',
                                      style: GoogleFonts.rajdhani(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  height: 0.78,
                                  width: 60 *
                                      MediaQuery.of(context)
                                          .devicePixelRatio,
                                  color: Colors.blue,
                                ),
                                SizedBox(height: 15),
                                SizedBox(
                                  width: swidth * 0.23,
                                  child: Text(
                                    blog.description ??
                                        'In today’s digital age, where attention spans are shrinking, visual content has become paramount for businesses aiming to stand out in a crowded marketplace. Among the various visual mediums, graphic design and video content play pivotal roles in capturing audience attention, conveying brand messages effectively, and ultimately driving business growth. Here are several reasons why […]',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 3,
                                  ),
                                ),
                                SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BlogDetailsPage(
                                          id: blog.bId,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Container(
                                      height: sheight * 0.04,
                                      width: swidth * 0.08,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF0D47A1),
                                            Color(0xFF42A5F5)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(255, 177, 182, 186)
                                                .withOpacity(0.5),
                                            spreadRadius: 0,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "READ MORE »",
                                          style: GoogleFonts.rajdhani(
                                            textStyle: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: sheight * 0.1),
                  buildFooter(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:trip/screens/blog/blog_details_page.dart';

// import '../../api_services/blog_api/get_blog_details_api.dart';
// import '../Drawer.dart';
// import '../footer.dart';
// import '../header.dart';

// class BlogPage extends StatefulWidget {
//   const BlogPage({key});

//   @override
//   State<BlogPage> createState() => _BlogPageState();
// }

// List<String> urls = [
//   'https://hsoftech.com/wp-content/uploads/2024/03/Importance-Graphic-Design_Video_Business-Growth-1024x320.jpg',
//   'https://hsoftech.com/wp-content/uploads/2024/03/Importance-Graphic-Design_Video_Business-Growth-SEO-new-1024x320.jpg',
//   'https://hsoftech.com/wp-content/uploads/2024/03/Hybird-Development-1024x320.jpg',
//   'https://hsoftech.com/wp-content/uploads/2021/12/Digital-Marketing-slider-1200-x-500-1-1024x427.jpg',
//   'https://hsoftech.com/wp-content/uploads/2021/12/Mobile-Application-slider-1200-x-500-1024x427.jpg'
// ];

// class _BlogPageState extends State<BlogPage> {
//   @override
//   void initState() {
//     super.initState();
//     blogdetails();
//   }

//   List<Datum> blogdata = [];
//   blogdetails() async {
//     BlogObj obj = await getblog();
//     List<Datum> data = obj.data;
//     setState(() {
//       blogdata = data;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var sheight = MediaQuery.of(context).size.height;
//     var swidth = MediaQuery.of(context).size.width;
//     final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
//     final double itemWidth = size.width / 3;
//     return Scaffold(
//         appBar: swidth < 600
//             ? AppBar(
//                 iconTheme: const IconThemeData(color: Colors.black, size: 40),
//                 backgroundColor: Color.fromARGB(255, 1, 21, 101),
//                 title: Text(
//                   "Blog",
//                   style: TextStyle(
//                       fontSize: 22,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700),
//                 ),
//               )
//             : CustomAppBar(),
//         drawer: swidth < 600 ? drawer() : null,
//         body: SingleChildScrollView(
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Center(
//               child: Container(
//                 width: swidth,
//                 height: sheight * 0.55,
//                 // color: Colors.amber,
//                 child: Image.network(
//                   'https://wallpaperbat.com/img/44615-beautiful-travel-destination-landscape-wallpaper-4k.jpg',
//                   filterQuality: FilterQuality.high,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 150),
//               child: Text(
//                 "BLOG POSTS",
//                 style: GoogleFonts.rajdhani(
//                   textStyle: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     // Add other text styles as needed
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 150, top: 5),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 2.3, // Thickness of the line
//                     width: 25 *
//                         MediaQuery.of(context)
//                             .devicePixelRatio, // Width in logical pixels
//                     color: Colors.blue,
//                   ),
//                   Container(
//                     height: 2.3, // Thickness of the line
//                     width: 936 *
//                         MediaQuery.of(context)
//                             .devicePixelRatio, // Width in logical pixels
//                     color: Colors.grey.shade300,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 120, right: 150),
//               child: Container(
//                 child: GridView.count(
//                   crossAxisCount: 3,
//                   childAspectRatio: (itemHeight / itemWidth),
//                   controller: ScrollController(keepScrollOffset: false),
//                   shrinkWrap: true,
//                   scrollDirection: Axis.vertical,
//                   children: List.generate(blogdata.length, (index) {
//                     final blog = blogdata[index];
//                     return Container(
//                       color: Colors.transparent,
//                       margin: EdgeInsets.all(15.0),
//                       child: Column(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(
//                                 12), // Adjust the border radius as needed
//                             child: Container(
//                               // color: Colors.blue,
//                               margin: EdgeInsets.all(0.2),
//                               height: sheight * 0.295,
//                               width: swidth * 0.23,
//                               child: Image.network(
//                                 blog.images != null && blog.images.isNotEmpty
//                                     ? 'https://gotodestination.in/api/images/blog_img/${blog.images}'
//                                     : 'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png', // Replace with your default image URL
//                                 filterQuality: FilterQuality.high,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (BuildContext context,
//                                     Object exception, StackTrace stackTrace) {
//                                   return Image.network(
//                                     'https://www.freeiconspng.com/thumbs/no-image-icon/no-image-icon-6.png', // Replace with your default image URL
//                                     fit: BoxFit.cover,
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           SizedBox(
//                             // height: sheight * 0.2,
//                             width: swidth * 0.23,
//                             child: Center(
//                               child: Text(
//                                 blog.blogName ??
//                                     'Maximizing Cost Efficiency with Hybrid Development Using Flutter Technology',
//                                 style: GoogleFonts.rajdhani(
//                                   textStyle: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     // Add other text styles as needed
//                                   ),
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Container(
//                             height: 0.78, // Thickness of the line
//                             width: 60 *
//                                 MediaQuery.of(context)
//                                     .devicePixelRatio, // Width in logical pixels
//                             color: Colors.blue,
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                             width: swidth * 0.23,
//                             // height: sheight * 0.36,
//                             child: Text(
//                               blog.description ??
//                                   'In today’s digital age, where attention spans are shrinking, visual content has become paramount for businesses aiming to stand out in a crowded marketplace. Among the various visual mediums, graphic design and video content play pivotal roles in capturing audience attention, conveying brand messages effectively, and ultimately driving business growth. Here are several reasons why […]',
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               maxLines: 3,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => BlogDetailsPage(
//                                             id: blog.bId,
//                                           )));
//                             },
//                             child: Material(
//                               elevation: 5.0,
//                               borderRadius: BorderRadius.circular(8.0),
//                               child: Container(
//                                 // margin: EdgeInsets.fromLTRB(150, 0, 150, 0),
//                                 height: sheight * 0.04,
//                                 width: swidth * 0.08,
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Color(0xFF0D47A1),
//                                       Color(0xFF42A5F5)
//                                     ],
//                                     begin: Alignment.topLeft,
//                                     end: Alignment.bottomRight,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Color.fromARGB(255, 177, 182, 186)
//                                           .withOpacity(0.5),
//                                       spreadRadius: 0,
//                                       blurRadius: 5,
//                                       offset: Offset(0, 3),
//                                     ),
//                                   ],
//                                   // color: Colors.deepOrange.shade300,
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     "READ MORE »",
//                                     style: GoogleFonts.rajdhani(
//                                       textStyle: TextStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: sheight * 0.1,
//             ),
//             buildFooter(),
//           ]),
//         ));
//   }
// }





// ====











// ============
              // ListView.separated(
              //     shrinkWrap: true,
              //     separatorBuilder: (context, index) => SizedBox(
              //           height: 20,
              //         ),
              //     itemCount: blogdata.length,
              //     itemBuilder: ((context, index) {
              //       final blog = blogdata[index];
              //       return Center(
              //         child: Padding(
              //           padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               SizedBox(height: sheight*0.1,),
              //               Container(
              //                 width: swidth * 0.3,
              //                 height: sheight * 0.3,
              //                 // color: Colors.amber,
              // child: Image.network(
              //  'https://gotodestination.in/api/images/blog_img/${blog.images}'?? urls[index],
              //   filterQuality: FilterQuality.high,
              //   fit: BoxFit.contain,
              // ),
              //               ), SizedBox(
              //                 height: 15,
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.only(top: 0,bottom: 5),
              //                 child: SizedBox(
              //                   width: swidth * 0.3,
              //                   // height: sheight * 0.3,
              //                   child: Text(
              //                   blog.blogName ??  'The Importance of Graphic Design and Video for Business Growth',
              //                     style: TextStyle(
              //                         fontSize: 20, fontWeight: FontWeight.w500),
              //                   ),
              //                 ),
              //               ),
              // SizedBox(
              //   height: 15,
              // ),
              // SizedBox(
              //   width: swidth * 0.3,
              //   // height: sheight * 0.3,
              //   child: Text(
              //    blog.description ??  'In today’s digital age, where attention spans are shrinking, visual content has become paramount for businesses aiming to stand out in a crowded marketplace. Among the various visual mediums, graphic design and video content play pivotal roles in capturing audience attention, conveying brand messages effectively, and ultimately driving business growth. Here are several reasons why […]',
              //     style: TextStyle(
              //         fontSize: 12, fontWeight: FontWeight.w500),
              //   ),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) =>
              //                 BlogDetailsPage(id: blog.bId,)));
              //   },
              //   child: Text('READ MORE →',
              //       style: TextStyle(
              //           color: Color.fromARGB(255, 185, 21, 21),
              //           fontSize: 12,
              //           fontWeight: FontWeight.w500)),
              // ),

              //             ],
              //           ),
              //         ),
              //       );
              //     })),

// SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(95, 20, 95, 20),
//             child: Column(children: [
//               if (blogdata.isNotEmpty)
//                 ListView.separated(
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       final blog = blogdata[index];
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               // color: Color.fromARGB(255, 198, 37, 37),
//                               height: 300,
//                               width: 300,
//                               child: Image.network(
//                                 'https://gotodestination.in/api/images/blog_img/${blog.images}',
//                                 filterQuality: FilterQuality.high,
//                                 fit: BoxFit.contain,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 15,
//                                 ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // SizedBox(
                                //   height: sheight * 0.1,
                                //   width: swidth * 0.3,
                                //   child: Text(
                                //     blog.blogName ??
                                //         'Maximizing Cost Efficiency with Hybrid Development Using Flutter Technology',
                                //     style: TextStyle(
                                //         color: Colors.black,
                                //         fontSize: 20,
                                //         fontWeight: FontWeight.w600),
                                //   ),
                                // ),
//                                 SizedBox(
//                                   height: sheight * 0.1,
//                                   width: swidth * 0.3,
//                                   child: Text(
//                                     blog.description ??
//                                         'In the rapidly evolving landscape of mobile application development, businesses are continually seeking ways to optimize their resources while delivering high-quality products to their users. One approach gaining significant traction in recent years is hybrid development, leveraging frameworks like Flutter to create cost-effective solutions without compromising on performance or user experience. Understanding Hybrid DevelopmentHybrid […]',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                 ),SizedBox(
//                                   height: 10,
//                                 ),
//                                 GestureDetector(
                                  // onTap: () {
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>BlogDetailsPage(id: blog.bId,)));
                                  // },
//                                   child: Text(
//                                       "Read More →",
//                                       style: TextStyle(
//                                           color: Color.fromARGB(255, 255, 137, 64),
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) {
//                       return SizedBox(
//                         height: 20,
//                       );
//                     },
//                     itemCount: blogdata.length)
//             ]),
//           ),
//         )