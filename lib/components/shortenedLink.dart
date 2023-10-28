import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:urlshortener/components.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ShortenedLink extends StatelessWidget {
  const ShortenedLink({
    super.key,
    this.shortUrl = "",
    this.orginalUrl = "",
  });

  final String shortUrl;
  final String orginalUrl;

  void copyToClipboard(String url) async {
    final data = ClipboardData(text: url);
    await Clipboard.setData(data);
  }

  void openUrl(String url) async{
    Uri uri = Uri.parse(url);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    String copyData = "";

    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Components.eerieBlack,
                width: 1,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(32)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector( //Open Link Interactor
                onLongPress: (){
                  openUrl(shortUrl);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/1.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shortUrl,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.outfit(
                          textStyle: TextStyle(
                              color: Components.eerieBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                              overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),
                      Text(
                        orginalUrl,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.outfit(
                          textStyle: TextStyle(
                            color: Components.eerieBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            letterSpacing: 0,
                              overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Components.circleButtonI( //Copy button
                Components.IconCopyBlack,
                (){
                  copyToClipboard(shortUrl);
                  print("Copied:"+shortUrl);
                }
              ),
            ],
          ),
        ),
        SizedBox(height: Components.separatorSize)
      ],
    ).animate().fade(duration: 300.ms);;
  }
}