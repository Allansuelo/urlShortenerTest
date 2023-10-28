import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Components{
  //Colors for the app
  static Color antiFlashWhite = Color.fromRGBO(240, 240, 240, 1);
  static Color eerieBlack = Color.fromRGBO(24, 24, 24, 1);
  static Color silver = Color.fromRGBO(201, 201, 201, 1);
  static Color dimGray = Color.fromRGBO(201, 201, 201, 1);

  //Sizes
  static double iconsSize = 20;
  //Sizes for circle icon button
  static double circleButtonSize = 48;
  static double circleButtonPadding = 12;
  static double circleButtonBorderRadius = 24;
  //Separator or the saved url
  static double separatorSize = 12;

  //Preloaded logo
  static Widget logo = SvgPicture.asset(
    width: 137,
    height: 28,
    'assets/logo.svg',
    semanticsLabel: 'Link Icon',
  );

//Preloaded Icons
  static Widget IconLinkBlack = SvgPicture.asset(
    width: iconsSize,
    height: iconsSize,
    'assets/iconsBlack/icon=link.svg',
    semanticsLabel: 'Link Icon',
  );

  static Widget IconCopyBlack = SvgPicture.asset(
    width: iconsSize,
    height: iconsSize,
    'assets/iconsBlack/icon=copy.svg',
    semanticsLabel: 'Copy Icon',
  );

  static Widget IconSendWhite = SvgPicture.asset(
    width: iconsSize,
    height: iconsSize,
    'assets/iconsWhite/icon=send.svg',
    semanticsLabel: 'Send Icon',
  );

  //Circle icon button
  static circleButton(Widget icon,var action){
    return
        GestureDetector(
          onTap: () {
            action();
          },
          child: Center(
            child: Container(
              width: circleButtonSize,
              height: circleButtonSize,
              decoration: BoxDecoration(
                  color: eerieBlack,
                  border: Border.all(
                      color: eerieBlack,
                      width: 1,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(circleButtonBorderRadius)
              ),
              child: Padding(
                padding: EdgeInsets.all(circleButtonPadding),
                child: icon,
              ),
            ),
          )
        );
  }
  //Inverted cicrle button
  static circleButtonI(Widget icon,var action){
    return
      GestureDetector(
          onTap: () {
            action();
          },
          child: Center(
            child: Container(
              width: circleButtonSize,
              height: circleButtonSize,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: antiFlashWhite,
                      width: 1,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(circleButtonBorderRadius)
              ),
              child: Padding(
                padding: EdgeInsets.all(circleButtonPadding),
                child: icon,
              ),
            ),
          )
      );
  }

  static savedUrl(BuildContext context,String shortUrl,String orginalUrl){
    return
        Column(
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
                  GestureDetector(
                    onTap: (){
                      print("This will open: "+shortUrl);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shortUrl,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: Components.eerieBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                        Text(
                          orginalUrl,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            textStyle: TextStyle(
                              color: Components.eerieBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  circleButtonI(
                      IconCopyBlack,
                      (){
                        print("This will be copy: "+shortUrl);
                      }
                  ),
                ],
              ),
            ),
            SizedBox(height: separatorSize)
          ],
        ).animate().fade(duration: 300.ms);
  }

}