import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/app_settings.dart';
import '../home_screens/tabs_screen.dart';
import '../services/auth_service.dart';
import 'onboarding_screens.dart';

/// The brand moment: the BlueSpeak head, a live sound wave and one wordmark.
/// Always dark, whatever theme the app is using.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static const _violet = Color(0xFF6C63FF);
  static const _cyan = Color(0xFF22D3EE);

  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..forward();

  late final AnimationController _loop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..repeat();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2900), _goNext);
  }

  void _goNext() {
    if (!mounted) return;
    final user = AuthService.currentUser;
    final settings = AppSettings.instance;
    final Widget next;
    if (user != null) {
      next = CustomTabBarScreen(
        userName: user.displayName ?? '',
        userEmail: user.email ?? '',
      );
    } else if (settings.isGuest) {
      next = CustomTabBarScreen(userName: settings.guestName, userEmail: '');
    } else {
      next = const OnboardingScreen();
    }
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        pageBuilder: (_, __, ___) => next,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  void dispose() {
    _intro.dispose();
    _loop.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050611),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF050611), Color(0xFF0A0E2B), Color(0xFF0D1240)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: AnimatedBuilder(
              animation: Listenable.merge([_intro, _loop]),
              builder: (context, _) {
                final intro = Curves.easeOutCubic.transform(_intro.value);
                final textIn = Curves.easeOut.transform(
                  ((_intro.value - 0.35) / 0.65).clamp(0.0, 1.0),
                );
                final pulse = 0.5 + 0.5 * math.sin(_loop.value * 2 * math.pi);
                final float = math.sin(_loop.value * 2 * math.pi) * 4;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 280,
                      height: 300,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // soft glow behind the head
                          Container(
                            width: 250 + 20 * pulse,
                            height: 250 + 20 * pulse,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  _violet.withValues(
                                    alpha: (0.34 + 0.12 * pulse) * intro,
                                  ),
                                  _violet.withValues(alpha: 0),
                                ],
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, float + (1 - intro) * 18),
                            child: Transform.scale(
                              scale: 0.86 + 0.14 * intro,
                              child: Opacity(
                                opacity: intro,
                                child: Image.asset(
                                  'assets/images/bluespeak_mark.png',
                                  height: 250,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    _SoundWave(
                      progress: _loop.value,
                      strength: textIn,
                      from: _violet,
                      to: _cyan,
                    ),
                    const SizedBox(height: 26),
                    Opacity(
                      opacity: textIn,
                      child: Transform.translate(
                        offset: Offset(0, (1 - textIn) * 14),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              'Blue Speak',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.4,
                              ),
                            ),
                            const SizedBox(width: 10),
                            ShaderMask(
                              shaderCallback: (rect) => const LinearGradient(
                                colors: [_violet, _cyan],
                              ).createShader(rect),
                              child: Text(
                                'AI',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 56,
                                  fontWeight: FontWeight.w900,
                                  height: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// A row of bars that move like a voice, a hint of the "speak" in BlueSpeak.
class _SoundWave extends StatelessWidget {
  const _SoundWave({
    required this.progress,
    required this.strength,
    required this.from,
    required this.to,
  });

  final double progress;
  final double strength;
  final Color from;
  final Color to;

  static const _bars = 11;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(_bars, (i) {
          final t = i / (_bars - 1);
          // taller in the middle, each bar slightly out of phase
          final envelope = 0.35 + 0.65 * math.sin(t * math.pi);
          final wave =
              0.5 + 0.5 * math.sin((progress * 2 + i * 0.13) * 2 * math.pi);
          final h = 6 + 38 * envelope * wave * strength;
          return Container(
            width: 5,
            height: h,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Color.lerp(from, to, t)!.withValues(alpha: 0.4 + 0.6 * strength),
            ),
          );
        }),
      ),
    );
  }
}
