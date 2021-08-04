import 'package:MyBMTC/helper/fontCustomizer.dart';
import 'package:MyBMTC/helper/http_exception.dart';
import 'package:MyBMTC/helper/message.dart';
import 'package:MyBMTC/providers/Auth.dart';
import 'package:MyBMTC/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

final GlobalKey<FormState> _amountFormKey = GlobalKey<FormState>();

class WalletScreen extends StatefulWidget {
  static final route = 'WalletScreen';
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  FSBStatus drawerStatus;
  bool _isLoading = false;
  bool _isFirstTime = true;
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

    return SwipeDetector(
      onSwipeLeft: () {
        setState(() {
          drawerStatus = FSBStatus.FSB_CLOSE;
        });
      },
      onSwipeRight: () {
        setState(() {
          drawerStatus = FSBStatus.FSB_OPEN;
        });
      },
      child: FoldableSidebarBuilder(
        status: drawerStatus,
        drawer: CustomDrawer(),
        screenContents: dashboardScreenBody(height, width),
        drawerBackgroundColor: Colors.white,
      ),
    );
  }

  String userInAmount;

  Widget dashboardScreenBody(double height, double width) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      backgroundColor: Color(0xe6363450),
      appBar: AppBar(
        backgroundColor: Color(0xff363450),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              drawerStatus == FSBStatus.FSB_OPEN
                  ? Icons.close
                  : Icons.sort_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                    ? FSBStatus.FSB_CLOSE
                    : FSBStatus.FSB_OPEN;
              });
            }),
        title: Text(
          'My Wallet',
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
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: width - 20,
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
                        offset:
                            Offset(0.0, 0.5), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Lottie.asset('assets/lottie/wallet.json'),
                        height: height / 4,
                        width: width,
                      ),
                      Text(
                        'Amount',
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Rs.${auth.amount}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontCustomizer.textFontSize(
                                  fontSize: 40, screenWidth: width),
                              color: Colors.white,
                            ),
                          ),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          // IconButton(
                          //   icon: Icon(
                          //     Icons.refresh_rounded,
                          //     color: Colors.white,
                          //     size: 30,
                          //   ),
                          //   onPressed: () {},
                          // ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Consumer<Auth>(
                          builder: (ctx, authData, _) => authData.isAmount
                              ? Form(
                                  key: _amountFormKey,
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
                                )
                              : Container()),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (auth.isAmount && userInAmount.length != 0) {
                            _amountFormSaving();
                          }
                          auth.isAmount = !auth.isAmount;

                          // Navigator.pushNamed(
                          //     context, MapWebviewScreen.route,
                          //     arguments: {
                          //       "from": fromData,
                          //       "to": toData
                          //     });
                        },
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
              ],
            ),
    );
  }

  void _amountFormSaving() async {
    if (_amountFormKey.currentState.validate()) {
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
