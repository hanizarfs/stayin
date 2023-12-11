// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class RoomListPage extends StatefulWidget {
//   @override
//   _RoomListPageState createState() => _RoomListPageState();
// }

// class _RoomListPageState extends State<RoomListPage> {
//   late Stream<QuerySnapshot> _roomsStream;

//   @override
//   void initState() {
//     super.initState();

//     // Mendapatkan UID pengguna yang sedang login
//     String? userUid = FirebaseAuth.instance.currentUser?.uid;

//     _roomsStream = FirebaseFirestore.instance
//         .collection('rooms')
//         .where('uid', isEqualTo: userUid)
//         .snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Room List'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _roomsStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           var rooms = snapshot.data!.docs;

//           if (rooms.isEmpty) {
//             return Center(
//               child: Text('No rooms available'),
//             );
//           }

//           return ListView.builder(
//             itemCount: rooms.length,
//             itemBuilder: (context, index) {
//               var room = rooms[index].data() as Map<String, dynamic>;
//               var roomName = room['nama_kamar'] ?? 'Nama Kamar Tidak Tersedia';

//               return ListTile(
//                 title: Text(roomName),
//                 // Tambahkan informasi tambahan sesuai kebutuhan.
//                 // Misalnya, tampilkan harga, kapasitas, dll.
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: RoomListPage(),
//   ));
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:stayin/screens/admin/room/edit.dart';

// class RoomListPage extends StatefulWidget {
//   @override
//   _RoomListPageState createState() => _RoomListPageState();
// }

// class _RoomListPageState extends State<RoomListPage> {
//   late Stream<QuerySnapshot> _roomsStream;

//   @override
//   void initState() {
//     super.initState();

//     // Mendapatkan UID pengguna yang sedang login
//     String? userUid = FirebaseAuth.instance.currentUser?.uid;

//     _roomsStream = FirebaseFirestore.instance
//         .collection('rooms')
//         .where('uid', isEqualTo: userUid)
//         .snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Room List'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _roomsStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           var rooms = snapshot.data!.docs;

//           if (rooms.isEmpty) {
//             return Center(
//               child: Text('No rooms available'),
//             );
//           }

//           return ListView.builder(
//             itemCount: rooms.length,
//             itemBuilder: (context, index) {
//               var room = rooms[index].data() as Map<String, dynamic>;
//               var roomName = room['nama_kamar'] ?? 'Nama Kamar Tidak Tersedia';

