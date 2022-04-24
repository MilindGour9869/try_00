import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Cloud_Storage {

  static Future Patient_Prescription_Upload( {String doc_id  , String visit_date, File file})async{
    final ref = await FirebaseStorage.instance.ref('Patient/${doc_id}/Prescription/${visit_date}');

    return ref.putFile(file);


  }

  static Future Patient_Profile_Image_Upload( {String doc_id , File file})async{
    try{
      final ref = await FirebaseStorage.instance.ref('Patient/${doc_id}/Profile/Profile');

      return ref.putFile(file);
    }
    on FirebaseException catch (e){

      return null;

    }



  }

}