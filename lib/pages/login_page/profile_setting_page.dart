import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/core/params/user.dart';
import '../../config/theme/text/title_text.dart';
import 'package:get/get.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingPage> createState() => ProfileSettingPageState();
}

class ProfileSettingPageState extends State<ProfileSettingPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;
  bool _hasCountry = false;
  static bool profileSetting = false;

  void _tryValidation() {
    _isValid = _formKey.currentState!.validate() && _hasCountry;
    if (_isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                  child: Image.asset(
                'assets/images/logo_imagename.png',
                width: 240,
              )),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  BodyText(
                    text: 'Nickname',
                    size: 12,
                    weight: FontWeight.w400,
                    color: primaryBlack,
                  ),
                ],
              ),
              SizedBox(
                height: 3,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "닉네임을 입력해주세요.";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userName = value!;
                      },
                      onChanged: (value) {
                        userName = value;
                        _tryValidation();
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'ex) Jane/John Doe',
                        hintStyle: TextStyle(color: Color(0xff8F959E))
                      ),
                    )
                ),
              ),
              SizedBox(height: 55,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  BodyText(
                    text: 'Country',
                    size: 12,
                    weight: FontWeight.w400,
                    color: primaryBlack,
                  ),
                ],
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    onSelect: (Country value) {
                      print('Select country: ${value.name}');
                      userCountry = value.name;
                      _hasCountry = true;
                      _tryValidation();
                      setState(() {});
                    },
                    countryListTheme: CountryListThemeData(
                      flagSize: 25,
                      backgroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                      bottomSheetHeight: 500, // Optional. Country list modal height
                      //Optional. Sets the border radius for the bottomsheet.
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      //Optional. Styles the search field.
                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width-80,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(
                      color: primaryGrey,
                    ))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyText(text: _hasCountry ? '${userCountry}' : 'Choose your country.',),
                      Icon(Icons.keyboard_arrow_down_rounded, color: primaryGrey,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 60,),
              ElevatedButton(
                child: Container(
                  child: Center(child: TitleText(text: 'Next', weight: FontWeight.w700, size: 17, color: Colors.white,)),
                  width: 260,
                  height: 40,
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  backgroundColor: _isValid ? primaryLightGreen2 : primaryGrey
                ),
                onPressed: _isValid? () async {
                  upload();
                  Get.toNamed('/color_setting');
                } : null,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future upload() async {
    final url = Uri.parse(
      'http://34.64.137.128:8080/user/',
    );

    final response = await http.post(url, body: {
      "Email": userEmail,
      "Nickname": userName,
      "Country": userCountry
    });
    var userData = jsonDecode(response.body);
    userId = userData['ID'];
    userLevel = userData['Step'];

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Response headers: ${response.headers}');

    // final res2 = await http.get(
    //   Uri.parse(
    //     'http://34.64.137.128:8080/user/4',
    //   ),
    // );
    //
    // print('Response status: ${res2.statusCode}');
    // print('Response body: ${userId}');
  }
}
