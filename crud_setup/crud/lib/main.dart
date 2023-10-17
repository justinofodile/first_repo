import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firebase/cloud_firestore.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Construction App Admin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final feedbackStream =
      FirebaseFirestore.instance.collection("Feedback").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.blueGrey,
      body: StreamBuilder(
        stream: feedbackStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Connection Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text(
                "Loading......",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          var docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return Card(
                  color: Colors.blue[100],
                  child: ListTile(
                    leading: const Icon(Icons.app_registration_outlined),
                    title: Text(docs[index]['persName']),
                    subtitle: Text(docs[index]['persMessage']),
                    trailing: Column(
                      children: [
                        // Text(docs[index]['persEmail']),
                        Text(docs[index]['persLocation']),
                      ],
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}

// Center(
//           child: Container(
//             width: 300,
//             height: 300,
//             decoration: BoxDecoration(
//               border: Border.all(width: 5, color: Colors.green),
//               shape: BoxShape.circle,
//             ),
//             child: const Center(
//               child: Text(
//                 "Success",
//                 style: TextStyle(
//                   fontSize: 50,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green,
//                 ),
//               ),
//             ),
//           ),
//         )