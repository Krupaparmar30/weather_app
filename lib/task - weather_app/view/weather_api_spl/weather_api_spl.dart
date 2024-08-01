
import 'package:flutter/material.dart';

class spleshPage extends StatelessWidget {
  const spleshPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Column(
        children: [
          SizedBox(
            height: 250,
          ),
          GestureDetector(
            onDoubleTap: () {
              Navigator.of(context).pushNamed('/home');
            },
            child: Center(
              child: Container(
                height: 210,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/sun2.gif'
                    )
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
