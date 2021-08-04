import 'package:MyBMTC/helper/message.dart';
import 'package:MyBMTC/widgets/bookingCard.dart';
import 'package:MyBMTC/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

import '../helper/http_exception.dart';
import '../providers/Auth.dart';
import '../providers/busDetails.dart';

class MyBookings extends StatefulWidget {
  static final route = 'MyBookings';
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  FSBStatus drawerStatus;

  bool _isFirstTime = true;
  bool _isLoading = false;

  initialMethod() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<BusDetailsProvider>(context, listen: false)
          .bookedTicketDetails(
              Provider.of<Auth>(context, listen: false).userId);
    } on HttpException catch (error) {
      Message.showErrorDialog(
        message: error.toString(),
        context: context,
      );
    } catch (e) {
      print(e.toString());
      Message.showErrorDialog(
        message: "Something went wrong",
        icon: true,
        context: context,
      );
    }
    setState(() {
      _isLoading = false;
    });
    _isFirstTime = false;
  }

  @override
  void didChangeDependencies() {
    if (_isFirstTime) {
      initialMethod();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
        screenContents: dashboardScreenBody(),
        drawerBackgroundColor: Colors.white,
      ),
    );
  }

  Widget dashboardScreenBody() {
    final busDetailsProvider =
        Provider.of<BusDetailsProvider>(context, listen: false);
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
          'My Bookings',
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
          : Consumer<BusDetailsProvider>(
              builder: (ctx, busDetails, _) => ListView.builder(
                  itemCount: busDetails.listBookedTicket.length,
                  itemBuilder: (ctx, ticketIndex) {
                    return ChangeNotifierProvider.value(
                      value: busDetails.listBookedTicket[ticketIndex],
                      child: BookingCard(),
                    );
                    // return ChangeNotifierProvider.value(
                    //   value: busDetailsProvider.listBookedTicket[ticketIndex],
                    //   child: BookingCard(),
                    // );
                  }),
            ),
    );
  }
}
