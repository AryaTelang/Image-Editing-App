import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_edit/Random.dart';
import 'package:image_edit/Screens/EditImage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PickImage extends StatefulWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? img;
  Future pickImage(ImageSource src) async {
    try {
      final img = await ImagePicker().pickImage(source: src);
      if (img == null) return;
      final imageTemp = File(img.path);
      this.img = imageTemp;
      setState(() {
        this.img = imageTemp; // to update the UI
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDAC0A3),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Image Editor",
              style: GoogleFonts.libreBaskerville(
                  color: Color(0xff65451F),
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5),
            ),
            SizedBox(
              height: 70,
            ),
            img != null
                ? Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        img!,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Color(0xffF9E0BB),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Choose an image",
                        style: GoogleFonts.libreBaskerville(
                            color: Color(0xff65451F),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            TextButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>EditImage(img: img!)));
              },
              child: Text(
                "Click here to edit",
                style: GoogleFonts.libreBaskerville(),
              ),
              style: TextButton.styleFrom(primary: Color(0xff65451F)),
            ),
            SizedBox(
              height: 70,
            ),
            SizedBox(
              width: 320,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xffF9E0BB)),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Text(
                        "  Pick an image from gallery  ",
                        style: GoogleFonts.libreBaskerville(
                            color: Color(0xff65451F),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.image,
                        color: Colors.brown,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 320,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xffF9E0BB)),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "Open your camera  ",
                        style: GoogleFonts.libreBaskerville(
                            color: Color(0xff65451F),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.camera_alt,
                        color: Colors.brown,
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
