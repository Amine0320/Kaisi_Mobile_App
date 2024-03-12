import 'package:flutter/material.dart';

class SplachView extends StatefulWidget {
  final AnimationController animationController;

  const SplachView({Key? key, required this.animationController})
      : super(key: key);

  @override
  _SplachViewState createState() => _SplachViewState();
}

class _SplachViewState extends State<SplachView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150.0, bottom: 8.0),
              child: Image.asset('assets/images/Introduction.jpg'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Kaisi Application",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 64, right: 64),
              child: Text(
                "Text",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 98,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 58,
                  padding: const EdgeInsets.only(
                    left: 56.0,
                    right: 56.0,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: const Color(0xff132137),
                  ),
                  child: const Text(
                    "Let's begin",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
