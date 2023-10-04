import 'package:expense_tracker_mobile_app/screens/registeration_login_screens/login_screen.dart';
import 'package:expense_tracker_mobile_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../common/common.dart';
import '../home_screen.dart';
import '../show_expenses.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  Utils utils = Utils();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var databaseReference = FirebaseDatabase.instance.ref();

  //ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
   return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/tracker_bg.jpg'),
                        fit: BoxFit.fill
                    ),
                  ),
                  width: Get.width,
                  child:SizedBox()
              ),
              Container(
                decoration: utils.blurGradientDecoration(),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        width: Get.width,
                        height: 120,
                        child:Row(
                          children: [
                            InkWell(
                                onTap: ()
                                {
                                  Get.back();
                                }
                                ,child: const Icon(Icons.arrow_back,color: Colors.white,)),
                            SizedBox(width: 10,),
                            utils.poppinsRegularText('Sign Up account', 16.0, AppColors.whiteColor, TextAlign.left)
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        width: Get.width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20,),
                            Container(
                                height: 150,
                                width: 250,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.purpleGradient
                                ),
                                child:Icon(Icons.key,color: Colors.white,size: 100,),),
                                //child: Image.asset('assets/images/user.png',height: 150,width: 250,color: AppColors.purpleGradient,)),

                            const SizedBox(height: 40,),

                            utils.textFieldWithoutIconWithoutBorder(firstNameController, 'Name', AppColors.txt2Color, TextInputType.text),

                            const SizedBox(height: 20,),
                            utils.textFieldWithoutIconWithoutBorder(middleNameController, 'Middle Name', AppColors.txt2Color, TextInputType.text),

                            const SizedBox(height: 20,),
                            utils.textFieldWithoutIconWithoutBorder(lastNameController, 'Last Name', AppColors.txt2Color, TextInputType.text),




                            const SizedBox(height: 20,),
                            utils.textFieldWithoutIconWithoutBorder(emailController, 'Email Address', AppColors.txt2Color, TextInputType.emailAddress),




                            const SizedBox(height: 25,),

                            utils.textFieldWithoutIconWithoutBorder(passwordController, 'Password', AppColors.txt2Color, TextInputType.text),


                            const SizedBox(height: 20,),
                            SizedBox(
                              width: Get.width,
                              height: 55,
                              child:  ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.purpleGradient,
                                    maximumSize: Size.fromWidth(Get.width),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                                ,
                                onPressed: ()
                                {
                                 signUpUser(firstNameController.text.trim().toString(),lastNameController.text.trim().toString(),
                                 middleNameController.text.trim().toString(),emailController.text.trim().toString(),passwordController.text.trim().toString()
                                 );
                                },
                                child:
                                utils.poppinsRegularText('Create Account', 18.0, Colors.white, TextAlign.center),),
                            ),
                            const SizedBox(height: 40,),


                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ],
          )

      ),
    );
  }
 Future signUpUser(String firstName,String lastName,String middleName,String email,String password) async
  {
    if(email.isEmpty || !email.contains('@') ||!email.contains('.com'))
    {
      utils.snackBar('Please Enter valid email');
    }
    else if (password.isEmpty )
    {
      utils.snackBar('please Enter user name');
    }
    else{
      utils.showLoadingDialog();
      try{
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        Map<String,dynamic>mapUser={
          "email":email.toString(),
          "password":password.toString(),
          "firstName":firstName.toString(),
          "lastName":lastName.toString(),
          "middleName":middleName.toString(),
          "uid":FirebaseAuth.instance.currentUser!.uid
        };
        databaseReference.child('Users').child(FirebaseAuth.instance.currentUser!.uid).set(mapUser).whenComplete(() {
          Common.userUid=FirebaseAuth.instance.currentUser!.uid;
          Get.back();
          utils.snackBar('You have successfully registered');
          Get.offAll(const ShowExpenses());
        });

      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.back();
          utils.snackBar('The password provided is too weak.');
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Get.back();
          utils.snackBar('The email is already exist.');
          print('The email is already exist.');
        }
      }
      catch (e) {
        Get.back();
        utils.snackBar('Something went wrong! Check your Internet Connection and Retry with correct Email.');
        print(e);
      }
    }

  }
}
