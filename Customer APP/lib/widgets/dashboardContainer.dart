import 'package:MyBMTC/helper/fontCustomizer.dart';
import 'package:flutter/material.dart';

class DashboardContainer extends StatelessWidget {
  String route;
  String imageUrl;
  String title;
  DashboardContainer({
    this.route,
    this.imageUrl,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        height: height / 3,
        width: width / 2.5,
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 7),
        decoration: BoxDecoration(
          color: Color(0xff363450),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 0.5), // shadow direction: bottom right
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Image.asset(
                imageUrl,
              ),
            ),
            SizedBox(
              height: height * 0.001,
            ),
            Container(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: FontCustomizer.textFontSize(
                      fontSize: 17, screenWidth: width),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
