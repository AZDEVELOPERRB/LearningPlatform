import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learningplatform_rb/Constans/Constans.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Profile/Widgets/TopBar.dart';
import 'package:learningplatform_rb/UI/BottomClasses/Profile/Widgets/RoyalCustomClipper.dart';
import 'package:learningplatform_rb/providers/userProvider/userProvider.dart';
class StackContainer extends StatelessWidget {
  const StackContainer(this.userprovider,{Key key,}) : super(key: key);
 final UserProvider userprovider;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper:const MyCustomClipper(),
            child: Container(
              height: 300.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/images/profile.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
            userprovider.user.image==null?  Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image:AssetImage('Assets/images/profile_avatar.png')

                    )
                  ),
                  alignment:Alignment.bottomRight,
                  child:Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color:Colors.black45,
                      shape: BoxShape.circle,),
                    child:IconButton(icon:const Icon(Icons.edit,color:Colors.white,size: 25,),onPressed:editProfileImage,),
                  ),
                ) :SizedBox(
              height: 110,
              width: 110,
                  child: Stack(
                    children: [
                      CachedNetworkImage(imageUrl:userprovider.user.image.url,
              progressIndicatorBuilder:(BuildContext context ,s,downLoadProgress){
                        return const Center(
                          child:SizedBox(
                            height:20,
                            width: 20,
                            child: LinearProgressIndicator(backgroundColor:Colors.white),
                          ),
                        );
              },
              imageBuilder:(BuildContext context,imageprovider){
                        return Container(
                          alignment:Alignment.bottomRight,
                          decoration: BoxDecoration(
                            shape:BoxShape.circle,
                            image: DecorationImage(
                              image: imageprovider,
                              fit:BoxFit.cover
                            )
                          ),
                          child:SizedBox(
                            height:35,
                            child: FloatingActionButton(
                              backgroundColor:Colors.white,
                         child:const Icon(Icons.edit,color:Colors.black,size: 22,),onPressed:editProfileImage,
                            ),
                          ),
                        );},),


                    ],
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  userprovider.user.name,
                  style: TextStyle(
                    fontSize: 21.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  userprovider.user.email,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          // TopBar(),

        ],
      ),
    );
  }
  editProfileImage()async{
    final PickedFile file=await ImagePicker().getImage(source:ImageSource.gallery
    ,maxHeight:350,maxWidth:350
    );
    final File image=File(file.path);
    Uint8List imageBytes=await image.readAsBytes();
    final image64 =base64Encode(imageBytes);
    userprovider.updateUser({'image':image64,'image_extension':file.path.split("/").last});
  }
}

