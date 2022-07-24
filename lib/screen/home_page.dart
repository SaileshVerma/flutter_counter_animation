import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int count = 5;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.forward();

    _controller.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          count--;
        });
        _controller.forward();
      }
    });
    _controller.addListener(() {
      if (count == 0) {
        setState(() {
          _controller.stop();
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Useless"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Curves.ease,
            ),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: _controller,
                curve: Curves.easeIn,
              ),
              child: Center(
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
