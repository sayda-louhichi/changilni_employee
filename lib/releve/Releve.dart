import 'package:changilni_employee/Models/PushModel.dart';
import 'package:changilni_employee/Models/ReleveModel.dart';
import 'package:changilni_employee/api.dart';
import 'package:changilni_employee/pages/HomePage.dart';
import 'package:flutter/material.dart';

class Releve extends StatelessWidget {
  const Releve({Key key, this.releveModel, this.networkHandler})
      : super(key: key);
  final ReleveModel releveModel;
  final Api networkHandler;
  
  @override

  Widget build(BuildContext context) {
    Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                 ReleveModel relevemodel;
        networkHandler.delete(
              "/releve/delete/${releveModel.id}",relevemodel); 
              Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()),
                          (route) => false);
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
 Future <void> _sendNotif()async
     
   { 
        
          PushModel notifModel =
              PushModel(title: releveModel.immatriculation,body:releveModel.parc);
          var response = await networkHandler.post2(
              "/notification/send", notifModel.toJson());
          print(response);
        }
  
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 8,
              child: Column(
                children: [
                  Container(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                      image: networkHandler.getImagee(releveModel.id),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
/*IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
               _confirmDialog();
               
              },),*/
              IconButton(
                icon:Icon(Icons.notification_important),
                onPressed: (){
_sendNotif();
                },
              ),
                SizedBox(height: 10,),
                   Icon(
                          Icons.car_rental,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("immatricule "+
                          releveModel.immatriculation,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.gps_fixed,
                          size: 18,
                        ),
                        
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          releveModel.parc,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
              )
              )
                  ),
              
            
            
          SizedBox(
            height: 10,
          ),
          
        ],
      ),
    );
  }
}