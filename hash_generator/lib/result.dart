import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Result extends StatelessWidget {
  static const routename = '/result';

  @override
  Widget build(BuildContext context) {
    var routeArgs = ModalRoute.of(context)!.settings.arguments as String;
    String result_string = routeArgs;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Center(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 20, 39, 95),
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Text(
                        result_string,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: result_string));
                    },
                    child: Text(
                      'COPY',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        onPrimary: Colors.white,
                        primary: Colors.blue.shade600,
                        minimumSize: Size(400, 50)),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
