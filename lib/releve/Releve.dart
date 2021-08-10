import 'package:changilni_employee/Models/ReleveModel.dart';
import 'package:changilni_employee/api.dart';
import 'package:flutter/material.dart';

class Releve extends StatelessWidget {
  const Releve({Key key, this.releveModel, this.networkHandler})
      : super(key: key);
  final ReleveModel releveModel;
  final Api networkHandler;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 365,
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
                        image: networkHandler.getImagee(releveModel.coverImage),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      releveModel.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.car_rental,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          releveModel.immatriculation,
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        
                        Icon(
                          Icons.gps_fixed,
                          size: 18,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          releveModel.adress,
                          style: TextStyle(fontSize: 15),
                        ),
                        Icon(
                          Icons.gps_fixed,
                          size: 18,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          releveModel.adress,
                          style: TextStyle(fontSize: 15),
                        ),
                        Icon(
                          Icons.park,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          
        ],
      ),
    );
  }
}