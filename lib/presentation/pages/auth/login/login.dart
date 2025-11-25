import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:star_book_refactory/presentation/pages/auth/login/widgets/social_login_button.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go('/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red.shade400,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF16213E),
                  Color(0xFF0F3460),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    const Spacer(flex: 2),

                    // 로고
                    Container(
                      width: 100,
                      height: 100,
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
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 앱 이름
                    const Text(
                      'StarBook',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // 슬로건
                    Text(
                      '당신의 하루를 별처럼 빛나게',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),

                    const Spacer(flex: 2),

                    // 로딩 중
                    if (isLoading)
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    else ...[
                      // Facebook 로그인 버튼
                      SocialLoginButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(FacebookSignInRequested());
                        },
                        icon: Icons.facebook,
                        label: 'Facebook으로 계속하기',
                        backgroundColor: const Color(0xFF1877F2),
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 16),

                      // Google 로그인 버튼
                      // SocialLoginButton(
                      //   onPressed: () {
                      //     context.read<AuthBloc>().add(GoogleSignInRequested());
                      //   },
                      //   iconWidget: Image.network(
                      //     'https://www.google.com/favicon.ico',
                      //     width: 24,
                      //     height: 24,
                      //     errorBuilder: (context, error, stackTrace) {
                      //       return const Icon(Icons.g_mobiledata, size: 24);
                      //     },
                      //   ),
                      //   label: 'Google로 계속하기',
                      //   backgroundColor: Colors.white,
                      //   textColor: Colors.black87,
                      // ),
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '또는',
                              style: TextStyle(color: Colors.white.withOpacity(0.5)),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SocialLoginButton(
                        onPressed: () {
                          context.go('/email-login');
                        },
                        icon: Icons.email_outlined,
                        label: '이메일로 계속하기',
                        backgroundColor: const Color(0xFF533483),
                        textColor: Colors.white,
                      ),
                    ],

                    const Spacer(flex: 1),

                    // 하단 안내 문구
                    Text(
                      '로그인하면 서비스 이용약관 및\n개인정보 처리방침에 동의하게 됩니다.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.5),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

