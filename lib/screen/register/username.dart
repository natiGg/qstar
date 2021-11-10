// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';
import 'dart:convert';
import 'package:qstar/screen/register/email.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qstar/network_utils/api.dart';


class Username extends StatefulWidget {
  final String fname;
  final String lname;
  final String date;

  const Username(
      {Key? key, required this.fname, required this.lname, required this.date})
      : super(key: key);
  @override
  State<Username> createState() => _UsernameState();
}
class CityData {
 static final List<String> _kOptions = <String>[
      'aardvark',
      'bobcat',
      'chameleon',
    ];


  static List<String> getSuggestions(String query) =>
      List.of(_kOptions).where((suggested) {
        final cityLower = suggested.toLowerCase();
        final queryLower = query.toLowerCase();

        return cityLower.contains(queryLower);
      }).toList();
}

class _UsernameState extends State<Username> {
  bool _isLoading=false;   
  bool _isSuggested=false;
   var username;
   var suggested;
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );

    final _formKey = GlobalKey<FormState>();

    List<String> _kOptions = <String>[
      'aardvark',
      'bobcat',
      'chameleon',
    ];
      String? selectedCity;

      final controllerCity = TextEditingController();
      var uname;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Center Column contents vertically,
          children: <Widget>[
            Text(
              "Your username",
              style: TextStyle(
                // we use the [TextStyle] widget to customize text
                color: mPrimaryColor, // set the color
                fontSize: 25.0,
                fontFamily: 'font1', // and the font size
              ),
            ),
            SizedBox(height: 20),
            _isSuggested==false?Text(
              "Your username is how friends find you on Q star",
              style: TextStyle(
                // we use the [TextStyle] widget to customize text
                color: mPrimaryColor, // set the color
                fontSize: 10.0, // and the font size
              ),
            ):Text(
              "try $suggested",
              style: TextStyle(
                // we use the [TextStyle] widget to customize text
                color: mPrimaryColor, // set the color
                fontSize: 15.0, // and the font size
              ),
            ),
          
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 30,
              ),
              child: Material(
                elevation: 20.0,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                child: InputDecorator(
                  decoration: InputDecoration(
                    prefixText: "@",
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            BorderSide(color: Colors.white, width: 3.0)),
                    hintText: "Search..",
                  ),
                  child: TypeAheadFormField<String?>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controllerCity,
                    
                      ),
                      suggestionsCallback: CityData.getSuggestions,
                      itemBuilder: (context, String? suggestion) => ListTile(
                        title: Text(suggestion!),
                      ),
                      onSuggestionSelected: (String? suggestion) =>
                controllerCity.text = suggestion!,
                      validator: (value) =>
                value != null && value.isEmpty ? 'Please put username' : null,
                      onSaved: (value) => selectedCity = value,
                    )
                ),
              ),
            ),
          
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 45,
                vertical: 16,
              ),
              alignment: Alignment.center,
            ),

            SizedBox(
              height: 30,
            ),
            // Text(_selectedAnimal != null
            //     ? _selectedAnimal
            //     : 'Type something (a, b, c, etc)'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
                color: mPrimaryColor,
                onPressed: () {
                  if (_formKey.currentState!.validate()) 
                  {
                    username=controllerCity.text;
                    _checkUname();
                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     pageBuilder: (context, animation1, animation2) {
                    //       return Email(
                    //           fname: widget.fname,
                    //           lname: widget.lname,
                    //           date: widget.date,
                    //           uname: controllerCity.text);
                    //     },
                    //   ),
                    // );
                  }
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child:_isLoading==false? Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ):
                  Text(
                      'Checking...',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  void _checkUname() async
   {
    setState(() {
      _isLoading = true;
    });
    var data = {'username':username};
    var res = await Network().authData(data, "validateUsername");
    var body = json.decode(res.body);
    print(body.toString());
print(res.statusCode);
    if (res.statusCode == 200) {
      Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) {
                          return Email(
                              fname: widget.fname,
                              lname: widget.lname,
                              date: widget.date,
                              uname: username);
                        },
                      ),
                    );
    } else if (res.statusCode == 422) 
    {
      Map<String, dynamic> map = body["errors"];
      List<dynamic> data = map["username"];
      print(data[0]["message"].toString());
       print(data[0]["suggestion"].toString());

      // var errors=json.decode(body["errors"]);
      // print(body["errors"].toString());
      // print(json.decode(errors["username"]).toString());
      showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('info'),
              content: new Text(data[0]["message"].toString()),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    setState(() { 
                      _isLoading=false;
                      _isSuggested=true;
                      suggested=data[0]["suggestion"].toString();
                    });
                  } ,
                  child: new Text('ok'),
                ),
              ],
            ),
          ) ??
          false;
    }
  }
}