//               return ListTile(
//                 title: Text(roomName),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () {
//                         // Navigasi ke halaman edit
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 EditRoomPage(roomId: rooms[index].id),
//                           ),
//                         );
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () async {
//                         // Menampilkan konfirmasi hapus dan mengambil respons
//                         bool? deleteConfirmed =
//                             await _showDeleteConfirmationDialog(context);

//                         // Jika respons adalah true, hapus room
//                         if (deleteConfirmed == true) {
//                           FirebaseFirestore.instance
//                               .collection('rooms')
//                               .doc(rooms[index].id)
//                               .delete();

//                           // Menampilkan Snackbar bahwa item berhasil dihapus
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text('Room deleted successfully'),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // Fungsi untuk menampilkan dialog konfirmasi hapus
//   Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
//     return await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirmation'),
//           content: Text('Are you sure you want to delete this room?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//             ),
//             TextButton(
//               child: Text('Yes'),
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:stayin/screens/admin/room/edit.dart';

// class RoomListPage extends StatefulWidget {
//   @override
//   _RoomListPageState createState() => _RoomListPageState();
// }

// class _RoomListPageState extends State<RoomListPage> {
//   late Stream<QuerySnapshot> _roomsStream;

//   @override
//   void initState() {
//     super.initState();

//     // Mendapatkan UID pengguna yang sedang login
//     String? userUid = FirebaseAuth.instance.currentUser?.uid;

//     _roomsStream = FirebaseFirestore.instance
//         .collection('rooms')
//         .where('uid', isEqualTo: userUid)
//         .snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Room List'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _roomsStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           var rooms = snapshot.data!.docs;

//           if (rooms.isEmpty) {
//             return Center(
//               child: Text('No rooms available'),
//             );
//           }

//           return ListView.builder(
//             itemCount: rooms.length,
//             itemBuilder: (context, index) {
//               var room = rooms[index].data() as Map<String, dynamic>;
//               var roomName = room['nama_kamar'] ?? 'Nama Kamar Tidak Tersedia';
//               var imageUrl = room['image_url'] ?? '';

//               return ListTile(
//                 title: Text(roomName),
//                 leading: Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: imageUrl.isNotEmpty
//                             ? NetworkImage(imageUrl)
//                             : AssetImage(
//                                 'assets/placeholder_image.jpg') // You can use a placeholder image
//                         ),
//                   ),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () {
//                         // Navigasi ke halaman edit
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 EditRoomPage(roomId: rooms[index].id),
//                           ),
//                         );
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () async {
//                         // Menampilkan konfirmasi hapus dan mengambil respons
//                         bool? deleteConfirmed =
//                             await _showDeleteConfirmationDialog(context);

//                         // Jika respons adalah true, hapus room
//                         if (deleteConfirmed == true) {
//                           FirebaseFirestore.instance
//                               .collection('rooms')
//                               .doc(rooms[index].id)
//                               .delete();

//                           // Menampilkan Snackbar bahwa item berhasil dihapus
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text('Room deleted successfully'),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // Fungsi untuk menampilkan dialog konfirmasi hapus
//   Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
//     return await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirmation'),
//           content: Text('Are you sure you want to delete this room?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//             ),
//             TextButton(
//               child: Text('Yes'),
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:stayin/screens/admin/room/edit.dart';

// class RoomListPage extends StatefulWidget {
//   @override
//   _RoomListPageState createState() => _RoomListPageState();
// }

// class _RoomListPageState extends State<RoomListPage> {
//   late Stream<QuerySnapshot> _roomsStream;

//   @override
//   void initState() {
//     super.initState();

//     // Mendapatkan UID pengguna yang sedang login
//     String? userUid = FirebaseAuth.instance.currentUser?.uid;

//     _roomsStream = FirebaseFirestore.instance
//         .collection('rooms')
//         .where('uid', isEqualTo: userUid)
//         .snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Room List'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _roomsStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           var rooms = snapshot.data!.docs;

//           if (rooms.isEmpty) {
//             return Center(
//               child: Text('No rooms available'),
//             );
//           }

//           return ListView.builder(
//             itemCount: rooms.length,
//             itemBuilder: (context, index) {
//               var room = rooms[index].data() as Map<String, dynamic>;
//               var roomName = room['nama_kamar'] ?? 'Nama Kamar Tidak Tersedia';
//               var imageUrl = room['image_url'] ?? '';

//               return ListTile(
//                 title: Text(roomName),
//                 leading: Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: imageUrl.isNotEmpty
//                           ? NetworkImage(imageUrl) as ImageProvider<Object>
//                           : AssetImage('assets/placeholder_image.jpg'),
//                     ),
//                   ),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.edit),
//                       onPressed: () {
//                         // Navigasi ke halaman edit
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 EditRoomPage(roomId: rooms[index].id),
//                           ),
//                         );
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () async {
//                         // Menampilkan konfirmasi hapus dan mengambil respons
//                         bool? deleteConfirmed =
//                             await _showDeleteConfirmationDialog(context);

//                         // Jika respons adalah true, hapus room
//                         if (deleteConfirmed == true) {
//                           FirebaseFirestore.instance
//                               .collection('rooms')
//                               .doc(rooms[index].id)
//                               .delete();

//                           // Menampilkan Snackbar bahwa item berhasil dihapus
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text('Room deleted successfully'),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // Fungsi untuk menampilkan dialog konfirmasi hapus
//   Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
//     return await showDialog<bool>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirmation'),
//           content: Text('Are you sure you want to delete this room?'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//             ),
//             TextButton(
//               child: Text('Yes'),
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stayin/screens/admin/room/edit.dart';

class RoomListPage extends StatefulWidget {
  @override
  _RoomListPageState createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  late Stream<QuerySnapshot> _roomsStream;

  get documentSnapshot => null;

  @override
  void initState() {
    super.initState();

    // Get the UID of the currently logged-in user
    String? userUid = FirebaseAuth.instance.currentUser?.uid;

    _roomsStream = FirebaseFirestore.instance
        .collection('rooms')
        .where('uid', isEqualTo: userUid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _roomsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          var rooms = snapshot.data!.docs;

          if (rooms.isEmpty) {
            return Center(
              child: Text('No rooms available'),
            );
          }

          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              var room = rooms[index].data() as Map<String, dynamic>;
              var roomName = room['nama_kamar'] ?? 'Nama Kamar Tidak Tersedia';
              var image = room['image_url'] ?? 'Nama Kamar Tidak Tersedia';

              return ListTile(
                title: Text(roomName),
                subtitle: Text(image),
                // leading: Image.network(
                //   documentSnapshot['image_url'] ?? '',
                //   width: 50,
                //   height: 50,
                //   fit: BoxFit.cover,
                // ),
                leading: room['image_url'] != null
                    ? Image.network(
                        room['image_url']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error');
                          print(stackTrace);
                          return Icon(Icons.error); // Display an error icon
                        },
                      )
                    : Icon(Icons.image_not_supported),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navigate to the edit page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditRoomPage(roomId: rooms[index].id),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        // Show delete confirmation dialog and get response
                        bool? deleteConfirmed =
                            await _showDeleteConfirmationDialog(context);

                        // If the response is true, delete the room
                        if (deleteConfirmed == true) {
                          FirebaseFirestore.instance
                              .collection('rooms')
                              .doc(rooms[index].id)
                              .delete();

                          // Show a Snackbar that the item has been deleted successfully
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Room deleted successfully'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Function to show the delete confirmation dialog
  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete this room?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
