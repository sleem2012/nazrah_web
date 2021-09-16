import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart' as fb;
import 'dart:html';

import 'package:flutter/cupertino.dart';

Future<Uri> downloadUrl(String path) {
  return fb
      .storage()
      .refFromURL('gs://nazarih-9bb05.appspot.com')
      .child(path)
      .getDownloadURL();
}

Future<List<String>> downloadUrls(List paths) async {
  List<String> list = [];
  for (var i = 0; i < paths.length; i++) {
    var temp = await fb
        .storage()
        .refFromURL('gs://nazarih-9bb05.appspot.com')
        .child(paths[i])
        .getDownloadURL();
    list.add(temp.toString());
  }
  return list;
}

void uploadImage({@required Function(File file) onSelected}) {
  InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
  uploadInput.click();

  uploadInput.onChange.listen((event) {
    final file = uploadInput.files.first;
    final reader = FileReader();
    reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((event) {
      onSelected(file);
    });
  });
}

void uploadAdImage({@required Function(File file) onSelected}) {
  InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
  uploadInput.click();

  uploadInput.onChange.listen((event) {
    final file = uploadInput.files.first;
    final reader = FileReader();
    reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((event) {
      onSelected(file);
    });
  });
}

// Future<String> uploadImages(
//     String uid, String phoneNumber, DateTime dateTime) async {
//   InputElement uploadInput = FileUploadInputElement()
//     ..accept = 'image/*'
//     ..multiple = true;
//   uploadInput.click();

//   uploadInput.onChange.listen((event) {
//     for (var i = 0; i < uploadInput.files.length; i++) {
//       final reader = FileReader();
//       final file = uploadInput.files[i];
//       reader.readAsDataUrl(file);
//       reader.onLoadEnd.listen((event) async {
//         await uploadMultipleToStorage(
//             uid, phoneNumber, dateTime, file, i, uploadInput.files.length);
//       });
//     }
//   });
//   if (uploadInput.files.length == 0) {
//     return 'failed';
//   } else {
//     return 'done';
//   }
// }

String uploadDelegateImages(DateTime dateTime) {
  InputElement uploadInput = FileUploadInputElement()
    ..accept = 'image/*'
    ..multiple = true;
  uploadInput.click();

  uploadInput.onChange.listen((event) {
    for (var i = 0; i < uploadInput.files.length; i++) {
      final reader = FileReader();
      final file = uploadInput.files[i];
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        await uploadDelegateMultipleToStorage(
            dateTime, file, i, uploadInput.files.length);
      });
    }
  });
  return 'done';
}

void uploadAdToStorage(int adNo, String path) {
  // final path = '/default/ads/ads-$adNo';
  uploadImage(onSelected: (file) {
    fb
        .storage()
        .refFromURL('gs://nazarih-9bb05.appspot.com')
        .child(path)
        .put(file)
        .future
        .then((_) {
      FirebaseFirestore.instance
          .collection('info')
          .doc('banners')
          .update({'ads $adNo': path});
    });
  });
}

void uploadToStorage(String uid, String phoneNumber) {
  final dateTime = DateTime.now();
  final path = '$uid/profile/$dateTime';
  uploadImage(onSelected: (file) {
    fb
        .storage()
        .refFromURL('gs://nazarih-9bb05.appspot.com')
        .child(path)
        .put(file)
        .future
        .then((_) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(phoneNumber)
          .update({'photo_url': path});
    });
  });
}

void uploadMultipleToStorage(String uid, String phoneNumber, DateTime dateTime,
    File file, int index, int total) async {
  var rng = new Random();
  var number = rng.nextInt(100);
  final path = '$uid/ads/$dateTime/$number';
  await fb
      .storage()
      .refFromURL('gs://nazarih-9bb05.appspot.com')
      .child(path)
      .put(file)
      .future
      .then((_) async {
    var exist = await FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .collection('ads_temp')
        .doc(dateTime.toString())
        .get();

    (exist.exists)
        ? FirebaseFirestore.instance
            .collection('users')
            .doc(phoneNumber)
            .collection('ads_temp')
            .doc(dateTime.toString())
            .update({'photo_url $index': path, 'photo_limit': total})
        : FirebaseFirestore.instance
            .collection('users')
            .doc(phoneNumber)
            .collection('ads_temp')
            .doc(dateTime.toString())
            .set({'photo_url $index': path, 'photo_limit': total});
  });
}

void uploadDelegateMultipleToStorage(
    DateTime dateTime, File file, int index, int total) async {
  var rng = new Random();
  var number = rng.nextInt(100);
  final path = 'delegate/$dateTime/$number';
  await fb
      .storage()
      .refFromURL('gs://nazarih-9bb05.appspot.com')
      .child(path)
      .put(file)
      .future
      .then((_) async {
    var exist = await FirebaseFirestore.instance
        .collection('delegate_temp')
        .doc(dateTime.toString())
        .get();

    (exist.exists)
        ? FirebaseFirestore.instance
            .collection('delegate_temp')
            .doc(dateTime.toString())
            .update({'photo_url $index': path, 'photo_limit': total})
        : FirebaseFirestore.instance
            .collection('delegate_temp')
            .doc(dateTime.toString())
            .set({'photo_url $index': path, 'photo_limit': total});
  });
}
