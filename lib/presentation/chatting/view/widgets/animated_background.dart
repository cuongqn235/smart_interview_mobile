import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _animations.asMap().entries.map((entry) {
        int index = entry.key;
        Animation<Offset> animation = entry.value;

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Positioned(
              left: MediaQuery.of(context).size.width * animation.value.dx,
              top: MediaQuery.of(context).size.height * animation.value.dy,
              child: Container(
                width: 120 + (index * 20),
                height: 120 + (index * 20),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      [Colors.purple, Colors.blue, Colors.cyan][index]
                          .withOpacity(0.2),
                      [Colors.purple, Colors.blue, Colors.cyan][index]
                          .withOpacity(0.0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: Duration(seconds: 8 + index * 2),
        vsync: this,
      ),
    );

    _animations = _controllers.asMap().entries.map((entry) {
      int index = entry.key;
      AnimationController controller = entry.value;

      return Tween<Offset>(
        begin: Offset(
          (index % 2 == 0) ? -0.2 : 1.2,
          0.2 + (index * 0.3),
        ),
        end: Offset(
          (index % 2 == 0) ? 1.2 : -0.2,
          0.8 - (index * 0.2),
        ),
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ));
    }).toList();

    for (var controller in _controllers) {
      controller.repeat(reverse: true);
    }
  }
}
