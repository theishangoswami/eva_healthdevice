import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_fall_detection_care_taker/components/category_card.dart';
import 'package:eva_fall_detection_care_taker/components/doctor_card.dart';
import 'package:eva_fall_detection_care_taker/constant.dart';
import 'package:eva_fall_detection_care_taker/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseReference = FirebaseDatabase.instance.reference();

  void readData() {
    databaseReference.once().then((DataSnapshot snapshot) {
      print("REALTIMEDATABSE");
      print('Data : ${snapshot.value}');
    });
  }

  Future<dynamic> getElderly() async {
    QuerySnapshot qn =
        await Firestore.instance.collection("elderly").getDocuments();
    print(qn);
    return qn.documents;
  }

  navigatetoDetail(DocumentSnapshot doc) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(doc: doc),
        ));
  }

  @override
  void initState() {
    super.initState();

    getElderly();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          140,
        ), // here the desired height
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40.0, bottom: 0, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Eva | Care Taker',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: kTitleTextColor,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                child: InkWell(
                  onTap: () {
                    launch(
                        "https://console.firebase.google.com/u/1/project/falldetection-7f362/firestore/data");
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SizedBox(
                      height: 10,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10),
                        child: Text(
                          "Add an elderly profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(
                color: Colors.grey[500],
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _launchCaller();
        },
        label: Text(
          'Call Emergency',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: Icon(Icons.call),
        backgroundColor: Color(0xFFFF0000),
      ),
      backgroundColor: kBackgroundColor,
      body: FutureBuilder(
          future: getElderly(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 15.0, left: 10, right: 10),
                      child: InkWell(
                        onTap: () {
                          navigatetoDetail(snapshot.data[index]);
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color:
                                HexColor(snapshot.data[index].data['bgcolor'])
                                    .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: HexColor(
                                    snapshot.data[index].data['bgcolor']),
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                snapshot.data[index].data['name'],
                                style: TextStyle(
                                  color: kTitleTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data[index].data['deviceid'],
                                style: TextStyle(
                                  color: kTitleTextColor.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Container(
                  child: Text("Error 404! Check back again shortly."),
                ),
              );
            }
          }),
    );
  }

  buildDoctorList() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: <Widget>[
          DoctorCard(
            'Dr. Stella Kane',
            'Heart Surgeon - Flower Hospitals',
            'assets/images/doctor1.png',
            kOrangeColor,
            kBlueColor,
          ),
          SizedBox(
            height: 20,
          ),
          DoctorCard(
            'Dr. Joseph Cart',
            'Dental Surgeon - Flower Hospitals',
            'assets/images/doctor2.png',
            kBlueColor,
            kYellowColor,
          ),
          SizedBox(
            height: 20,
          ),
          DoctorCard(
            'Dr. Stephanie',
            'Eye Specialist - Flower Hospitals',
            'assets/images/doctor3.png',
            kYellowColor,
            kOrangeColor,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _launchCaller() async {
    const url = "tel:9999999999";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
