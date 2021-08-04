import 'package:MyBMTC/constants/colors.dart';
import 'package:MyBMTC/widgets/app_clipper.dart';
import 'package:flutter/material.dart';

class AboutProjectGuide extends StatefulWidget {
  static final route = 'AboutProjectGuide';
  static final String id = 'AboutProjectGuide';
  @override
  _AboutProjectGuideState createState() => _AboutProjectGuideState();
}

class _AboutProjectGuideState extends State<AboutProjectGuide> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kBlurAccentColor2,
      appBar: AppBar(
        backgroundColor: kAccentColor2,
        title: Text('About Project Guide'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * .75,
                width: MediaQuery.of(context).size.width,
                child: ClipPath(
                  clipper: AppClipper(
                    cornerSize: 50,
                    diagonalHeight: 200,
                    roundedBottom: false,
                  ),
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(top: 180, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: height * 0.05),
                        Center(
                          child: Text(
                            'P Suresh',
                            style: TextStyle(
                              fontSize: height * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        Text(
                          'Assistant Professor at Sri Venkateshwara College of Engineering',
                          style: TextStyle(
                            fontSize: height * 0.02,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height * 0.025),
                        Text(
                          '"Presently working as an Assistant Professor in Sri Venkateshwara College of Engineering in the Department of computer science and Engineering. Having 3 years of industry experience ,2 yrs of full time research and 10 yrs of teaching. Presently pursuing my Ph.D in Computer Science in Security in mobile cloud computing."',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: height * 0.0225,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: height / 8,
              left: width / 4,
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/sureshp.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
