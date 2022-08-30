import 'dart:io';

import 'package:client_cookie/client_cookie.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final cookieManager = WebviewCookieManager();

  final String _url = 'https://youtube.com';
  final String instagram = "https://i.instagram.com/";
  final String instagramwithUser = "https://i.instagram.com/instatest5473";
  final String cookieValue = 'some-cookie-value';
  final String domain = 'youtube.com';
  final String cookieName = 'some_cookie_name';

  @override
  void initState() {
    super.initState();
    // cookieManager.clearCookies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
          actions: [
            IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () async {
                /* var gotCookies = await cookieManager.getCookies(instagram);
                print("YY:" + gotCookies.toString());
                for (var item in gotCookies) {
                  print("XX:" + item.name + ":" + " " + item.value);
                }*/
                var dio = Dio();
                dio.options.headers["x-ig-app-id"] = "936619743392459";
                dio.options.headers["cookie"] =
                    "base_domain=.instagram.com;ig_did=03D3A384-8877-49C6-8788-A1DEE8D8412D; ig_nrcb=1;mid=Ywy9wgABAAHLoj5tOfqf0_fnNJ-2;csrftoken=momr2gXWCZN0uzrgryZuF7PF0P54bPPN;dpr=2.625;sessionid=54596947867%3AsB9R2olszmpMbn%3A12%3AAYdK0OlbRDfQtoqxcWm5wkow8eDgi9-2CtvETakm6w;shbid=6758054545969478670541693315412:01f7c78f491b99c090adc646f4c53c597f2f84d82a417095dc4ecc6daa23600eb365de55;shbts=1661779412054545969478670541693315412:01f78d344f8e81610bcc3035ec5d008b2953adbe7121fa4030342384cc763636b933e6a0;rur=RVA054545969478670541693395184:01f7b91f403e9670818baa0e97af07bde84e7788bb72bae3ab9707aab36e2345536d0ca9";

                final response = await dio
                    .get('https://i.instagram.com/api/v1/feed/reels_tray/');
                print("Response XX:");
                print(response.data.toString());
                logger.i(response.data);
                final cookieManager = WebviewCookieManager();

                final gotCookiesz =
                    await cookieManager.getCookies('https://i.instagram.com/');
                for (var item in gotCookiesz) {
                  //   print(item);
                }
              },
            )
          ],
        ),
        body: WebView(
          initialUrl: instagram,
          userAgent:
              "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) async {
            await cookieManager.setCookies([
              Cookie(cookieName, cookieValue)
                ..domain = domain
                ..expires = DateTime.now().add(Duration(days: 10))
                ..httpOnly = false
            ]);
          },
          onPageFinished: (_) async {
            print("On Page finish:");

            final gotCookies = await cookieManager.getCookies(instagram);
            // Initializing a cookie
            final cookie1 =
                ClientCookie('Client', 'jaguar_resty', DateTime.now());

            // Cookie to header string
            print(cookie1.toReqHeader);

            // Encoding many cookies
            final cookie2 = ClientCookie('Who', 'teja', DateTime.now());
            print(ClientCookie.toSetCookie([cookie1, cookie2]));

            print(parseSetCookie(ClientCookie.toSetCookie([cookie1, cookie2])));
            print("YY:" + gotCookies.toString());
            for (var item in gotCookies) {
              print(item.name + ":" + " " + item.value);
            }
          },
        ),
      ),
    );
  }
}

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);
//fbm_124024574287414=base_domain=.instagram.com; ig_did=03D3A384-8877-49C6-8788-A1DEE8D8412D; ig_nrcb=1; mid=Yf6kzwAEAAEeYy2Ers0hAUOBJCAx; datr=H-mxYjdOUrZeaUryipYC7xb0; csrftoken=DMs3gDadDAVCmjeujPDbS2xsSeU3C7ke; ds_user_id=45650577815; dpr=2; sessionid=45650577815:F2YJrEVj8rh0AF:13:AYf3z-tgqYnELUbBQkxpYZbO6VKadUP_CdaC4Wk8tg; shbid="4623\05445650577815\0541693314344:01f71e6a69913bb2f8e1e1de6161266c249d0b73f881da470193172f43ec98e1f8edf8b1"; shbts="1661778344\05445650577815\0541693314344:01f7b5b9fae721085de1fcdea83fd384cf37b31f52fdb1571556d67bec45d257839daf1b"; fbsr_124024574287414=4DcwTe4AmLsUOhf33SLk8PIAtKDNkvUW78_h7hhfRps.eyJ1c2VyX2lkIjoiNzYxMjc0MDc3IiwiY29kZSI6IkFRRDllNHVKY2FVNmRPRTZ3ejdvNjFvNUVFb0U0N0JvTnBhNm5IVlhvaWZ2dzhsLW1MVjY3ek9zSXg5b0VQM1RKQ1VUX1EwLVE5ZUFqS0VudXE3c1lIZ1A1ZU5vSGZjNlRpc0ZhUjI2N3pQUUo5SkExeXVrM29DNkwwcG5Jem5oOFRNNDFtQnVqT2Q2YVVmWGpydl91czBONFp1UVczTDVOMG5rNTJ4WmZ0Z0FidllPSmxrUHRSYWpWbDlsb282VkRzaEZ3VDFldW9hSUNhVVZwS0l4Yk44ZUpxVEV5U09UTnM1Qm1wYXdwdlNONFlsSDRQTUFVeUg1TEpfaUh1N1YyYnBFc0hhSTJBSzNrSHVSNFJ1a1pOaTNUQmp2NU9LeXZpcERURkRZV0F4dFRJX09CTDJFZ3JJOFY5ckZvM3ItalpWRHVsRnlzdzA2YnJqZTJxdXg4eEFoME5aTlVNS1hqUE1UQTlqMjJadkRPUSIsIm9hdXRoX3Rva2VuIjoiRUFBQnd6TGl4bmpZQkFIS3psQlpDZkNaQk01V24xNFpCdXpRcklzSkFOcDBQUDBQdURkbnFlMkVFR2VRZE9tWGpzeTNWdzJkaWRzeEtJOWtMekMwb1pBbkpxcWZNZ09jNURhaFBDS25aQURseDY4Q21zWWhHRDR4ckRaQWxXS2FaQlpDWkM1dU9iQWtOWkNzMDhGWkNOUWdGNWNSbHhQajBkSVdmNTAxV0kwT1NCUzV3M2lBb0FjNHFLRlRqbUx0elpBSk16VkFaRCIsImFsZ29yaXRobSI6IkhNQUMtU0hBMjU2IiwiaXNzdWVkX2F0IjoxNjYxNzgwMDU4fQ; rur="ODN\05445650577815\0541693316084:01f7904a3e006e8fd14b0343110ca011189e9f98c0a0dd7183687a595eb988f81daa0dce"
