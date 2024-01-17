import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shopify/providers/app_auth_provider.dart';
import 'package:shopify/providers/signup_provider.dart';
import 'package:shopify/utils/constants/colors_constants.dart';
import 'package:shopify/utils/constants/strings_constants.dart';
import 'package:shopify/widgets/build_profile_list_tile_widget.dart';
import 'package:shopify/widgets/customButton.dart';
import 'package:shopify/widgets/custom_divider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? _imageFile;
  String? profileImagepath;
  final ImagePicker _picker = ImagePicker();
  bool isSelectedFromGallary = false;
  String? imageUrl;
  String? newImageUrl;

  void uploadPic() async {
    File file = File(profileImagepath!);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("images/${file.path.split('/').last}");
    UploadTask uploadTask =
        ref.putFile(file, SettableMetadata(contentType: 'image/png'));

    uploadTask.whenComplete(() async {
      try {
        newImageUrl = await ref.getDownloadURL();

//======================== save url image in users collection============
        Provider.of<SignUpProvider>(context, listen: false)
            .updateUserImage(context, imageUrl!);
      } catch (onError) {
        debugPrint("Error");
      }
    });
  }

  void selectImageFromGalary() async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = pickedFile;
      profileImagepath = _imageFile!.path;
      debugPrint(profileImagepath);
    });
    uploadPic();
  }

  

  Widget networkImage(String? url) {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 65.0,
          backgroundImage: isSelectedFromGallary
              ?  FileImage(File(_imageFile!.path)) as ImageProvider
              : NetworkImage(url!),
          backgroundColor: const Color.fromARGB(6, 174, 40, 40),
        ),
        Positioned(
          bottom: 5.0,
          right: 5.0,
          child: InkWell(
            onTap: () {
              selectImageFromGalary();
              isSelectedFromGallary = true;
            },
            child: Icon(
              Icons.camera_alt,
              color: ColorsConstants.badgeColor,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<SignUpProvider>(builder: (__, signUpProvider, _) {
                return FutureBuilder(
                    future: signUpProvider.getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error While Get Data');
                        } else if (snapshot.hasData) {
                          imageUrl = snapshot.data?.image;
                          return Column(children: [
                            imageUrl == null
                                ? CircularProgressIndicator()
                                : networkImage(imageUrl),
                            // networkImage(snapshot.data?.image),
                            SizedBox(
                              height: 20.h,
                            ),

                            Text("${snapshot.data?.name}",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: ColorsConstants.greyTxtColor,
                                )),

                            SizedBox(
                              height: 15.h,
                            ),

                            //============================================================
                            Card(
                              child: Column(
                                children: [
                                  buildProfileListTileWidget(
                                      "${snapshot.data?.mail}",
                                      Icons.mail,
                                      () {}),
                                  customDividerWidget(),

                                  //============================================================
                                  buildProfileListTileWidget(
                                      "${snapshot.data?.phone}",
                                      Icons.phone,
                                      () {}),
                                  customDividerWidget(),

                                  //============================================================
                                  buildProfileListTileWidget(
                                      "${snapshot.data?.Adddress}",
                                      Icons.location_city,
                                      () {}),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            CustomButton(
                                text: StringsConstants.logout,
                                onBtnPressed: () {
                                  Provider.of<AppAuthProvider>(context,
                                          listen: false)
                                      .onLogout(context);
                                }),
                          ]);
                        } else {
                          return const Text('No Data Found');
                        }
                      } else {
                        return Text(
                            'Connection Statue ${snapshot.connectionState}');
                      }
                    });
              }))),
    );
  }
}
