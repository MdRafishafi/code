import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../helper/http_exception.dart';
import '../providers/Auth.dart';
import '../providers/busDetails.dart';

class TakePictureScreen extends StatefulWidget {
  static final route = 'TakePictureScreen';
  final CameraDescription camera;
  const TakePictureScreen({
    Key key,
    this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  Timer timer;
  int status = 0;
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) async {
      {
        setState(() {
          status = 0;
        });
        try {
          final auth = Provider.of<Auth>(context, listen: false);
          final image = await _controller.takePicture();
          await Provider.of<BusDetailsProvider>(context, listen: false)
              .scanner(auth.userId, File(image.path));

          status = 1;
        } on HttpException catch (error) {
          // Message.showErrorDialog(
          //   message: error.toString(),
          //   context: context,
          // );
          status = 2;
          print(error.toString());
        } catch (error) {
          // Message.showErrorDialog(
          //   message: "Something went wrong",
          //   icon: true,
          //   context: context,
          // );
          status = 2;
          print(error.toString());
        }
        setState(() {});
      }
    });

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xe6363450),
      appBar: AppBar(
        backgroundColor: Color(0xff363450),
        centerTitle: true,
        title: Text(
          'Take a picture',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Center(
                  child: Transform.scale(
                    scale: 1 /
                        (_controller.value.aspectRatio *
                            MediaQuery.of(context).size.aspectRatio),
                    child: CameraPreview(_controller),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: status == 0
                        ? Lottie.asset('assets/lottie/face_scan.json')
                        : status == 1
                            ? Lottie.asset('assets/lottie/correct.json')
                            : Lottie.asset('assets/lottie/wrong.json'),
                    height: height / 4,
                    width: width,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
