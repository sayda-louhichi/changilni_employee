import 'dart:io';
import 'package:changilni_employee/Models/ReleveModel.dart';
import 'package:changilni_employee/api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReleveCard extends StatelessWidget {
  const ReleveCard({Key key, this.releveModel, this.networkHandler})
      : super(key: key);

  final ReleveModel releveModel;
  final Api networkHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: networkHandler.getImagee(releveModel.id),
                    fit: BoxFit.fill),
              ),
            ),
            Positioned(
              bottom: 2,
              child: Container(
                padding: EdgeInsets.all(7),
                height: 60,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  releveModel.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
           IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
            color: Colors.black,
          ),
          ],
        ),
      ),
    );
  }
}