import 'package:changilni_employee/Screens/HomeScreen.dart';
import 'package:changilni_employee/pages/WelcomePage.dart';
import 'package:changilni_employee/profile/ProfileScreen.dart';
import 'package:changilni_employee/releve/AddReleve.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../api.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentState = 0 ;
   final networkHandler = Api();
   String email ="";
 List<Widget> widgets = [ HomeScreen(), ProfileScreen()];
    final storage = FlutterSecureStorage();
    List<String> titleString = ["Home Page", "Profile Page"];
    Widget profilePhoto= Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                );
    @override
  void initState() {
    super.initState();
    checkProfile();
  }
    void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    setState(() {
      email = response['email'];
    });
    if (response["status"] == true) {
      setState(() {
        profilePhoto = CircleAvatar(
          radius: 50,
          backgroundImage: Api().getImage(response['email']),
        );
      });
    } else {
      setState(() {
        profilePhoto = Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      });
    }
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: <Widget>[
          DrawerHeader(
            child: Column(
              children: <Widget>[
               profilePhoto,
                SizedBox(
                  height: 10,
                ),
                Text("$email"),
              ],
            ),
          ),
           ListTile(
              title: Text("Paramétres"),
              trailing: Icon(Icons.settings),
              onTap: () {},
            ),
          ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.power_settings_new),
              onTap: logout,
            ),
        ]),
      ),
      backgroundColor: Color(0xffE4E4E4),
      appBar: AppBar(
        backgroundColor: Color(0xff27313B),
        title: Text(titleString[currentState],
          style: TextStyle(color: Color(0xFF707070)),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications),
          color:Color(0xFF707070),
           onPressed: () {})
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff27313B),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddReleve(),
                        ));
        },
        child: Text(
          '+',
          style: TextStyle(fontSize: 35,
          color: Color(0xFF707070)),
          
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color:Color(0xff27313B),
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: Container(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  color: currentState == 0 ? Colors.white:Color(0xFF707070),
                  onPressed: () {
                    setState(() {
                      currentState = 0 ;
                    });
                  },
                  iconSize: 40,
                ),
                IconButton(
                  icon: Icon(Icons.person),
                 color: currentState == 1 ? Colors.white:Color(0xFF707070),
                  onPressed: () { 
                    setState(() {
                      currentState = 1 ;
                    });},
                  iconSize: 40,
                ),
              ],
            ),
          ),
        ),
      ),
      body:widgets[currentState]
    );
  }
  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }
}
