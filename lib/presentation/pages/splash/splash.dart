import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:star_book_refactory/services/auth/bloc/auth_bloc.dart';
import 'package:star_book_refactory/services/auth/bloc/auth_state.dart';
import 'package:star_book_refactory/services/auth/bloc/auth_event.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();

    // 애니메이션 후 로그인 상태 체크
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        context.read<AuthBloc>().add(AuthCheckRequested());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/home');
        } else if (state is AuthUnauthenticated) {
          context.go('/login');
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1A1A2E),  // 어두운 남색
                Color(0xFF16213E),  // 진한 남색
                Color(0xFF0F3460),  // 중간 남색
              ],
            ),
          ),
          child: Stack(
            children: [
              // 별 배경
              const _StarryBackground(),

              // 메인 콘텐츠
              Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 별 아이콘
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFE94560),
                                    Color(0xFF533483),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFE94560).withOpacity(0.4),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.auto_stories_rounded,
                                size: 56,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 32),

                            // 앱 이름
                            const Text(
                              'StarBook',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // 슬로건
                            Text(
                              '당신의 하루를 별처럼 빛나게',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.7),
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 48),

                            // 로딩 인디케이터
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// 별 배경 위젯
class _StarryBackground extends StatelessWidget {
  const _StarryBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StarPainter(),
      size: Size.infinite,
    );
  }
}

class _StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    // 고정된 별 위치들 (랜덤 대신 고정값 사용)
    final stars = [
      _Star(0.1, 0.1, 1.5),
      _Star(0.85, 0.08, 2.0),
      _Star(0.5, 0.15, 1.0),
      _Star(0.25, 0.25, 1.8),
      _Star(0.75, 0.22, 1.2),
      _Star(0.15, 0.4, 2.2),
      _Star(0.9, 0.35, 1.5),
      _Star(0.4, 0.45, 1.0),
      _Star(0.65, 0.5, 1.8),
      _Star(0.08, 0.6, 1.5),
      _Star(0.95, 0.58, 2.0),
      _Star(0.3, 0.65, 1.2),
      _Star(0.55, 0.7, 1.5),
      _Star(0.8, 0.72, 1.0),
      _Star(0.2, 0.8, 2.0),
      _Star(0.45, 0.85, 1.5),
      _Star(0.7, 0.88, 1.8),
      _Star(0.12, 0.92, 1.2),
      _Star(0.88, 0.95, 1.5),
      _Star(0.35, 0.3, 1.0),
      _Star(0.6, 0.35, 2.0),
      _Star(0.05, 0.75, 1.5),
      _Star(0.92, 0.78, 1.2),
      _Star(0.48, 0.55, 1.8),
    ];

    for (final star in stars) {
      paint.color = Colors.white.withOpacity(star.radius > 1.5 ? 0.8 : 0.5);
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Star {
  final double x;
  final double y;
  final double radius;

  _Star(this.x, this.y, this.radius);
}