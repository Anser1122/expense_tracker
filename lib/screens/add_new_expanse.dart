
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker_mobile_app/Utils/utils.dart';
import 'package:expense_tracker_mobile_app/models/expanseDetails.dart';
import 'package:expense_tracker_mobile_app/screens/show_expenses.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../colors.dart';
import 'common/common.dart';

class AddNewExpanse extends StatefulWidget {
  final ExpenseDetails? expanseDataEdit;
  final String? status;
  const AddNewExpanse({Key? key,this.expanseDataEdit,this.status}) : super(key: key);

  @override
  State<AddNewExpanse> createState() => _AddNewExpanseState();
}

class _AddNewExpanseState extends State<AddNewExpanse> {
  Utils utils = Utils();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  //TextEditingController dateController = TextEditingController();
  List selectCategory = ['Food', 'Transportation', 'Entertainment',];
  String? selectCategoryName;

  RxString dateOfExpanse ='Date of Expanse'.obs;
  final imagePicker = ImagePicker();
  String url = '';
  Rx<File> profileImage = File('').obs;
  var databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   widget.status=='edit'? setData():null;
  }
  setData()async{
    descriptionController.text = widget.expanseDataEdit!.description!;
    amountController.text = widget.expanseDataEdit!.amount!;
    dateOfExpanse.value = widget.expanseDataEdit!.date!;
    url = widget.expanseDataEdit!.receipt!;
    if(widget.expanseDataEdit!.category! =='Food')
      {
        selectCategoryName=  selectCategory[0];
      }
    if(widget.expanseDataEdit!.category! =='Transportation')
    {
      selectCategoryName=   selectCategory[1];
    }
    if(widget.expanseDataEdit!.category! =='Entertainment')
    {
      selectCategoryName= selectCategory[2];
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title:utils.poppinsMediumText(widget.status=='edit'?'Update Expense':'Add New Expense', 20.0, AppColors.blackColor, TextAlign.center) ,
        leading: InkWell(
          onTap: ()
          {
            Get.to(const ShowExpenses());
          },
          child: Icon(Icons.arrow_back)
          ,
        ),
      ),

      body: (
      Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              utils.textFieldWithoutIconWithoutBorder(descriptionController, 'Description', AppColors.txt2Color, TextInputType.text),
              const SizedBox(height: 20,),
              utils.textFieldWithoutIconWithoutBorder(amountController, 'Amount', AppColors.txt2Color, TextInputType.number),

              const SizedBox(height: 20,),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.utc(2018, 1, 1),
                    //lastDate: DateTime.now().add(const Duration(days: 365)),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: const ColorScheme.dark(
                            primary: AppColors.pinkGradient,
                            onPrimary: AppColors.purpleGradient,
                            surface: AppColors.pinkGradient,
                            onSurface: AppColors.purpleGradient,
                          ),
                          dialogBackgroundColor: AppColors.orangeGradientLight,
                        ),
                        child: child!,
                      );
                    },
                  );
                  dateOfExpanse.value = DateFormat("yyyy-MM-dd").format(pickedDate!);
                  // endingDate.value = DateFormat("yyyy-MM-dd").format(pickedDate.add(const Duration(days: 30)));
                },
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(left: 7,right: 7),
                  height: 55.0,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: Colors.grey
                          )
                      )
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Obx(() => utils.poppinsRegularText(dateOfExpanse.value, 14.0, AppColors.txt2Color, TextAlign.start))),
                      Spacer(),
                      const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Icon(Icons.edit_calendar_outlined, size: 20, color: Colors.grey)),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                decoration: utils.rectangleBoxWithoutElevation(10.0, Colors.white),
                child: DropdownButton(
                  isExpanded: true,
                  value: selectCategoryName,
                  hint: utils.poppinsRegularText('Select', 16.0, AppColors.txt2Color, TextAlign.left),
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 30,
                  underline: SizedBox(),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                  onChanged: (newValue) {
                    // print('ValueChoose:${valueChooseCategory}');
                    setState(() {
                      selectCategoryName = newValue.toString();
                    });
                  },
                  items: selectCategory.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: utils.poppinsRegularText(valueItem, 16.0, AppColors.txt2Color, TextAlign.left),

                    );
                  }).toList(),
                ),
              ),


              SizedBox(height: 30.0,),
              Align(
                alignment: Alignment.centerLeft,
                child:utils.poppinsRegularText('(Optional)', 16.0, AppColors.blackColor, TextAlign.left),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: ()
                {
                  getImage();
                },
                child: Container(
                  height: 150,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: AppColors.greyServices
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child:utils.poppinsRegularText('Upload Receipt', 16.0, AppColors.lightGrey2Color, TextAlign.center),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Obx(
                                () => ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    child: profileImage.value.path == ""
                                        ? url != ""
                                        ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:url,
                                      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                                        height: 100,
                                        width: 100,
                                        child: Center(
                                            child: CircularProgressIndicator(value: downloadProgress.progress)),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          SvgPicture.asset('', fit: BoxFit.cover),
                                    )
                                        : const SizedBox()
                                        : Image.file(profileImage.value, fit: BoxFit.cover)),
                          )),

                    ],
                  )
                ),
              ),
              SizedBox(height: 40,),

              Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: SizedBox(
                  width: Get.width,
                  height: 55,
                  child:  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.pinkGradient,
                        maximumSize: Size.fromWidth(Get.width),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
                    ,
                    onPressed: ()
                    {
                      addExpanse(descriptionController.text.trim().toString(),amountController.text.trim(),
                        dateOfExpanse.value.toString(),selectCategoryName.toString());
                    },
                    child:
                    utils.poppinsRegularText(widget.status=='edit'?'UPDATE EXPENSE':'ADD NEW EXPENSE', 16.0, Colors.white, TextAlign.center),),
                ),
              ),

            ],
          ),
        ),

      )
      ),
    ));
  }

  getImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    //profileImage.value = await cropImage(File(pickedFile!.path));
    profileImage.value = File(pickedFile!.path);
    /// Now I am gonaa store in firebaseDataBAse;
    utils.showLoadingDialog();
    final file = File(profileImage.value.path);
    print('FilePath:$file');

    String extension = profileImage.value.path.split('.').last;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("ExpensePic")
        .child("${DateTime.now().millisecondsSinceEpoch.toString()}.$extension");
    TaskSnapshot downloadurl = await ref.putFile(file);
    url = await downloadurl.ref.getDownloadURL();
    print('UrlAfter$url');
    Get.back();
    /// Now we have this url we can save it as a string in our firebaseDatabase.
  }

  addExpanse(String description,String amount,String dateOfExpanse,String category)
  {
    if(description.isEmpty)
      {
        utils.snackBar('Please enter description');
      }
    else if(amount.isEmpty)
      {
        utils.snackBar('Please enter some amount');
      }
    else if(dateOfExpanse=='Date of Expanse')
      {
        utils.snackBar('Please select date of your expense');
      }
    else if(category.isEmpty)
      {
        utils.snackBar('Please Enter Category');
      }
    else{
      utils.showLoadingDialog();
      String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
      Map<String,dynamic>mapData={
        'description':description,
        'amount':amount,
        'dateOfExpanse':dateOfExpanse,
        'category':category,
        'receipt':url,
        'createdTime':widget.status=='edit'?widget.expanseDataEdit!.createdTime:currentTime
      };
      widget.status=='edit'?

      databaseReference.child('Expanses').child(widget.expanseDataEdit!.createdTime!.toString()).update(mapData).whenComplete(() {
        Map<String,dynamic> mapTime ={
          'createdTime':widget.expanseDataEdit!.createdTime
        };
        databaseReference.child('Users').child(Common.userUid).child('ExpanseList').child(widget.expanseDataEdit!.createdTime!).update(mapTime).whenComplete(() {
          Get.back();
          utils.snackBar('You have update successfully your expense');
          Get.to(ShowExpenses());

        });
      }):
      databaseReference.child('Expanses').child(currentTime).set(mapData).whenComplete(() {

        Map<String,dynamic> mapTime ={
          'createdTime':currentTime
        };
        databaseReference.child('Users').child(Common.userUid).child('ExpanseList').child(currentTime).set(mapTime).whenComplete(() {
          Get.back();
          utils.snackBar('You have entered successfully your expense');
          Get.to(ShowExpenses());

        });
      });


    }

  }

}
