import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharePage extends StatefulWidget {
  SharePage({Key? key, required this.img}) : super(key: key);
  CroppedFile? img;
  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  TextEditingController Captioncontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    Captioncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffDAC0A3),
        appBar: AppBar(
          title: Text(
            "Share Image",
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: Captioncontroller,
                      cursorColor: Colors.brown,
                      autocorrect: true,
                      decoration: InputDecoration(
                          label: Text('Add a caption to your photo',style: GoogleFonts.libreBaskerville(color: Colors.brown),)),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.lightGreen,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: IconButton(
                            onPressed: () async {
                              await Share.shareFiles([widget.img!.path],
                                  text: Captioncontroller.text);
                            },
                            icon: Icon(
                              Icons.share,
                              color: Colors.white,
                            )),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
