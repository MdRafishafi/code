import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/colors.dart';

class AboutDevelopers extends StatefulWidget {
  static final String id = 'AboutDevelopers';
  static final route = 'AboutDevelopers';
  @override
  _AboutDevelopersState createState() => _AboutDevelopersState();
}

class _AboutDevelopersState extends State<AboutDevelopers> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBlurAccentColor2,
      appBar: AppBar(
        backgroundColor: kAccentColor2,
        title: Text('About Developers '),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              _developerContainer(
                image: "assets/images/aditya.jpg",
                name: "ADITYA SINGH",
                usn: "1VE17CS004",
                description:
                    'A forward-thinking developer pursuing his B.E from Sri Venkateshwara College Of Engineering Bangalore.Interested in various fields such as artificial intelligence , machine learning etc.Trying to achieve his goal to become good developer.',
                mailId: "adityassingh01@gmail.com",
                phoneNumber: "+91-9606661976",
                isRight: true,
                instagram: "/apka_pyara_aditya",
                github: "/adityasingh",
                linkedIn: "/aditya-singh",
                facebook: "/adityasingh",
              ),
              SizedBox(
                height: height * 0.01,
              ),
              _developerContainer(
                image: "assets/images/rafi.jpeg",
                name: "G Mohammad Rafi",
                usn: "1VE17CS038",
                description:
                    'I am currently enrolled as a senior in the Sri Venkateshwara college of engineering (SVCE) pursuing an undergraduate degree. I am interested in the Mobile Application Development, Web Development field and Machine Learning. ',
                mailId: "mohammmadrafi2999@gmail.com",
                phoneNumber: "+91-9535098175",
                isRight: false,
                instagram: '/mohammaad.rafi',
                github: '/MdRafishafi',
                linkedIn: '/mohammad-rafi',
                facebook: '/mohammaad.rafi',
              ),
              SizedBox(
                height: height * 0.01,
              ),
              _developerContainer(
                image: "assets/images/sreeram.jpeg",
                name: 'BADDILA SREERAM',
                usn: '1VE17CS019',
                description:
                    'A forward-thinking developer pursuing his B.E from Sri Venkateshwara College Of Engineering Bangalore.Interested in various fields such as artificial intelligence , machine learning etc.Trying to achieve his goal to become good developer.',
                mailId: 'baddilasreeram@gmail.com',
                phoneNumber: '+91-8341777097',
                isRight: true,
                instagram: '/sreeram',
                github: '/SreeRam',
                linkedIn: '/sree-ram',
                facebook: '/sreeram',
              ),
              SizedBox(
                height: height * 0.01,
              ),
              _developerContainer(
                image: "assets/images/sanyam.jpeg",
                name: 'SANYAM',
                usn: '1VE16CS132',
                description:
                    'A forward-thinking developer pursuing his B.E from Sri Venkateshwara College Of Engineering Bangalore.Interested in various fields such as artificial intelligence , machine learning etc.Trying to achieve his goal to become good developer.',
                mailId: 'sanyammatta1998@gmail.com',
                phoneNumber: '+91-8929399337',
                isRight: false,
                instagram: '/onceyoulike',
                github: '/sanyammatta',
                linkedIn: '/sanyam-matta',
                facebook: '/sanyam.matta',
              ),
            ],
          ),
        ),
      ),
    );
  }

  _developerContainer({
    String image,
    String name,
    String usn,
    String description,
    String mailId,
    String phoneNumber,
    String instagram,
    String github,
    String linkedIn,
    String facebook,
    bool isRight,
  }) {
    double r = isRight ? 10 : 100, l = isRight ? 100 : 10;
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 200.0, //apne flip card ka heighgt h
            // height: 250.0,
            margin: EdgeInsets.only(
              top: 5,
              right: r,
              left: l,
            ),
            child: FlipCard(
              direction: FlipDirection.HORIZONTAL, // default
              front: Material(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3).withOpacity(0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                      ), //ye orange wala ka height h
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0),
                            child: ListTile(
                              leading: Container(
                                width: 50.0, // ye circle ka height h
                                height: 50.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(image),
                                  ),
                                ),
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(top: 13.0),
                                child: Center(
                                  child: Text(name,
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Center(
                                  child: Text(
                                    usn,
                                    style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffff520d).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 8.0, right: 8.0),
                            child: Text(
                              description,
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 8.0, right: 8.0),
                            child: Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    child: Icon(FontAwesomeIcons.envelope,
                                        color: Color(0xffff520d))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    child: Text(
                                      mailId,
                                      style: TextStyle(
                                        color: Color(0xffff520d),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, left: 8.0, right: 8.0),
                            child: Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    child: Icon(FontAwesomeIcons.phoneAlt,
                                        color: Color(0xffff520d))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    child: Text(
                                      phoneNumber,
                                      style: TextStyle(
                                        color: Color(0xffff520d),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              back: Material(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 1.0),
                              child: ListTile(
                                leading: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(image),
                                        ))),
                                title: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 17.0),
                                    child: Text('Social Media Links',
                                        style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffff0d41).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              width: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 8.0, right: 8.0),
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Container(
                                      child: Icon(
                                    FontAwesomeIcons.instagramSquare,
                                    color: Color(0xffff0d41),
                                    size: 20.0,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      child: Text(
                                        instagram,
                                        style: TextStyle(
                                          color: Color(0xffff0d41),
                                          fontSize: 20.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 8.0, right: 8.0),
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Container(
                                      child: Icon(
                                    FontAwesomeIcons.github,
                                    color: Color(0xffff0d41),
                                    size: 20.0,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      child: Text(
                                        github,
                                        style: TextStyle(
                                          color: Color(0xffff0d41),
                                          fontSize: 20.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 8.0, right: 8.0),
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Container(
                                      child: Icon(
                                    FontAwesomeIcons.linkedin,
                                    color: Color(0xffff0d41),
                                    size: 20.0,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      child: Text(
                                        linkedIn,
                                        style: TextStyle(
                                          color: Color(0xffff0d41),
                                          fontSize: 20.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 8.0, right: 8.0),
                              child: Container(
                                  child: Row(
                                children: <Widget>[
                                  Container(
                                      child: Icon(
                                    FontAwesomeIcons.facebook,
                                    color: Color(0xffff0d41),
                                    size: 20.0,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      child: Text(
                                        facebook,
                                        style: TextStyle(
                                          color: Color(0xffff0d41),
                                          fontSize: 20.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ); //row for aditya
  }
}
