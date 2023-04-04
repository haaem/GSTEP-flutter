import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twentyone_days/core/params/my_marker.dart';
import '../../config/theme/color.dart';
import '../../config/theme/text/body_text.dart';

class MessageAddPopup extends StatefulWidget {
  const MessageAddPopup({Key? key}) : super(key: key);

  @override
  State<MessageAddPopup> createState() => _MessageAddPopupState();
}

class _MessageAddPopupState extends State<MessageAddPopup> {
  final _formKey1 = GlobalKey<FormState>();
  bool _isValid = false;

  void _tryValidation() {
    _isValid = _formKey1.currentState!.validate();
    if (_isValid) {
      _formKey1.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        content: Builder(builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          BorderRadiusGeometry radius = BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          );

          return SingleChildScrollView(
            child: Container(
              width: width - 70,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: backgroundColor, borderRadius: radius),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 55,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/images/tree_imsi.png',
                            height: 240,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: BodyText(
                            text: '2023.02.10 (금)',
                            size: 18,
                            color: Colors.white,
                            weight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 30,),
                      BodyText(text: 'Write the message to be displayed\nwith the tree.', size: 14, weight: FontWeight.w600, color: Color(0xff676767),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: 30,),
                      Form(
                        key: _formKey1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: MediaQuery.of(context).size.width-130,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value.length>80) {
                                  return "Maximum length is 80 characters";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                markerMessage = value!;
                              },
                              onChanged: (value) {
                                markerMessage = value;
                                _tryValidation();
                              },
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffF5F6FA)
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffF5F6FA)
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))
                                ),
                                  filled: true,
                                  fillColor: Color(0xffF5F6FA),
                                  hintText: 'Maximum length is 80 characters',
                                  hintStyle: TextStyle(color: Color(0xff8F959E))
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30,)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(child: BodyText(text: 'Yes', color: Colors.white, size: 16, weight: FontWeight.w700,)),
                        ),
                        onTap: () {
                          if (_isValid) {
                            Get.toNamed('/main');
                          }
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: 120,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xff686868),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(child: BodyText(text: 'No', color: Colors.white, size: 16, weight: FontWeight.w700,)),
                        ),
                        onTap: () {
                          Get.back();
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 30,)
                ],
              ),
            ),
          );
        }));
  }
}
