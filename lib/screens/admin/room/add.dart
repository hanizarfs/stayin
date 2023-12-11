// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class AddRoomPage extends StatefulWidget {
//   @override
//   _AddRoomPageState createState() => _AddRoomPageState();
// }

// class _AddRoomPageState extends State<AddRoomPage> {
//   bool _isWifiSelected = false;
//   bool _isTelevisiSelected = false;
//   bool _isACSelected = false;
//   final TextEditingController _namaKamarController = TextEditingController();
//   final TextEditingController _hargaController = TextEditingController();
//   final TextEditingController _deskripsiController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tambah Kamar'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               decoration: InputDecoration(labelText: 'Nama Kamar'),
//               controller: _namaKamarController,
//             ),
//             SizedBox(height: 16),
//             TextFormField(
//               decoration: InputDecoration(labelText: 'Deskripsi Kamar'),
//               maxLines: 3,
//               controller: _deskripsiController,
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Harga per Malam'),
//               keyboardType: TextInputType.numberWithOptions(decimal: true),
//               controller: _hargaController,
//             ),
//             SizedBox(height: 16),
//             CheckboxListTile(
//               title: Text('Wi-Fi'),
//               value: _isWifiSelected,
//               onChanged: (value) {
//                 setState(() {
//                   _isWifiSelected = value ?? false;
//                 });
//               },
//             ),
//             CheckboxListTile(
//               title: Text('Televisi'),
//               value: _isTelevisiSelected,
//               onChanged: (value) {
//                 setState(() {
//                   _isTelevisiSelected = value ?? false;
//                 });
//               },
//             ),
//             CheckboxListTile(
//               title: Text('AC'),
//               value: _isACSelected,
//               onChanged: (value) {
//                 setState(() {
//                   _isACSelected = value ?? false;
//                 });
//               },
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Menyimpan data kamar ke Firestore
//                 _saveRoomData();
//               },
//               child: Text('Simpan'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _saveRoomData() async {
//     // Mendapatkan data dari controller atau variabel state
//     String namaKamar = _namaKamarController.text;
//     double hargaMalam = double.parse(_hargaController.text);
//     String deskripsi = _deskripsiController.text;

//     // Mendapatkan UID pengguna yang sedang login
//     String? userUid = FirebaseAuth.instance.currentUser?.uid;

//     if (userUid != null) {
//       // Membuat map data kamar
//       Map<String, dynamic> roomData = {
//         'uid': userUid,
//         'nama_kamar': namaKamar,
//         'harga_malam': hargaMalam,
//         'deskripsi': deskripsi,
//         'wifi': _isWifiSelected,
//         'televisi': _isTelevisiSelected,
//         'ac': _isACSelected,
//       };

//       // Menyimpan data kamar ke Firestore
//       try {
//         await FirebaseFirestore.instance.collection('rooms').add(roomData);

//         // Menampilkan Snackbar notifikasi jika berhasil disimpan
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Data kamar berhasil disimpan.'),
//             duration: Duration(seconds: 2),
//           ),
//         );

//         // Kembali ke halaman sebelumnya setelah berhasil disimpan
//         Navigator.of(context).pop();
//       } catch (error) {
//         print('Error: $error');

//         // Menampilkan Snackbar notifikasi jika gagal disimpan
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Terjadi kesalahan. Data kamar gagal disimpan.'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } else {
//       print('User belum login.');
//       // Handle jika user belum login
//     }
//   }
// }

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddRoomPage extends StatefulWidget {
  @override
  _AddRoomPageState createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  bool _isWifiSelected = false;
  bool _isTelevisiSelected = false;
  bool _isACSelected = false;
  final TextEditingController _namaKamarController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  Uint8List? _imageData;
  bool _pickingImage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Kamar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Nama Kamar'),
              controller: _namaKamarController,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(labelText: 'Deskripsi Kamar'),
              maxLines: 3,
              controller: _deskripsiController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Harga per Malam'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _hargaController,
            ),
            SizedBox(height: 16),
            CheckboxListTile(
              title: Text('Wi-Fi'),
              value: _isWifiSelected,
              onChanged: (value) {
                setState(() {
                  _isWifiSelected = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Televisi'),
              value: _isTelevisiSelected,
              onChanged: (value) {
                setState(() {
                  _isTelevisiSelected = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('AC'),
              value: _isACSelected,
              onChanged: (value) {
                setState(() {
                  _isACSelected = value ?? false;
                });
              },
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: _imageData != null
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.memory(
                          _imageData!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        IconButton(
                          onPressed: () {
                            pickImage();
                          },
                          icon: Icon(
                            Icons.change_circle_outlined,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                      ],
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.upload,
                        color: Colors.blue,
                        size: 45,
                      ),
                    ),
            ),
            SizedBox(height: 16),
            _pickingImage
                ? LinearProgressIndicator(
                    color: Colors.blue,
                  )
                : Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Menyimpan data kamar ke Firestore
                _saveRoomData();
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveRoomData() async {
    // Mendapatkan data dari controller atau variabel state
    String namaKamar = _namaKamarController.text;
    double hargaMalam = double.parse(_hargaController.text);
    String deskripsi = _deskripsiController.text;

    // Mendapatkan UID pengguna yang sedang login
    String? userUid = FirebaseAuth.instance.currentUser?.uid;

    if (userUid != null) {
      // Membuat map data kamar
      Map<String, dynamic> roomData = {
        'uid': userUid,
        'nama_kamar': namaKamar,
        'harga_malam': hargaMalam,
        'deskripsi': deskripsi,
        'wifi': _isWifiSelected,
        'televisi': _isTelevisiSelected,
        'ac': _isACSelected,
      };

      // Menyimpan data kamar ke Firestore
      try {
        // Add the image data to the roomData
        if (_imageData != null) {
          String imageUrl = await uploadImageToStorage(_imageData!, namaKamar);
          roomData['image_url'] = imageUrl;
        }

        await FirebaseFirestore.instance.collection('rooms').add(roomData);

        // Menampilkan Snackbar notifikasi jika berhasil disimpan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Data kamar berhasil disimpan.'),
            duration: Duration(seconds: 2),
          ),
        );

        // Kembali ke halaman sebelumnya setelah berhasil disimpan
        Navigator.of(context).pop();
      } catch (error) {
        print('Error: $error');

        // Menampilkan Snackbar notifikasi jika gagal disimpan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan. Data kamar gagal disimpan.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      print('User belum login.');
      // Handle jika user belum login
    }
  }

  void pickImage() async {
    setState(() {
      _pickingImage = true;
    });

    ImagePicker _picker = ImagePicker();

    // Select image from the gallery
    XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      var data = await file.readAsBytes();

      setState(() {
        _imageData = data;
      });
    }

    setState(() {
      _pickingImage = false;
    });
  }

  Future<String> uploadImageToStorage(
      Uint8List image_data, String namaKamar) async {
    String imageName =
        'room_image_${DateTime.now().millisecondsSinceEpoch}_$namaKamar.jpg';

    Reference ref =
        FirebaseStorage.instance.ref().child("room_images").child(imageName);
    UploadTask uploadTask = ref.putData(image_data);

    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();

    return url;
  }
}
