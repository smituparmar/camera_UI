// Using the Camera package
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/camera_screen.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   leading: Icon(
        //     Icons.close,
        //     color: Colors.black,
        //   ),
        //   title: Text(
        //     'Photo',
        //     style: TextStyle(color: Colors.black),
        //   ),
        //   backgroundColor: Colors.white,
        // ),
        bottomNavigationBar: BottomNavBar(),
        body: CameraApp(),
        floatingActionButton: null,
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            text: 'GALLERY',
            isActive: false,
          ),
          BottomNavItem(
            text: 'PHOTO',
            isActive: true,
          ),
          BottomNavItem(
            text: 'VIDEO',
            isActive: false,
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String text;
  final bool isActive;
  const BottomNavItem({this.text, this.isActive});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: isActive
              ? Border(
                  bottom: BorderSide(width: 1),
                )
              : null,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: isActive ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
