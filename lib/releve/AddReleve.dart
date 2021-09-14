import 'dart:convert';
import 'package:changilni_employee/Models/PushModel.dart';
import 'package:changilni_employee/Models/ReleveModel.dart';
import 'package:changilni_employee/api.dart';
import 'package:changilni_employee/pages/HomePage.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class AddReleve extends StatefulWidget {
  const AddReleve({ Key key }) : super(key: key);

  @override
  _AddReleveState createState() => _AddReleveState();
}

class _AddReleveState extends State<AddReleve> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _immatricule = TextEditingController();
  TextEditingController _adress = TextEditingController();
TextEditingController _parc = TextEditingController();
   TextEditingController _name = TextEditingController();
  ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  IconData iconphoto = Icons.image;
  Api networkHandler = Api();
 List parcItemList = List();
 List immaItemList = List();
var selectedType ;
 var select;
 Future getListParc()async{
   var response= await http.get("http://192.168.0.230:3000/admin/list-parc");
   if(response.statusCode == 200){
     var jsonData = json.decode(response.body);
     setState((){
       parcItemList =jsonData;
     });
   }
   print(parcItemList);
 }
 Future getListImma()async{
   var response= await http.get("http://192.168.0.230:3000/admin/list-imma");
   if(response.statusCode == 200){
     var jsonData = json.decode(response.body);
     setState((){
       immaItemList =jsonData;
     });
   }
   print(immaItemList);
 }
 
 @override
 void initState(){
   super.initState();
   getListParc();
   getListImma();
  
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff27313B),
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              /*if (_imageFile.path != null &&
                  _formkey.currentState.validate()) {
                showModalBottomSheet(
                  context: context,
                 builder: ((builder) => OverlayCard(
                        imagefile: _imageFile,
                        immatriculation: _immatricule.text,
                      ))*/
                
            
            },
            child: Text(
              "Voir",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: <Widget>[
            titleTextField(),
            SizedBox(
              height: 10,
            ),
            immatriculationTextField(),
             SizedBox(
              height: 10,
            ),
            adressTextField(),
             SizedBox(
              height: 10,
            ),
            parcTextField(),
            SizedBox(
              height: 40,
            ),
            
            addButton(),
        
         
                  ],
        ),
      ),
    );
  }
  

  Widget titleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: TextFormField(
        controller: _name,
        validator: (value) {
          if (value.isEmpty) {
            return "Champ nom est obligatoire";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff707070),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF707070),
              width: 2,
            ),
          ),
          labelText: "Ajouter titre et image",
          prefixIcon: IconButton(
            icon: Icon(
              iconphoto,
              color: Color(0xFF707070),
            ),
            onPressed:(){showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet()));}
          ),
        ),
      ),
    );
  }

  Widget adressTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        controller: _adress,
        validator: (value) {
          if (value.isEmpty) {
            return "Champ adress est obligatoire";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF707070),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF707070),
              width: 2,
            ),
          ),
          labelText: "Adresse",
        ),
      ),
    );
  }
  Widget immatriculationTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
    
      child:DropdownButton(
          isExpanded:true,
          hint:Text("Immatriculation"),
          value:selectedType,
          items: immaItemList.map((immatricule) {
            return DropdownMenuItem(
              value:immatricule['immatriculation'],
              child: Text(immatricule['immatriculation'])
              );
          }).toList(),
        onChanged:(value){
          setState(() {
            _immatricule.text=value;
          });
        }),
   
    );
  }
Widget parcTextField() {
    return Padding(
       padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
       child:  DropdownButton(
          isExpanded:true,
          hint:Text("Parc"),
          value:selectedType,
          items: parcItemList.map((parc) {
            return DropdownMenuItem(
              value:parc['name'],
              child: Text(parc['name'])
              );
          }).toList(),
        onChanged:(value){
          setState(() {
            _parc.text=value;
          });
        }),
      
    );
  }
  Widget addButton() {
    return InkWell(
      onTap: () async {
        if (_imageFile != null && _formkey.currentState.validate()) {
          ReleveModel releveModel =
              ReleveModel(immatriculation: _immatricule.text, adress: _adress.text,parc: _parc.text,name: _name.text);
          var response = await networkHandler.post1(
              "/releve/Add", releveModel.toJson());
          print(response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            String id = json.decode(response.body)["data"];
            var imageResponse = await networkHandler.patchImage(
                "/releve/add/coverImage/$id", _imageFile.path);
            print(imageResponse.statusCode);
            if (imageResponse.statusCode == 200 ||
                imageResponse.statusCode == 201) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            }
          }
        }
      },
      child: Center(
        child: Container(
          height: 50,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),color: Color(0xFF707070)),
          child: Center(
              child: Text(
            "Ajouter",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

   Widget bottomSheet() {
    return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(children: <Widget>[
          Text(
            "sélectionner une photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Caméra"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallerie"),
            ),
          ])
        ]));
  }

  void takePhoto(ImageSource source) async {
    final PickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = PickedFile;
    });
  }


}
