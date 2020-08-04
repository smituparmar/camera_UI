import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;
int cameraId = 0;

class CameraApp extends StatefulWidget {
  @override
  CameraAppState createState() => CameraAppState();
}

class CameraAppState extends State<CameraApp> {
  CameraController controller;
  @override
  void initState() {
    super.initState();
    controller =
        CameraController(cameras[cameraId], ResolutionPreset.ultraHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return RotationTransition(
      turns: AlwaysStoppedAnimation(0 / 360),
      alignment: Alignment.bottomLeft,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.close,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: Container(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: controller.value.aspectRatio / deviceRatio,
                    child: Container(
                      child: CameraPreview(
                        controller,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        iconSize: 35,
                        onPressed: () {
                          setState(() {
                            cameraId = cameraId == 0 ? 1 : 0;
                            print(cameraId);
                          });
                        },
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.flash_on,
                        color: Colors.white,
                        size: 35,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      print('click');
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
