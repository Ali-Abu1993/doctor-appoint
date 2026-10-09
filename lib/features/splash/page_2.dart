import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor Info")),
      body: Column(
        children: [
          AnimatedOpacity(
            opacity: 0.4, duration: Duration(milliseconds: 1000),
            child: AnimatedContainer(width: double.infinity,height: 100,curve: Curves.easeInBack,
              duration: Duration(milliseconds: 800),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),

              color: Colors.green
            ),
            ),
          )
        ],
      ),
    );

  }
}
