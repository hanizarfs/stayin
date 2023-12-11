import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditRoomPage extends StatefulWidget {
  final String roomId;

  EditRoomPage({required this.roomId});

  @override
  _EditRoomPageState createState() => _EditRoomPageState();
}

class _EditRoomPageState extends State<EditRoomPage> {
  bool _isWifiSelected = false;
  bool _isTelevisiSelected = false;
  bool _isACSelected = false;
  final TextEditingController _namaKamarController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load existing room data
    _loadRoomData();
  }

  void _loadRoomData() async {
    try {
      // Retrieve room data using roomId
      DocumentSnapshot roomSnapshot = await FirebaseFirestore.instance
          .collection('rooms')
          .doc(widget.roomId)
          .get();

      if (roomSnapshot.exists) {
        // Set existing data to controllers
        setState(() {
          _namaKamarController.text = roomSnapshot['nama_kamar'];
          _deskripsiController.text = roomSnapshot['deskripsi'];
          _hargaController.text = roomSnapshot['harga_malam'].toString();
          _isWifiSelected = roomSnapshot['wifi'] ?? false;
          _isTelevisiSelected = roomSnapshot['televisi'] ?? false;
          _isACSelected = roomSnapshot['ac'] ?? false;
        });
      } else {
        // Handle if room data doesn't exist
        print('Room data not found.');
      }
    } catch (error) {
      // Handle error if any
      print('Error loading room data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Kamar'),
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
            ElevatedButton(
              onPressed: () {
                // Update data kamar ke Firestore
                _updateRoomData();
              },
              child: Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateRoomData() async {
    // Get data from controllers
    String namaKamar = _namaKamarController.text;
    double hargaMalam = double.parse(_hargaController.text);
    String deskripsi = _deskripsiController.text;

    try {
      // Update room data in Firestore
      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(widget.roomId)
          .update({
        'nama_kamar': namaKamar,
        'harga_malam': hargaMalam,
        'deskripsi': deskripsi,
        'wifi': _isWifiSelected,
        'televisi': _isTelevisiSelected,
        'ac': _isACSelected,
      });

      // Display a Snackbar notification for successful update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data kamar berhasil diperbarui.'),
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate back to the previous screen after successful update
      Navigator.of(context).pop();
    } catch (error) {
      // Handle error if any
      print('Error updating room data: $error');

      // Display a Snackbar notification for update failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan. Data kamar gagal diperbarui.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
