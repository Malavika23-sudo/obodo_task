import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserListScreen extends StatefulWidget {
  static String routeName = "/userListScreen";

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  // final _firebasecore = FirebaseFirestore.instance;
  // CollectionReference _list = FirebaseFirestore.instance.collection('user');
  // Stream? _stremItems;
  //
  // @override
  // void initState() {
  //   _stremItems = _list.snapshots();
  // }

  // fetch() async {
  //   // final firebaseUser = await FirebaseAuth.instance.currentUser();
  //   await FirebaseFirestore.instance
  //       .collection('user')
  //       .get()
  //       .then((ds) {
  //     myEmail = ds.
  //     print(myEmail);
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // Future getData() async{
  //   var data= await FirebaseFirestore.instance.collection('user').get();
  //   print("DATA====================>>>>>>>>>> $data");
  // }
  final Stream<QuerySnapshot> users= FirebaseFirestore.instance.collection('user').snapshots();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(
                  // top: ScreenUtil().setWidth(5),
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(16),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'User List',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(32),
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16),
                        ),
                        child: SizedBox(
                          height: ScreenUtil().setWidth(40),
                          width: double.infinity,
                          child: TextField(
                            // controller: cntrl,
                            onTap: () {
                              // setState(() {
                              //
                              // });
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                  // top: ScreenUtil().setWidth(2.5),
                                  left: ScreenUtil().setWidth(16)),
                              hintText: 'Search by location',
                              hintStyle:
                                  Theme.of(context).textTheme.headline2!.merge(
                                        TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11,
                                        ),
                                      ),
                            ),
                          ),
                        ),
                      ),
                StreamBuilder<QuerySnapshot>(
                    stream:users,builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                      // if(snapshot.hasError){
                      //   return Text('Something went wrong');
                      // }
                      // if(snapshot.connectionState==ConnectionState.waiting){
                      //   return Text('Loading.......');
                      // }
                      // getData();
                        final data =  snapshot.requireData;
                        print('DATA SNAP=================================> ${snapshot.data}');
                        return ListView.builder(
                            itemCount: data.size,
                            itemBuilder: (context,index){
                              return Column(
                                children: [
                                  Text(data.toString(),style: TextStyle(color: Colors.black,fontSize: 30),),
                                  Text('name ${data.docs[index]['name']}',style: TextStyle(color: Colors.black),),
                                ],
                              );
                            });



                },)
                      // StreamBuilder<QuerySnapshot>(
                      //   stream: _firebasecore.collection('user').snapshots(),
                      //   builder:
                      //       (BuildContext context, AsyncSnapshot snapshot) {
                      //     final userDetails = snapshot.data.documents.reversed;
                      //     List<userDetail> messageBubbles = [];
                      //     for (var user in userDetails) {
                      //       final name = user.data['name'];
                      //       final phone = user.data['phone'];
                      //       final sex = user.data['sex'];
                      //       final location = user.data['location'];
                      //       final messageBubble = userDetail(
                      //         name: name,
                      //         phone: phone,
                      //         location: location,
                      //         sex: sex,
                      //       );
                      //       messageBubbles.add(messageBubble);
                      //     }
                      //
                      //     return Expanded(
                      //       child: ListView(
                      //         reverse: true,
                      //         padding: EdgeInsets.symmetric(
                      //             horizontal: 10.0, vertical: 20.0),
                      //         children: messageBubbles,
                      //       ),
                      //     );
                      //   },
                      // )
                      // FutureBuilder(
                      //   future: fetch(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.connectionState != ConnectionState.done)
                      //       return Text("Loading data...Please wait");
                      //     return Text("Email : $myEmail");
                      //   },
                      // ),
                      // ListView.builder(itemBuilder: (context, index) {
                      //   return Container(
                      //     child: Column(children: [
                      //
                      //     ],),
                      //   );
                      // })
                    ]))));
  }
}

// class userDetail extends StatelessWidget {
//   String? name;
//   String? phone;
//   String? sex;
//   String? location;
//
//   userDetail({this.name, this.phone, this.sex, this.location});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(name.toString(),style: TextStyle(color: Colors.black),),
//       ],
//     );
//   }
// }
