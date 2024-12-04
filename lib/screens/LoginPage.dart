
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mta/Data/LoginInformation/AuthLogin.dart';
import 'package:mta/Data/LoginInformation/AuthLoginInfoDetails.dart';

import 'package:mta/widgets/mtaToast.dart';
import '../Data/ServerInteration/Result.dart';
import '../General/MTAInternetConnectivity.dart';

import '../Models/TALogin/LoginDetails.dart';
import '../Models/TALogin/login.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState  extends State<LoginPage>
{
  var txtLoginID=TextEditingController();
  var txtPassword=TextEditingController();
  bool passwordVisible=true;
  @override
  void initState(){
    super.initState();

    passwordVisible=true;
  }
  @override
  Widget build(BuildContext context) {
    return
      //BackgroundImage(),
      Scaffold(
          resizeToAvoidBottomInset: false,
          //backgroundColor: Colors.transparent,
          body:

          Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset('assets/images/img_loginscreen.png',
                  fit: BoxFit.cover,

                ),
                Center(child: SizedBox(

                    width:300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:<Widget> [
                        Container(height: 60,),
                        Container(
                            width:250,
                            height:250,

                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/logo_mta.png'),

                              ), )),

                        TextField(

                          controller: txtLoginID,
                          style: const TextStyle(color: Colors.white),
                          decoration:InputDecoration(

                              hintText: "Login ID",
                              hintStyle: const TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.white,
                                      width:2
                                  )
                              ),
                              prefixIcon: const Icon(Icons.person,color: Colors.white,)
                          ),
                        ),
                        Container(height: 20,),
                        TextField(
                          controller: txtPassword,
                          style: const TextStyle(color: Colors.white),
                          obscureText: passwordVisible,
                          obscuringCharacter: '*',
                          decoration:InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.white,
                                      width: 2
                                  )
                              ),
                              prefixIcon: const Icon(Icons.lock_open,color: Colors.white, ),
                              suffixIcon: IconButton(icon: Icon( passwordVisible? Icons.visibility: Icons.visibility_off) ,
                                  color: Colors.white,
                                  onPressed: () {
                                    if(mounted) {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    }

                                  }


                              )
                          ),
                        ),

                        Container(height: 40,),


                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent, //background color of button

                                  //border width and color
                                  elevation: 3, //elevation of button
                                  shape: RoundedRectangleBorder( //to set border radius to button
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  padding: const EdgeInsets.all(10) //content padding inside button
                              ),
                              onPressed: () async {
                                bool bResult=await CheckLoginIDNPassword();
                                if(bResult)
                                  {
                                    await CheckLoginValidity();
                                  }
                              },
                              child: const Text("Login",style: TextStyle(color: Colors.white, fontSize: 25),)
                          ),
                        ),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (false)const Text("Don't have an account?",style: TextStyle(color: Colors.white,fontSize: 14 ),),
                              // Todo: for New following code changes are not done
                              if (false)TextButton(

                                onPressed: ()
                                {

                                  //Navigator.pushReplacement(
                                  // context,
                                  //MaterialPageRoute(
                                  //   builder: (context) => const NewEmployeeScreen(), //Add NewLogin
                                  //  ),
                                  //  );

                                },
                                child: const Text("Signup",style: TextStyle(color: Colors.pinkAccent,fontSize: 14 ),),
                              ),

                            ]
                        ),
                        Container(height: 20,),


                        const Text(
                          'Powered By Insignia E Security Pvt Ltd',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),),

                      ],
                    )
                )
                )
              ]
          )
      );

  }


Future<bool> CheckLoginIDNPassword() async
{
    bool bResult=true;
    try {
      String strLoginID = txtLoginID.text.toString();
      String strPassword = txtPassword.text.toString();
      // check Inter net connection
      bool bConnectivity = await MTAInternetConnectivity()
          .IsConnectedToInternet();
      if (!bConnectivity) {
        return false;
      }
    }
    on Exception catch(e)
    {
      MTAToast().ShowToast(e.toString());
      bResult=false;
    }
    return bResult;
    }
Future<bool> CheckLoginValidity() async
{
      // Todo: pass 'INS' for CompanyCode using textbox from login screen
        bool bResult=false;
        String strLoginID = txtLoginID.text.toString();
        String strPassword = txtPassword.text.toString();
        try {
      AuthLogin objLoginInfo= await AuthLoginDetails().LoginInformationForFirstLogin('INS',strLoginID,strPassword);
      Result objResult=await LoginDetails().GetLogin(objLoginInfo);
      if(objResult.IsResultPass) {
        if (objResult.Mode == LoginMode.UserForAPI) {
          String strJson=objResult.ResultRecordJson;
          Map<String, dynamic> valueMap = json.decode(strJson);
          Login objLogin = Login.fromJson(valueMap);
        }
        else if (objResult.Mode == LoginMode.Employee)
        {
          AuthLogin objLoginInfo = await AuthLoginDetails()
              .UpdateSuccessFullLoginInformation(
              'INS', strLoginID, strPassword, objResult.Mode);
        }
      }
      else //if(objResult.IsResultPass)
          {
        MTAToast().ShowToast(objResult.ResultMessage.toString());
      }//if(objResult.IsResultPass)

      //Testing
      AuthLogin objAuthLogin= await AuthLoginDetails().LoginInformationForFirstLogin('INS',strLoginID,strPassword);
      CheckWorkingOfCompanyForTesting(objAuthLogin);

      //if(objResult!=null)
    }
    on Exception catch(e)
    {
      MTAToast().ShowToast(e.toString());
    }
    return bResult;
  }

  // AuthLogin object will pass and maintain in widget after successfull Login
Future<bool> CheckWorkingOfCompanyForTesting(AuthLogin objAuthLogin) async
{
    bool bResult=false;
    try {
        


    }
    on Exception catch(e)
    {
      MTAToast().ShowToast(e.toString());
    }
    return bResult;
  }



}
