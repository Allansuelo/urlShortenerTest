import 'package:flutter/cupertino.dart';
import 'package:urlshortener/components.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urlshortener/services/api.dart';
import 'package:urlshortener/components/shortenedLink.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final formKey = GlobalKey<FormState>();
  final urlTextController = TextEditingController();
  List<ShortenedLink> shortLinks = [];

  void copyToClipboard(String url) async {
    final data = ClipboardData(text: url);
    await Clipboard.setData(data);
  }

  void shortenLink(String url) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return Dialog(
            backgroundColor: Components.antiFlashWhite,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator.adaptive(),
                  SizedBox(height: 8),
                  Text(
                    "Shortening Your Link",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.outfit(
                      textStyle: TextStyle(
                          color: Components.eerieBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0,
                          overflow: TextOverflow.clip
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );

    try{
      //Call request the API
      final response = (await createAlias(AliasToCreate(url))).body;
      print("Response json:"+ response);

      final Map<String, dynamic> data = json.decode(response);//Data fetched transformed to object

      final responseAlias = data["_links"]["alias"]; //getting the alias id for test
      print(responseAlias);

      setState(() { //Adding the object to Ui
        shortLinks.add(
            ShortenedLink(
                shortUrl: data["_links"]["short"],
                orginalUrl: url
            )
        );
      });

      copyToClipboard(data["_links"]["short"]);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Done! And url copied to clipboard"),
          backgroundColor: Colors.green,
        ));

      Navigator.of(context).pop();

    }catch(e){
      print("Error: "+ e.toString());
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Something went wrong, try again"),
            backgroundColor: Colors.red,
          ));
    }

  }
  
  @override
  Widget build(BuildContext context){

    return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 64, 20, 72),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Components.logo,
              ).animate().fade(duration: 100.ms),
              SizedBox(height: 16),
              Text(
                "Url Shortened History:",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  textStyle: TextStyle(
                    color: Components.eerieBlack,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    letterSpacing: .5,
                  ),
                ),
              ).animate().fade(duration: 300.ms),
              Container(
                  decoration: BoxDecoration(
                    color: Components.antiFlashWhite,
                    border: Border(
                      top: BorderSide(
                        color: Components.dimGray,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: Components.dimGray,
                        width: 1,
                      ),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 256,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(8),
                    itemCount: shortLinks.length,
                    itemBuilder: (context, index) => shortLinks[index],
                  ),
              ).animate().fade(duration: 500.ms),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width - 96,
                      height: 72,
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          controller: urlTextController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Ionicons.link),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(32))
                              ),
                              hintText: 'Enter a url to short it...',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16
                              )
                          ),
                          validator: (value){ //Checking if the URL is OK
                            if (value!.isEmpty){
                              return "Please enter a url";
                            }
                            if (!value.startsWith('https://') && !value.startsWith('www.')){
                              return "Please enter a valid url";
                            }
                            final urlRegex = RegExp(r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?');

                            if (!urlRegex.hasMatch(value)) {
                              return "Please enter a valid url";
                            }
                            return null;
                          },
                        ),
                      )
                  ),
                  SizedBox(width: 8),
                  Components.circleButton(
                      Components.IconSendWhite,
                      () async => {
                        if (!formKey.currentState!.validate()){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Please enter a valid URL")
                            )
                          )
                        }else
                        shortenLink(urlTextController.text)
                      }
                  ),
                ],
              ).animate().fade(duration: 800.ms),
            ],
          )
      );
  }
}