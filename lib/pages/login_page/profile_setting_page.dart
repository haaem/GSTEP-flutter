import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import '../../config/theme/text/title_text.dart';
import 'package:get/get.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({Key? key}) : super(key: key);

  @override
  State<ProfileSettingPage> createState() => ProfileSettingPageState();
}

class ProfileSettingPageState extends State<ProfileSettingPage> {
  final _formKey = GlobalKey<FormState>();
  String nickname = "";
  late var country;
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
                        nickname = value!;
                      },
                      onChanged: (value) {
                        nickname = value;
                        _tryValidation();
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
              SizedBox(height: 3,),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: CountryCodePicker(
                  initialSelection: '+82',
                  alignLeft: true,
                  onChanged: (value) {
                    country = value;
                    _hasCountry = true;
                    _tryValidation();
                  },
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
                onPressed: _isValid? () {
                  Get.toNamed('/main');
                } : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
