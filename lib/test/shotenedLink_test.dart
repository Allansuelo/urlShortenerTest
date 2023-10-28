import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';

import 'package:urlshortener/components/shortenedLink.dart';

void main(){
  //Pre-test
  setUp(() => null);
  setUpAll(() => null);
  //PostTest
  tearDown(() => null);
  tearDownAll(() => null);



  group(
    "ShortenedLink Components",
    () {
      String shortTest = "https://url-shortener-server.onrender.com/api/alias/1730591014";
      String originalTest = "https://pub.dev/";
      final ShortenedLink sl = ShortenedLink(shortUrl: shortTest,orginalUrl: originalTest);

      test(
        'Given ShortenedLink component When the copy button is tapped copy data need to be equal to component shortUrl',
        () async{
          final copyData = sl.copyToClipboard(sl.shortUrl) as String;
          expect(copyData, sl.shortUrl);
        }
      );
    }
  );

}