import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant.dart';
// import 'package:url_launcher/url_launcher.dart';

class buildFooter extends StatelessWidget {
  const buildFooter({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobileContainer();
        } else {
          return desktopContainer(width);
        }
      },
    );
  }

  Container mobileContainer() {
    return Container(
      color: Color(0xFF0d2b4d),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: ourProducts()),
                Expanded(child: aboutUs()),
              ],
            ),
            socialmedialinkd(),
            Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
            SizedBox(height: 10),
            followus(),
            SizedBox(height: 10),
            downloadColumn(),
            SizedBox(height: 10),
            paymentBy(),
            Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
            // allRightReserve()
          ],
        ),
      ),
    );
  }

  Container desktopContainer(double width) {
    return Container(
      color: Color(0xFF0d2b4d),
      width: width,
      height: 450.0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ourProducts(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: aboutUs(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: socialmedialinkd(),
                  )
                ]),
            SizedBox(height: 10),
            Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                followus(),
                // SizedBox(width:300.0),
                downloadColumn(),
                // SizedBox(width:150.0),
                paymentBy()
              ],
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
            // allRightReserve()
          ],
        ),
      ),
    );
  }

  // Align allRightReserve() {
  //   return Align(
  //       alignment: Alignment.bottomRight,
  //       child: Padding(
  //         padding: const EdgeInsets.all(5.0),
  //         child: Text(
  //           '@ 2022 All rights reserved',
  //           style: white15,
  //         ),
  //       ));
  // }

  Row paymentBy() {
    return Row(
      children: [
        Container(
            height: 30.0,
            width: 50.0,
            child: Image.asset('images/IATA.png', fit: BoxFit.fill)),
        SizedBox(
          width: 10.0,
        ),
        Container(
            height: 30.0,
            width: 50.0,
            child: Image.asset('images/payu.jpg', fit: BoxFit.fill)),
        SizedBox(
          width: 10.0,
        ),
        Container(
            height: 30.0,
            width: 50.0,
            child: Image.asset('images/rupay.png', fit: BoxFit.fill)),
        SizedBox(
          width: 10.0,
        ),
        Container(
            height: 30.0,
            width: 50.0,
            child: Image.asset('images/mastercard.png', fit: BoxFit.fill)),
        SizedBox(
          width: 10.0,
        ),
      ],
    );
  }

  Column downloadColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Book Tickets Faster.Download our mobile Apps', style: white15),
        SizedBox(height: 10.0),
        Row(
          children: [
            Container(
                height: 50.0,
                width: 150.0,
                child:
                    Image.asset('images/applePlayStore.png', fit: BoxFit.fill)),
            SizedBox(width: 20.0),
            Container(
                height: 50.0,
                width: 150.0,
                child: Image.asset('images/googlePlayStore.png',
                    fit: BoxFit.fill)),
          ],
        )
      ],
    );
  }

  Column followus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Follow Us',
          style: white15,
        ),
        Row(
          children: [
            Icon(FontAwesomeIcons.facebook, color: Colors.white),
            SizedBox(width: 5),
            Icon(FontAwesomeIcons.twitter, color: Colors.white),
            SizedBox(width: 5),
            Icon(FontAwesomeIcons.youtube, color: Colors.white),
          ],
        )
      ],
    );
  }

  Column socialmedialinkd() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('SOCIAL MEDIA LINKS', style: whiteB20),
      SizedBox(height: 15.0),
      TextButton(
        onPressed: () {},
        child: Text('Facebook', style: white15),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Twitter', style: white15),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Youtube', style: white15),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Instagram', style: white15),
      ),
    ]);
  }

  Column aboutUs() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('ABOUT', style: whiteB20),
      SizedBox(height: 15.0),
      TextButton(
        onPressed: () {},
        child: Text('About Us', style: white15),
      ),
      TextButton(
        onPressed: () async {
          print('launch');
          _launchURL('https://gotodestination.in/privacy.html');

          // const url = 'https://gotodestination.in/privacy.html';
          // if(await canLaunch(url)){
          // await launch(url);
          // }else {
          // throw 'Could not launch $url';
          // }
        },
        child: Text('Privacy', style: white15),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Manangement', style: white15),
      ),
      TextButton(
        onPressed: () {
          _launchURL(
              'https://gotodestination.in/user-terms-and-condition.html');
        },
        child: Text('Terms of Services', style: white15),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Customer Support', style: white15),
      ),
    ]);
  }

  Column ourProducts() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('OUR PRODUCTS', style: whiteB20),
      SizedBox(height: 15.0),
      TextButton(
        onPressed: () {},
        child: Text('Domestic Flights', style: white15),
      ),
      TextButton(
        onPressed: () {},
        child: Text('International Flights', style: white15),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Holiday Packages', style: white15),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Activity', style: white15),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Blog', style: white15),
      ),
      TextButton(
        onPressed: () {},
        child: Text('Bus', style: white15),
      ),
    ]);
  }

  // Future<void> _launchInBrowser(Uri url) async {
  //   if (!await launchUrl(url,
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     throw Exception('Could not launch $url');
  //   }
  // _launchUrl(url) async {
  //   print('_launchUrl');
  //   print(url);
  //   if (!await _launchUrl(url)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }
  _launchURL(url) async {
    // const url = 'https://flutter.dev';
    print('launch');
    print(url);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
