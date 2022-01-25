import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hash_generator/result.dart';
import 'package:crypto/crypto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {Result.routename: (ctx) => Result()},
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 5, 16, 46),
        appBarTheme:
            AppBarTheme(backgroundColor: Color.fromARGB(255, 2, 9, 35)),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> myHashes = [
    'SHA-1',
    'SHA-224',
    'SHA-256',
    'SHA-384',
    'SHA-512',
    'MD5'
  ];
  String myText = '';

  String calculateResult(String text, String dropdownValue) {
    var bytes = utf8.encode(text);
    switch (dropdownValue) {
      case 'SHA-1':
        {
          var digest = sha1.convert(bytes);
          return digest.toString();
        }
      case 'SHA-224':
        {
          var digest = sha224.convert(bytes);
          return digest.toString();
        }
      case 'SHA-256':
        {
          var digest = sha256.convert(bytes);
          return digest.toString();
        }
      case 'SHA-384':
        {
          var digest = sha384.convert(bytes);
          return digest.toString();
        }
      case 'SHA-512':
        {
          var digest = sha512.convert(bytes);
          return digest.toString();
        }
      case 'MD5':
        {
          var digest = md5.convert(bytes);
          return digest.toString();
        }
      default:
        {
          return 'Invalid Choice';
        }
    }
  }

  String dropdownValue = 'SHA-1';
  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    var appbar = AppBar(
      title: Text('Hash Generator'),
      backgroundColor: Color.fromARGB(255, 2, 9, 35),
      actions: [Icon(Icons.more_vert, size: 30)],
    );
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 16, 46),
      appBar: appbar,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: (mediaquery.size.height -
                  appbar.preferredSize.height -
                  mediaquery.padding.top) *
              0.95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/private-key.png')),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 20, 39, 95),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        elevation: 5,
                        value: dropdownValue,
                        iconEnabledColor: Colors.white,
                        iconSize: 24,
                        onChanged: (value) {
                          setState(() {
                            dropdownValue = value.toString();
                          });
                        },
                        items: myHashes
                            .map<DropdownMenuItem<String>>((String hash) {
                          return DropdownMenuItem(
                              child: Text(
                                hash,
                                style: TextStyle(
                                  color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                              value: hash);
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 20, 39, 95),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          myText = value;
                        });
                      },
                      keyboardType: TextInputType.multiline,
                      expands: true,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type here...',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 114, 125, 157))),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.green),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Result.routename,
                      arguments: calculateResult(myText, dropdownValue));
                },
                child: Text(
                  'GENERATE',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    onPrimary: Colors.white,
                    primary: Colors.blue.shade600,
                    minimumSize: Size(350, 50)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
