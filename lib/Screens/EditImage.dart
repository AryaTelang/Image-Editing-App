import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_edit/Screens/Share.dart';
import 'dart:io';
import 'PickImage.dart';
import 'package:image_cropper/image_cropper.dart';

class EditImage extends StatefulWidget {
  EditImage({Key? key, required this.img}) : super(key: key);
  File? img;
  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  File? imageFile;
  CroppedFile? cropped;
  Future _cropImage(File imageFile) async {
    if (imageFile != null) {
      cropped = await ImageCropper()
          .cropImage(sourcePath: imageFile.path, aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ], uiSettings: [
        AndroidUiSettings(
            toolbarWidgetColor: Colors.brown,
            toolbarColor: Color(0xffF9E0BB),
            activeControlsWidgetColor: Colors.brown,
            statusBarColor: Color(0xffF9E0BB),
            toolbarTitle: 'Crop your image',
            cropGridColor: Colors.brown,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(title: 'Crop')
      ]);

      if (cropped != null) {
        setState(() {
          imageFile = File(cropped!.path);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    imageFile = widget.img;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDAC0A3),
      appBar: AppBar(
        title: Text(
          "Edit image",
          style: GoogleFonts.libreBaskerville(
            color: Color(0xff65451F),
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Color(0xffF9E0BB),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Preview",
                    style: GoogleFonts.libreBaskerville(
                        color: Color(0xff65451F),
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 5),
                  ),
                ),
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(widget.img!.path),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 320,
                  height: 40,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xffF9E0BB)),
                      onPressed: () {
                        _cropImage(widget.img!);
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Crop , resize, rotate your image.",
                            style: GoogleFonts.libreBaskerville(
                                color: Color(0xff65451F),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.crop,
                            color: Colors.brown,
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 350,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: cropped != null
                        ? Column(
                            children: [
                              Image.file(
                                File(cropped!.path),
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 320,
                                  height: 40,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xffF9E0BB)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SharePage(img: cropped)));
                                      },
                                      child: Text("Share",style: GoogleFonts.libreBaskerville(
                                          color: Color(0xff65451F),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))),
                                ),
                              )
                            ],
                          )
                        : Container(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
