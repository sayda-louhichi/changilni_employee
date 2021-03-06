import 'package:changilni_employee/api.dart';
import 'package:changilni_employee/pages/ForgotPassword.dart';
import 'package:changilni_employee/pages/HomePage.dart';
import 'package:changilni_employee/pages/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';


class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool vis = true;

  final _formKey = GlobalKey<FormState>();
  Api networkHandler = Api();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();
  bool _isLogin = false;
  Map data;
  //final facebookLogin = FacebookLogin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E4E4),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 0,
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                      ),
                    ],
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: AssetImage('assets/logo.png'),
                  width: 400,
                  height: 400,
                  alignment: Alignment.center,
                ),
                emailTextField(hint:"Email",icon:Icons.email),
                 passwordTextField(hint:"Mot de passe",icon:Icons.vpn_key),
              
                SizedBox(
                  height: 5,
                ),
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                        child:Text(
                        "Nouveau Mot de passe?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          
                        ),
                      ),),
                  ],
                ),
            
                InkWell(
                  onTap: () async {
                    setState(() {
                      circular = true;
                    });
                    //Login Logic start here
                    Map<String, String> data = {
                      "email": _emailController.text,
                      "password": _passwordController.text,
                    };
                    var response =
                        await networkHandler.post("/employee/login", data);

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      Map<String, dynamic> output = json.decode(response.body);
                      print(output["token"]);
                      await storage.write(key: "token", value: output["token"]);
                      setState(() {
                        validate = true;
                        circular = false;
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false);
                    } else {
                      String output = json.decode(response.body);
                      setState(() {
                        validate = false;
                        errorText = output;
                        circular = false;
                      });
                    }

                    // login logic End here
                  },
                    child: Center(
                    child: circular
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff27313B)),
                              child: Center(
                                  child: Text(
                                "Se connecter",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                  ),
                ),
               
               
              ],
            )
          ],
        ),
      ),
    );
  }

  

Widget emailTextField({controller, hint, icon}) {
    return Container(
    
      margin: const EdgeInsets.only(top: 10,left:30,right: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
        child:TextFormField(
            controller: _emailController,
             decoration: InputDecoration(
               errorText: validate ? null : errorText,
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
          )
    );
  }

  Widget passwordTextField({controller,hint,icon}) {
    return Container(
      margin: const EdgeInsets.only(top: 10,bottom: 50,left:30,right: 30),
      decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child:TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) return "Password can't be empty";
              if (value.length < 8) return "Password lenght must have >=8";
             return null;
            },
            obscureText: vis,
            decoration: InputDecoration(
              errorText: validate ? null : errorText,
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    vis = !vis;
                  });
                },
              ),
              hintText: hint,
          prefixIcon: Icon(icon),
            ),
          )
        
    );
  }
  

}