import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:irfan_portfolio/views/portfolio_view.dart';

const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyC0KXXoneNFwrGyaJidHFvUzGJt4HK-NUo",
  authDomain: "irfan-farzand.firebaseapp.com",
  projectId: "irfan-farzand",
  storageBucket: "irfan-farzand.firebasestorage.app",
  messagingSenderId: "271609308380",
  appId: "1:271609308380:web:52bd678446c1e88b81c019",
  measurementId: "G-WCTYVKHTVP",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);  // Initialize Firebase with FirebaseOptions
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Irfan Farzand',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PortfolioView(),
    );
  }
}
