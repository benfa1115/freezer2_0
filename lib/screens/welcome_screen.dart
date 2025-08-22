import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo placeholder
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [cs.primary, cs.tertiary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.ac_unit_rounded,
                        size: 56,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'MyFreezer',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Track what’s in your freezer.\nWaste less. Save more.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // CTA buttons
                  PrimaryButton(
                    label: 'Continue as guest (offline)',
                    icon: Icons.offline_bolt_outlined,
                    onPressed: () => context.push('/scan'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => context.push('/login'),
                    icon: const Icon(Icons.login),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('Log in / Sign up'),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: () {
                      // Placeholder for learn more / onboarding carousel
                      showAboutDialog(
                        context: context,
                        applicationName: 'MyFreezer',
                        applicationVersion: '2.0.0',
                        applicationIcon: const Icon(Icons.ac_unit_rounded),
                        children: const [
                          Text(
                            'Helps you manage freezer items, expiry reminders, and more.',
                          ),
                        ],
                      );
                    },
                    icon: const Icon(Icons.info_outline),
                    label: const Text('Learn more'),
                  ),
                  const SizedBox(height: 18),
                  // Small print
                  Opacity(
                    opacity: 0.6,
                    child: Text(
                      'By continuing you agree to the Terms and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
