import 'dart:math' as math;

import 'package:flutter/material.dart';

class Particle {
  double x, y, vx, vy;
  int life, maxLife;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.life,
    required this.maxLife,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;

  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (var particle in particles) {
      final alpha = 1.0 - (particle.life / particle.maxLife);
      final particleSize = 2 + math.sin(particle.life * 0.1) * 1;

      paint.color = Colors.blue.withOpacity(alpha * 0.3);
      canvas.drawCircle(
        Offset(particle.x, particle.y),
        particleSize,
        paint,
      );

      // Draw connections to nearby particles
      for (var other in particles) {
        final dx = particle.x - other.x;
        final dy = particle.y - other.y;
        final distance = math.sqrt(dx * dx + dy * dy);

        if (distance < 100) {
          paint.color =
              Colors.blue.withOpacity((1 - distance / 100) * alpha * 0.1);
          paint.strokeWidth = 1;
          canvas.drawLine(
            Offset(particle.x, particle.y),
            Offset(other.x, other.y),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ParticleSystem extends StatefulWidget {
  const ParticleSystem({Key? key}) : super(key: key);

  @override
  State<ParticleSystem> createState() => _ParticleSystemState();
}

class _ParticleSystemState extends State<ParticleSystem>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: ParticlePainter(_particles),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    )..repeat();

    _initializeParticles();
    _controller.addListener(_updateParticles);
  }

  void _initializeParticles() {
    final random = math.Random();
    for (int i = 0; i < 30; i++) {
      _particles.add(Particle(
        x: random.nextDouble() * 400,
        y: random.nextDouble() * 800,
        vx: (random.nextDouble() - 0.5) * 2,
        vy: (random.nextDouble() - 0.5) * 2,
        life: 0,
        maxLife: 100 + random.nextInt(100),
      ));
    }
  }

  void _updateParticles() {
    setState(() {
      for (var particle in _particles) {
        particle.x += particle.vx;
        particle.y += particle.vy;
        particle.life++;

        // Wrap around screen
        if (particle.x < 0) particle.x = 400;
        if (particle.x > 400) particle.x = 0;
        if (particle.y < 0) particle.y = 800;
        if (particle.y > 800) particle.y = 0;
      }

      // Remove old particles and add new ones
      _particles.removeWhere((p) => p.life > p.maxLife);

      if (_particles.length < 30 && math.Random().nextDouble() > 0.95) {
        final random = math.Random();
        _particles.add(Particle(
          x: random.nextDouble() * 400,
          y: random.nextDouble() * 800,
          vx: (random.nextDouble() - 0.5) * 2,
          vy: (random.nextDouble() - 0.5) * 2,
          life: 0,
          maxLife: 100 + random.nextInt(100),
        ));
      }
    });
  }
}
