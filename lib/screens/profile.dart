import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class ProfilePage extends StatefulWidget {
  final DocumentSnapshot doc;

  ProfilePage({this.doc});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextStyle _style() {
    return TextStyle(fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            140,
          ),
          child: Container(
            padding: EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Patient Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "Blood Grp",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          widget.doc.data["bloodgroup"],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Age",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          widget.doc.data["age"],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Sex",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          widget.doc.data["sex"],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 26),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Text("Name"),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.doc.data["name"],
                  style: _style(),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Health Insurance"),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.doc.data["healthins"],
                  style: _style(),
                ),
                SizedBox(
                  height: 16,
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 8,
                ),
                Text("Birth Mark"),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.doc.data["birthmark"],
                  style: _style(),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Diabetes"),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.doc.data["diab"],
                  style: _style(),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Physically Challenged"),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.doc.data["phys"],
                  style: _style(),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 13,
                ),
                Center(
                  child: new Text(
                    "Current Medications",
                    style: _style(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Medicine: ${widget.doc.data["med"]}",
                  style: _style(),
                ),
                SizedBox(
                  height: 8,
                ),
                Text("Dose : ${widget.doc.data["dose"]}"),
                SizedBox(
                  height: 8,
                ),
                Text("Use :  ${widget.doc.data["use"]}"),
                SizedBox(
                  height: 8,
                ),
                Text("Side Effects: ${widget.doc.data["sideef"]}"),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
            _launchCaller();
          },
          label: Text("Call Patient's Doctor"),
          icon: Icon(Icons.phone),
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }
}

_launchCaller() async {
  const url = "tel:8802327251";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

final String url =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRN54EQqKXbDxcBCHrptRo9zbHDbO9j7oo7dewMJZ6VH0pRdGb9";

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 130);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Patient Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Blood Grp",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "A+",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Age",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "54",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Gender",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "M",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.lineTo(0, size.height);
    p.lineTo(size.width, size.height);

    p.lineTo(size.width, 0);

    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
