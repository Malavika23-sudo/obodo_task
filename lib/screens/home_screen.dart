import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:obodo_app/screens/user_list_screen.dart';
import 'package:obodo_app/user_model.dart';

enum Sex { female, male }

class HomeScreen extends StatefulWidget {
  static String routeName = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> countries = [];
  final _firebasecore = FirebaseFirestore.instance;
  final nameEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  String? name;
  String? phone;
  String? sex = 'Sex.female';
  String? location;
  Sex? _character = Sex.female;
  final _formKey = GlobalKey<FormState>();
  Position? position;
  UserModel userModels=UserModel();
  
  void getLocation() async {
    // print('POSITION=====================>');
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print('POSITION=====================>');
    // print(position);
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print("reached start of try block");
      if (!serviceEnabled) {
        print("reached start of try block");
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      print("cont..  try block");
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      var pos = await Geolocator.getCurrentPosition(
          // forceAndroidLocationManager: true,
          desiredAccuracy: LocationAccuracy.low);
      setState(() {
        position = pos;
      });
      print("Got position");
      print('current Position ${position}.');
    } catch (e) {
      print(e);
    }
  }

  //
  // @override
  // void initState() {
  //   // super.initState();
  //   this.countries.add({"val": "1", "label": "Simple"});
  //   this.countries.add({"val": "2", "label": "Variable"});
  // }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil().setWidth(32),
            right: ScreenUtil().setWidth(16),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(16),
                    ),
                    child: Text(
                      'Add User',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(32),
                      left: ScreenUtil().setWidth(16),
                    ),
                    child: Text(
                      'Name',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(5),
                        left: ScreenUtil().setWidth(16)),
                    child: TextBox(
                      textEditingController: nameEditingController,
                      onValidate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the user Name';
                        }
                        return null;
                      },
                      onChange: (value) {
                        setState(() {
                          name = value;
                          print(
                              "name==========================================>>>");
                          print(name);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(32),
                        left: ScreenUtil().setWidth(16)),
                    child: Text(
                      'Phone',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(5),
                        left: ScreenUtil().setWidth(16)),
                    child: TextBox(
                      textEditingController: phoneEditingController,
                      onValidate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                      textType: TextInputType.number,
                      onChange: (value) {
                        setState(() {
                          phone = value;
                          print(
                              "phone==========================================>>>");
                          print(phone);
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(32),
                      left: ScreenUtil().setWidth(16),
                    ),
                    child: Text(
                      'Sex',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtil().setWidth(5),
                    ),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Transform.scale(
                          scale: .7,
                          child: Radio<Sex>(
                            value: Sex.female,
                            groupValue: _character,
                            activeColor: Colors.black,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.black.withOpacity(.32);
                              }
                              return Colors.black;
                            }),
                            onChanged: (Sex? value) {
                              setState(() {
                                _character = value;
                                sex = _character.toString();
                                print(sex);
                              });
                            },
                          ),
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        Transform.scale(
                          scale: .7,
                          child: Radio<Sex>(
                            value: Sex.male,
                            groupValue: _character,
                            activeColor: Colors.black,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                (states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.black.withOpacity(.32);
                              }
                              return Colors.black;
                            }),
                            onChanged: (Sex? value) {
                              setState(() {
                                _character = value;
                                sex = _character.toString();
                                print(sex);
                              });
                            },
                          ),
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(32),
                        left: ScreenUtil().setWidth(16)),
                    child: Text(
                      'Location',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(5),
                        left: ScreenUtil().setWidth(16)),
                    child: TextBox(
                      textEditingController: locationEditingController,
                      onValidate: (value) {
                        if (position == null) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Location';
                          }
                        }

                        return null;
                      },
                      onChange: (value) {
                        setState(() {
                          location = value;
                          print(
                              "location==========================================>>>");
                          print(location);
                        });
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(32),
                        ),
                        child: Text(
                          'Or',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setWidth(5),
                            left: ScreenUtil().setWidth(16)),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                getLocation();
                              });
                            },
                            child: Text(
                              'Get Current Location',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .merge(TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          position == null
                              ? 'No position detected'
                              : position.toString(),
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: ScreenUtil().setWidth(32)),
                  //   child: Text(
                  //     'State',
                  //     style: Theme.of(context).textTheme.headline2,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     top: ScreenUtil().setWidth(5),
                  //   ),
                  //   child: TextBox(),
                  // ),

                  ///

                  // FormHelper.dropDownWidget(
                  //   context,
                  //   "Select Country",
                  //   this.countryId,
                  //   this.countries,
                  //   (val) {
                  //     this.countryId = val;
                  //     print(val);
                  //   },
                  //   (onValidate) {
                  //     if (onValidate == null) {
                  //       return 'Please select the country';
                  //     }
                  //     return null;
                  //   },
                  //   optionValue: 'val',
                  //   optionLabel: 'label',
                  // ),

                  ///

                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setWidth(32),
                        left: ScreenUtil().setWidth(16)),
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            _firebasecore.collection('user').add({
                              'name': name,
                              'phone': phone,
                              'sex': sex,
                              'location': location==null?position:location,
                              'timestamp': FieldValue.serverTimestamp()
                            });
                            userModels.userModel.add(UserModel(name: name));
                            if (_formKey.currentState!.validate() ||
                                (position != null &&
                                    name != null &&
                                    phone != null)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserListScreen()),
                              );
                            }
                            nameEditingController.clear();
                            phoneEditingController.clear();
                            locationEditingController.clear();
                          },
                          child: Text(
                            'Add',
                            style: Theme.of(context).textTheme.headline6!.merge(
                                TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter-SemiBold')),
                          ),
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(343, 48)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}

class TextBox extends StatelessWidget {
  double left;
  bool obscure;
  Widget? toggleHide;
  void Function(String? val)? onChange;
  TextInputType? textType = TextInputType.multiline;
  final String? Function(String? value)? onValidate;
  TextEditingController? textEditingController;

  TextBox(
      {this.left = 16,
      this.obscure = false,
      this.toggleHide,
      this.textType,
      this.onChange,
      this.onValidate,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: ScreenUtil().setWidth(48),
      child: TextFormField(
        controller: textEditingController,
        validator: onValidate,
        onChanged: onChange,
        obscureText: obscure,
        keyboardType: textType,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: toggleHide,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1)),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffC9C9C9), width: 1),
          ),
          fillColor: Color(0xffF8F8F8),
          filled: true,
          contentPadding: EdgeInsets.only(
              top: ScreenUtil().setWidth(38), left: ScreenUtil().setWidth(15)),
        ),
      ),
    );
  }
}
