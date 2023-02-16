import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  final String? id;
  final String? token;
  const Dashboard({super.key, @required this.id, @required this.token});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _formKey = GlobalKey<FormState>();

  var amount = 0;
  var bal = 0;

  Future getBalance(id) async {
    var res = await http.get(
        "http://192.168.43.152:6500/api/dashboard/balance/$id",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    var data = jsonDecode(res.body);
    setState(() {
      bal = data["balance"];
    });
  }

  Future deposit(id) async {
    var res =
        await http.put("http://192.168.43.152:6500/api/dashboard/deposit/$id",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{'amount': amount.toString()}));

    if (res.statusCode == 200) {
      Fluttertoast.showToast(
          msg: (res.body),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: res.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future withdraw(id) async {
    var res =
        await http.put("http://192.168.43.152:6500/api/dashboard/withdraw/$id",
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{'amount': amount.toString()}));

    if (res.statusCode == 200) {
      Fluttertoast.showToast(
          msg: (res.body),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: jsonDecode(res.body),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                child: SvgPicture.asset(
                  'images/top.svg',
                  width: 400,
                  height: 250,
                )),
            Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                    ),
                    InkWell(
                      onTap: () => {getBalance(widget.id)},
                      child: Text(
                        "Bal: $bal",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.blue),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller:
                            TextEditingController(text: amount.toString()),
                        onChanged: (value) {
                          amount = value.isEmpty ? 0 : int.parse(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Amount is required";
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "10000",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          height: 50,
                          width: 250,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () =>
                                {withdraw(widget.id), getBalance(widget.id)},
                            child: Text("Withdraw",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white)),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          height: 50,
                          width: 350,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueGrey,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            onPressed: () =>
                                {deposit(widget.id), getBalance(widget.id)},
                            child: Text("Deposit",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white)),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
