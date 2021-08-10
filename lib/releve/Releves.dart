
import 'package:changilni_employee/CustumWidget/ReleveCard.dart';
import 'package:changilni_employee/Models/ReleveModel.dart';
import 'package:changilni_employee/Models/SuperModel.dart';
import 'package:changilni_employee/api.dart';
import 'package:changilni_employee/releve/Releve.dart';
import 'package:flutter/material.dart';

class Releves extends StatefulWidget {
  Releves({Key key, this.url}) : super(key: key);
  final String url;

  @override
  _RelevesState createState() => _RelevesState();
}

class _RelevesState extends State<Releves> {
  Api networkHandler = Api();
  SuperModel superModel = SuperModel();
  List<ReleveModel> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return data.length > 0
        ? Column(
            children: data
                .map((item) => Column(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => Releve(
                                          releveModel: item,
                                          networkHandler: networkHandler,
                                        )));
                          },
                          child: ReleveCard(
                            releveModel: item,
                            networkHandler: networkHandler,
                          ),
                        ),
                       
                      ],
                    ))
                .toList(),
          )
        : Center(
            child: Text("We don't have any Blog Yet"),
          );
  }
}