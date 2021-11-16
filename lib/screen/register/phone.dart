// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:qstar/constant.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:qstar/screen/register/verification.dart';

class Phone extends StatelessWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'qstar',
      home: SetPhone(),
    );
  }
}

class SetPhone extends StatefulWidget {
  const SetPhone({Key? key}) : super(key: key);

  @override
  _SetPhoneState createState() => _SetPhoneState();
}

class _SetPhoneState extends State<SetPhone> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'ET';
  PhoneNumber number = PhoneNumber(isoCode: 'ET');
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
    );
    return Form(
      key: formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Center Column contents vertically,
          children: <Widget>[
            const Text(
              "What's your mobile phone",
              style: TextStyle(
                // we use the [TextStyle] widget to customize text
                color: mPrimaryColor, // set the color
                fontSize: 25.0,
                fontFamily: 'font1', // and the font size
              ),
            ),
            const SizedBox(height: 20),
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
                child: InternationalPhoneNumberInput(
                  inputDecoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                              color: Colors.white, width: 3.0))),
                  onInputChanged: (PhoneNumber number) {
                    // ignore: avoid_print
                    print(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    // ignore: avoid_print
                    print(value);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  initialValue: number,
                  textFieldController: controller,
                  formatInput: false,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  onSaved: (PhoneNumber number) {
                    // ignore: avoid_print
                    print('On Saved: $number');
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 45,
                vertical: 16,
              ),
              alignment: Alignment.center,
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          text: "We'll send you an SMS  verification code"),
                    ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
                color: mPrimaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return const Verification();
                      },
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: const Text(
                    'Next',
                    style: textStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
