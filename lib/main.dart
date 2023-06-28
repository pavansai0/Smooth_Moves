import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smooth_moves/screens/seller_login.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smooth_Moves',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Smooth_Moves'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            // Wrap the Column with Builder widget
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SellerLoginScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 100,
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          'Seller',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellerLoginScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 100,
                      color: Colors.green,
                      child: const Center(
                        child: Text(
                          'Buyer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
