import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:camera/camera.dart';
import 'camerapage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int input1Selection = 1;
  int input2Selection = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/Frinks_logo.png',
                width: double.infinity,
                height: 60,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              const Text(
                'Frinks AI OCR Demo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(8.0),
                child: const Center(
                  child: Text(
                    "Input 1",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: input1Selection,
                    onChanged: (int? value) {
                      setState(() {
                        input1Selection = value!;
                      });
                    },
                    activeColor: const Color(0xFF6B4EFF),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraScreen(
                            onImageCaptured: (XFile? image) {
                              if (image != null) {
                                // Implement your logic to use the captured image
                              }
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B4EFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Capture Image",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: const Text(
                      'IMAGENAME.jpg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.all(8.0),
                child: const Center(
                  child: Text(
                    "Input 2",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: input2Selection,
                    onChanged: (int? value) {
                      setState(() {
                        input2Selection = value!;
                      });
                    },
                    activeColor: const Color(0xFF6B4EFF),
                  ),
                  ElevatedButton(
                    onPressed: input2Selection == 1
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CameraScreen(
                                  onImageCaptured: (XFile? image) {
                                    if (image != null) {
                                      // Implement your logic to use the captured image
                                    }
                                  },
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B4EFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Capture Image",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: const Text(
                      'IMAGENAME.jpg',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: input2Selection,
                    onChanged: (int? value) {
                      setState(() {
                        input2Selection = value!;
                      });
                    },
                    activeColor: const Color(0xFF6B4EFF),
                  ),
                  const Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Manual Input',
                    ),
                    keyboardType: TextInputType.text,
                  ))
                ],
              ),
              const SizedBox(height: 20),
              input2Selection == 1
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.black,
                          padding: const EdgeInsets.all(8.0),
                          child: const Center(
                            child: Text(
                              "Output",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text("Output 1:"),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/images/Frinks_logo.png',
                          width: double.infinity,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        const Text("Output 2:"),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/images/Frinks_logo.png',
                          width: double.infinity,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Text("Text Output:"),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: const Text("LOREM IPSUM"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            print("reset");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6B4EFF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Text(
                            "Reset",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class ZoomableImageScreen extends StatelessWidget {
  const ZoomableImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zoomable Image'),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: const AssetImage('assets/images/Frinks_logo.png'),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2.0,
        ),
      ),
    );
  }
}
