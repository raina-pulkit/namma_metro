import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:namma_metro/Pages/color.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';
import '../../AuthPages/login_signup.dart';

class EditProfile extends StatefulWidget {
  final Map<String, dynamic> mpp;

  const EditProfile({super.key, required this.mpp});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  get defImg => "https://firebasestorage.googleapis.com/v0/b/namma-metro-36b56.appspot.com/o/images%2Fprofile_pic.png?alt=media&token=b7771536-f13e-4c68-af84-8dc013dfdb5f";

  void _showSnackBar(String message, Color col) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: col,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController phNoCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();

  Future<bool> saveProfile(Map<String, dynamic> mpp){
    String name = nameCtrl.text;
    String address = addressCtrl.text;
    String phNostr = phNoCtrl.text.trim();
    String ageStr = ageCtrl.text.trim();
    int? phNo = -1;
    int? age;

    if(ageStr != "") {
      age = int.tryParse(ageStr);
    } else {
      age ??= (mpp['phone_number']!=-1)?mpp['age']:-1;
    }

    if(name == '') name = mpp['user_name'];
    if(address == '') address = mpp['address'];

    if(phNostr.isEmpty){
      phNo = (mpp['phone_number']!=-1)?mpp['phone_number']:phNo;
    }
    else if(phNostr.length != 10) {
      phNo = (mpp['phone_number']!=-1)?int.parse(phNostr):phNo;
    } else {
      phNo = int.tryParse(phNostr);
      phNo ??= (mpp['phone_number']!=-1)?mpp['phone_number']:-1;
    }

    age ??= (mpp['phone_number']!=-1)?mpp['age']:-1;

    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: AlertDialog(
              backgroundColor: Colors.deepPurpleAccent,
              title: Text(
                "Save Profile?",
                style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700
                ),
              ),
              content: Text(
                "Are you sure you want to save your details?",
                style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    "No",
                    style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      Map<String, dynamic> newData1 = {
                        'address': address,
                        'phone_number': phNo,
                        'age': age
                      };
                      Map<String, dynamic> newData2 = {
                        'user_name': name,
                      };

                      var uid = FirebaseAuth.instance.currentUser?.uid;

                      await FirebaseFirestore.instance.collection("users").doc(uid).update(newData2);

                      await FirebaseFirestore.instance.collection("user_details").doc(uid).update(newData1)
                      .then((res) {
                        Navigator.of(context).pop(true);
                      });
                    }
                    catch (e) {
                      _showSnackBar(
                          "Couldn't add data! ${e.toString()}",
                          Colors.red
                      );
                    }
                  },
                  child: Text(
                    "Yes",
                    style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
    return false as Future<bool>;
  }

  void deleteProfile(){
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: AlertDialog(
              backgroundColor: Colors.redAccent,
              title: Text(
                "DELETE PROFILE?",
                style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700
                ),
              ),
              content: Text(
                "ARE YOU SURE YOU WANT TO DELETE YOUR PROFILE?",
                style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "No",
                    style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      User? user = FirebaseAuth.instance.currentUser;
                      await user?.delete().then((result){
                        showDialog(
                          context: context,
                          builder: (context){
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                              child: AlertDialog(
                                backgroundColor: Colors.greenAccent,
                                title: Text(
                                  "Profile Deleted!",
                                  style: GoogleFonts.rajdhani(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                content: Text(
                                  "Your profile was successfully deleted!",
                                  style: GoogleFonts.rajdhani(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20
                                  ),
                                ),
                              ),
                            );
                          }
                        );
                        Navigator.popUntil(
                            context, (route) => false
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginSignup())
                        );
                      });
                    }
                    catch (e) {
                      _showSnackBar(
                          "Couldn't delete profile, try again! ${e.toString()}",
                          Colors.red
                      );
                    }
                  },
                  child: Text(
                    "Yes",
                    style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  void imagePicker() async{
    // Get File path
    ImagePicker imgPick = ImagePicker();
    XFile? img = await imgPick.pickImage(source: ImageSource.gallery);
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

    // Upload to DB
    Reference reference = FirebaseStorage.instance.ref().child("images");
    Reference refImgToUpload = reference.child(uniqueName);
    String imgURL;
    try{
      await refImgToUpload.putFile(File(img!.path));
      imgURL = await refImgToUpload.getDownloadURL();
      await FirebaseFirestore.instance.collection("user_details").doc(FirebaseAuth.instance.currentUser!.uid).set({
        "profile_pic": imgURL,
      }).then((res) {
        Navigator.pop(context);
      });
    }
    catch(e){
      _showSnackBar("Image Couldn't Be uploaded", Colors.red);
      Future.delayed(const Duration(seconds: 0)).then((value) => Navigator.of(context).pop());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: secondary,
      appBar: CustomTopAppBar(
        text: "Edit Profile",
        show: true,
        context: context,
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          // margin: const EdgeInsets.only(top: 10),
                          width: 120, height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(widget.mpp['profile_pic']??defImg)),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => imagePicker(),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.black54
                                ),
                                child: const Icon(Icons.add_a_photo_rounded, color: Colors.white,),
                              ),
                            )
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Form(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black54
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: const Icon(Icons.email, color: Colors.white,)
                              ),
                            ),
                            title: Text(
                              "${widget.mpp['email']??"genericemail@gmail.com"}",
                              style: GoogleFonts.rajdhani(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: nameCtrl,
                              decoration: InputDecoration(
                                  hintText: "${widget.mpp['user_name']??"Profile"}",
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                  prefixIcon: const Icon(Icons.person)
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: addressCtrl,
                              decoration: InputDecoration(
                                hintText: "${(widget.mpp['address']!='`')?widget.mpp['address'] : "Not set yet"}",
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(80),
                                ),
                                prefixIcon: const Icon(Icons.map)
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: phNoCtrl,
                              decoration: InputDecoration(
                                  hintText: "${(widget.mpp['phone_number']!=-1)?widget.mpp['phone_number'] : "Not set yet"}",
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                  prefixIcon: const Icon(Icons.phone_android)
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: ageCtrl,
                              decoration: InputDecoration(
                                  hintText: "${(widget.mpp['age']!=-1)?widget.mpp['age'] : "Not set yet"}",
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                  prefixIcon: const Icon(Icons.accessibility_new_outlined)
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async{
                              await saveProfile(widget.mpp).then((res) {
                                if(res) Navigator.of(context).pop();
                              });
                              setState(() {

                              });
                            },

                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(327, 50),
                                backgroundColor: Colors.black87,
                                foregroundColor: Colors.white,
                                elevation: 1,
                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                )
                            ),
                            child: Text(
                              "Save Profile",
                              style: GoogleFonts.rajdhani(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          ElevatedButton(
                            onPressed: deleteProfile,
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(8, 8),
                                backgroundColor: const Color.fromRGBO(175, 19, 19, 1.0),
                                foregroundColor: Colors.white,
                                elevation: 1,
                                padding: const EdgeInsets.all(20),
                                shape: const CircleBorder()
                            ),
                            child: Text(
                              "Delete\nAccount",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rajdhani(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25
                              ),
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
            ),
          );
        }
      )
    );
  }
}