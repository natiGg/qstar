// ignore_for_file: unnecessary_null_comparison
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:qstar/screen/register/suggested.dart';
import 'package:qstar/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}

class Hobbieselector extends StatefulWidget {
  final String fname;
  final String lname;
  final String date;
  final String email;
  final String uname;
  final String password;
  const Hobbieselector(
      {Key? key,
      required this.fname,
      required this.lname,
      required this.date,
      required this.email,
      required this.uname,
      required this.password})
      : super(key: key);
  @override
  _HobbieselectorState createState() => _HobbieselectorState();
}

class _HobbieselectorState extends State<Hobbieselector> {
  static final List<Animal> _animals = [
    Animal(id: 1, name: "Book clubs"),
    Animal(id: 2, name: "Running clubs"),
    Animal(id: 3, name: "Volunteering"),
    Animal(id: 4, name: "Adult sports leagues"),
    Animal(id: 5, name: "Improv classes"),
    Animal(id: 6, name: "Bowling"),
    Animal(id: 7, name: "Golfing"),
    Animal(id: 8, name: "Board games"),
    Animal(id: 9, name: "Content creation"),
    Animal(id: 10, name: "Yoga"),
    Animal(id: 11, name: "Cycling"),
    Animal(id: 12, name: "Video Games"),
    Animal(id: 13, name: "Fitness classes"),
    Animal(id: 14, name: "Group travel"),
    Animal(id: 15, name: "Watch TV"),
    Animal(id: 16, name: "Reading"),
    Animal(id: 17, name: "Fitness"),
    Animal(id: 18, name: "Journaling"),
    Animal(id: 19, name: "Gambling"),
    Animal(id: 20, name: "Yoga"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  //List<Animal> _selectedAnimals = [];
  List<Animal> _selectedItems2 = [];
  List<String> _tobeSent = [];
  List<Animal> _selectedItems3 = [];

  String Preligion = "test";
  final _multiSelectKey = GlobalKey<FormState>();
  var hobbiesfield;

  //List<Animal> _selectedAnimals4 = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Form(
            key: _multiSelectKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                //################################################################################################
                // Rounded blue MultiSelectDialogField
                //################################################################################################

                //################################################################################################
                // This MultiSelectBottomSheetField has no decoration, but is instead wrapped in a Container that has
                // decoration applied. This allows the ChipDisplay to render inside the same Container.
                //################################################################################################
                const Text(
                  "Help us to understand you more",
                  style: TextStyle(
                    // we use the [TextStyle] widget to customize text
                    color: mPrimaryColor, // set the color
                    fontSize: 25.0,
                    fontFamily: 'font1', // and the font size
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "What do you need in your life ",
                  style: TextStyle(
                    // we use the [TextStyle] widget to customize text
                    color: mPrimaryColor, // set the color
                    fontSize: 19.0,
                    fontFamily: 'font1', // and the font size
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  elevation: 20.0,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  child: TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        hintText: 'eg.Money,Love...',
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0))),
                    validator: (hobbie) {
                      if (hobbie!.isEmpty) {
                        return "Please put your needs";
                      }
                      hobbiesfield = hobbie.toString();
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "What's your Hobbies",
                  style: TextStyle(
                    // we use the [TextStyle] widget to customize text
                    color: mPrimaryColor, // set the color
                    fontSize: 19.0,
                    fontFamily: 'font1', // and the font size
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    border: Border.all(
                      color: mPrimaryColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      MultiSelectBottomSheetField<Animal>(
                        initialChildSize: 0.7,
                        maxChildSize: 0.95,
                        listType: MultiSelectListType.CHIP,
                        checkColor: Colors.pink,
                        selectedColor: mPrimaryColor,
                        selectedItemsTextStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        unselectedColor: mPrimaryColor.withOpacity(.08),
                        buttonIcon: Icon(
                          Icons.add,
                          color: Colors.pinkAccent,
                        ),
                        searchHintStyle: TextStyle(
                          fontSize: 20,
                        ),
                        searchable: true,
                        buttonText: Text(
                          '$Preligion', //"????",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                        title: Text(
                          "Hobbies",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.pink,
                          ),
                        ),
                        items: _items,
                        onConfirm: (values) {
                          setState(() {
                            _selectedItems2 = values;
                          });
                          print('selected : ${_selectedItems2}');
                          _selectedItems2.forEach((item) =>
                              _tobeSent.add("${item.name.toString()}"));

                          /*senduserdata(
                      'partnerreligion', '${_selectedItems2.toString()}');*/
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          onTap: (value) {
                            setState(() {
                              _selectedItems2.remove(value);
                              _tobeSent.remove(value.toString());
                            });

                            print('removed: ${_selectedItems2.toString()}');
                            _selectedItems2.forEach((item) =>
                                _tobeSent.add("${item.name.toString()}"));
                          },
                        ),
                      ),
                      _selectedItems2 == null || _selectedItems2.isEmpty
                          ? MultiSelectChipDisplay(
                              onTap: (item) {
                                setState(() {
                                  _selectedItems3.remove(item);
                                  print(
                                      'removed below: ${_selectedItems3.toString()}');
                                });
                                _multiSelectKey.currentState!.validate();
                              },
                            )
                          : MultiSelectChipDisplay(),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                    color: mPrimaryColor,
                    onPressed: () {
                      if (_multiSelectKey.currentState!.validate()) {
                        _register();
                      }

                      // Navigator.push(
                      //   context,
                      //   PageRouteBuilder(
                      //     pageBuilder: (context, animation1, animation2) {
                      //       return Suggested();
                      //     },
                      //   ),
                      // );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: _isLoading == false
                          ? Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : Container(
                              height: 20,
                              width: 20,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),
                )
                //################################################################################################
                // MultiSelectBottomSheetField with validators
                //################################################################################################

                //################################################################################################
                // MultiSelectChipField
                //################################################################################################

                //################################################################################################
                // MultiSelectDialogField with initial values
                //################################################################################################
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'name': widget.fname,
      'email': widget.email,
      'username': widget.uname,
      'password': widget.password,
      'password_confirmation': widget.password,
      'life_needs': hobbiesfield,
      'hobbies': _tobeSent.join(",").toString()
    };

    var res = await Network().authData(data, 'register/email');
    var body = json.decode(res.body);
    print(body);
    print(res.statusCode);
    print(_tobeSent.join(",").toString());
    print(body["token"].toString());

    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString("token", body["token"].toString());
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => Suggested()),
      );
    } else if (res.statusCode == 422) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(body["errors"].toString()),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                setState(() {
                  _isLoading = false;
                });
              },
              child: Text('ok'),
            ),
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }
}
