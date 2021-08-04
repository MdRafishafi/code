import 'dart:io';

import 'package:MyBMTC/helper/fontCustomizer.dart';
import 'package:MyBMTC/helper/message.dart';
import 'package:MyBMTC/providers/Auth.dart';
import 'package:MyBMTC/providers/busDetails.dart';
import 'package:MyBMTC/screens/receiptScreen.dart';
import 'package:MyBMTC/screens/takePictureScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<FormState> _amountInFaceIDFormKey = GlobalKey<FormState>();

class FaceIdFetchScreen extends StatefulWidget {
  static final route = 'FaceIdFetchScreen';
  const FaceIdFetchScreen({Key key}) : super(key: key);

  @override
  _FaceIdFetchScreenState createState() => _FaceIdFetchScreenState();
}

class _FaceIdFetchScreenState extends State<FaceIdFetchScreen> {
  List<String> _imageFilesList = [];
  bool _isLoading = false;
  bool _isFirstTime = true;
  String userInAmount;

  @override
  void didChangeDependencies() {
    if (_isFirstTime) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Auth>(context, listen: false).getWalletAmount().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
      _isFirstTime = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Map<String, dynamic> mapData = ModalRoute.of(context).settings.arguments;
    int totalTicket = mapData["total_ticket"];
    double totalCost = mapData["total_cost"];

    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xe6363450),
      appBar: AppBar(
        backgroundColor: Color(0xff363450),
        centerTitle: true,
        title: Text(
          'BOOK TICKET',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<Auth>(
              builder: (ctx, authData, child) => authData.amount < totalCost
                  ? Container(
                      width: width - 20,
                      height: height / 2.5,
                      alignment: Alignment.center,
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
                            offset: Offset(
                                0.0, 0.5), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Insufficient Amount',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontCustomizer.textFontSize(
                                  fontSize: 25, screenWidth: width),
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Amount in your account: ',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontCustomizer.textFontSize(
                                      fontSize: 20, screenWidth: width),
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Rs.${authData.amount}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: FontCustomizer.textFontSize(
                                      fontSize: 20, screenWidth: width),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Ticket Cost: ',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: FontCustomizer.textFontSize(
                                      fontSize: 20, screenWidth: width),
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Rs.$totalCost',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: FontCustomizer.textFontSize(
                                      fontSize: 20, screenWidth: width),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Form(
                            key: _amountInFaceIDFormKey,
                            child: TextFormField(
                              onFieldSubmitted: (term) {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                currentFocus.unfocus();
                              },
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter a valid name';
                                }
                                return null;
                              },
                              onChanged: (String value) {
                                userInAmount = value;
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(
                                  fontSize: FontCustomizer.textFontSize(
                                      fontSize: 16, screenWidth: width),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.1),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: _amountFormSaving,
                            child: Container(
                              height: 34,
                              decoration: BoxDecoration(
                                color: Color(0xad1AFFD5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 4,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Add Amount",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1C1C1C),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : child,
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: _imageFilesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${index + 1}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: _imageFilesList[index] != null &&
                                        _imageFilesList[index].isNotEmpty
                                    ? Image.file(
                                        File(_imageFilesList[index]),
                                        fit: BoxFit.cover,
                                        height: 80.0,
                                        width: 80.0,
                                      )
                                    : Image.asset(
                                        "assets/images/transparent_placeholder.png",
                                        fit: BoxFit.cover,
                                        height: 80.0,
                                        width: 80.0,
                                      ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _imageFilesList.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    color: Colors.redAccent,
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  _imageFilesList.length == totalTicket
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: _submitFaceID,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              height: 40,
                              width: width / 1.3,
                              decoration: BoxDecoration(
                                color: Color(0xad1AFFD5),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 4,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Make Payment",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1C1C1C),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
      floatingActionButton: _isLoading
          ? Container()
          : auth.amount < totalCost
              ? Container()
              : _imageFilesList.length != totalTicket
                  ? CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xad1AFFD5),
                      child: IconButton(
                        onPressed: () async {
                          var result = await Navigator.pushNamed(
                              context, TakePictureScreen.route);
                          setState(() {
                            if (result != null) _imageFilesList.add(result);
                          });
                        },
                        icon: Icon(Icons.camera_enhance),
                        color: Colors.white,
                        iconSize: 30,
                      ),
                    )
                  : Container(),
    );
  }

  customiseContainer({Widget child, double width}) {
    return Container(
      width: width,
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
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
      child: child,
    );
  }

  // void _openImagePicker(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: 150.0,
  //           padding: EdgeInsets.all(20.0),
  //           child: Column(
  //             children: <Widget>[
  //               Center(
  //                 child: Text(
  //                   "Select Image",
  //                   style: TextStyle(
  //                     fontSize: 25.0,
  //                     fontWeight: FontWeight.bold,
  //                     color: Color(0xF5404B60),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10.0,
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   _getImage(context, ImgSource.Camera);
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Row(
  //                   children: <Widget>[
  //                     Icon(
  //                       Icons.photo_camera,
  //                       size: 30.0,
  //                       color: Color(0xF5404B60),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: 10.0,
  //                       ),
  //                     ),
  //                     Text(
  //                       "Use Camera",
  //                       style: TextStyle(
  //                         fontSize: 15.0,
  //                         color: Color(0xF5404B60),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 10.0,
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   _getImage(context, ImgSource.Gallery);
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: Row(
  //                   children: <Widget>[
  //                     Icon(
  //                       Icons.camera,
  //                       size: 30.0,
  //                       color: Color(0xF5404B60),
  //                     ),
  //                     Padding(
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: 10.0,
  //                       ),
  //                     ),
  //                     Text(
  //                       "Use Gallery",
  //                       style: TextStyle(
  //                         fontSize: 15.0,
  //                         color: Color(0xF5404B60),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  // _getImage(BuildContext context, ImgSource source) async {
  //   var pickedFile = await ImagePickerGC.pickImage(
  //     context: context,
  //     source: source,
  //     maxWidth: 2000.0,
  //     maxHeight: 2000.0,
  //     imageQuality: 100,
  //   );
  //   setState(() {
  //     _imageFilesList.add(pickedFile.path);
  //   });
  //   //     .then((File image) async {
  //   //   if (image != null) {
  //   //     setState(() {
  //   //       _imageFilesList.add(image.path);
  //   //     });
  //   //   }
  //   // });
  // }

  _submitFaceID() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final propertyData =
          Provider.of<BusDetailsProvider>(context, listen: false);
      final authData = Provider.of<Auth>(context, listen: false);
      Map<String, dynamic> mapData = ModalRoute.of(context).settings.arguments;
      mapData["userID"] = authData.userId;
      await propertyData.bookTicket(_imageFilesList, mapData);
      mapData["images"] = _imageFilesList;
      Navigator.pushNamed(
        context,
        ReceiptScreen.route,
        arguments: mapData,
      );
      setState(() {
        _isLoading = false;
      });
    } on HttpException catch (error) {
      Message.showErrorDialog(
        message: error.toString(),
        context: context,
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      Message.showErrorDialog(
          icon: true,
          message: "Something went wrong. please try again !!",
          context: context);
    }
  }

  void _amountFormSaving() async {
    if (_amountInFaceIDFormKey.currentState.validate()) {
      try {
        await Provider.of<Auth>(context, listen: false).addAmountToWallet(
          int.parse(userInAmount),
        );

        Message.toastMessage(
          message: "Amount added",
          context: context,
        );
      } on HttpException catch (error) {
        Message.showErrorDialog(
          message: error.toString(),
          context: context,
        );
      } catch (e) {
        Message.showErrorDialog(
          message: "Something went wrong",
          icon: true,
          context: context,
        );
      }
    }
  }
}
