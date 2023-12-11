import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stayin/auth.dart';
import 'package:stayin/screens/admin/profile/index.dart';
import 'package:stayin/screens/admin/room/add.dart';
import 'package:stayin/screens/admin/room/index.dart';
// import 'rental/index.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

// class _AdminHomePageState extends State<AdminHomePage> {
//   int _currentIndex = 0;

//   final User? user = Auth().currentUser;

//   Future<void> signOut() async {
//     await Auth().signOut();
//   }

//   Widget _title() {
//     return const Text('STAYIN');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _title(),
//       ),
//       body: _getPage(_currentIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.list),
//             label: 'Kamar',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Hotel',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getPage(int index) {
//     switch (index) {
//       case 0:
//         return HomeTabPage();
//       // case 1:
//       //   return RentedTabPage();
//       case 2:
//         return AdminProfilePage(Admin: user);
//       default:
//         return Container();
//     }
//   }
// }

// class HomeTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text('Home Admin'),
//           SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AddRoomPage()),
//               );
//             },
//             child: Text('Tambah Kamar'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class RoomsTabPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         // child: Text('Rented Tab Page'),
//         child: RoomListPage(),
//       ),
//     );
//   }
// }

class _AdminHomePageState extends State<AdminHomePage> {
  int _currentIndex = 0;

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('STAYIN');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: _getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Kamar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Hotel',
          ),
        ],
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeTabPage();
      case 1:
        return RoomsTabPage(); // Ubah ke RoomsTabPage
      case 2:
        return AdminProfilePage(Admin: user);
      default:
        return Container();
    }
  }
}

class RoomsTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RoomListPage(),
      ),
    );
  }
}

class HomeTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home Admin'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddRoomPage()),
              );
            },
            child: Text('Tambah Kamar'),
          ),
        ],
      ),
    );
  }
}
