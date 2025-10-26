import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  void _sendEmail(BuildContext context) async {
    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String message = _messageController.text.trim();

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'aronnoghosh049@gmail.com',
      queryParameters: {
        'subject': 'Message from $name',
        'body': message,
      },
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not open your email app. Please use the links in the Home section to contact me.',
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'An error occurred. Please use the links in the Home section to contact me.',
          ),
        ),
      );
    }
  }

  InputDecoration _inputDecoration(String label) {
    final baseBorderColor = Theme.of(context).colorScheme.primary.withOpacity(0.2);

    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Theme.of(context).cardColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: baseBorderColor, width: 1.2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: baseBorderColor, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  BoxDecoration _commonBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardColor,
      border: Border.all(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
        width: 1.2,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColorDark = const Color(0x662B006B);
    final cardColorLight = const Color(0x130E0EFA);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(
            color: isDark
                ? Colors.deepPurple.shade400.withOpacity(0.8)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        color: isDark ? cardColorDark : cardColorLight,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Me',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: [
                    const TextSpan(
                      text:
                      "Thanks for visiting! I'd love to hear from you. Whether it’s about a project, opportunity, or just a hello — feel free to reach out!\n",
                    ),
                    TextSpan(
                      text:
                      "All my social links and email are available in the Home section too.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              isWide
                  ? IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        decoration: _commonBoxDecoration(context),
                        padding: const EdgeInsets.all(24),
                        child: _buildForm(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      flex: 2,
                      child: Container(
                        decoration: _commonBoxDecoration(context),
                        padding: const EdgeInsets.all(12),
                        child: Center(
                          child: Lottie.asset('assets/animation.json'),
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: _commonBoxDecoration(context),
                    padding: const EdgeInsets.all(24),
                    child: _buildForm(),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: _commonBoxDecoration(context),
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Lottie.asset('assets/animation.json', height: 200),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: _inputDecoration('Your Name'),
            validator: (value) =>
            value == null || value.trim().isEmpty ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: _inputDecoration('Your Email'),
            validator: (value) =>
            value == null || !value.contains('@') ? 'Enter a valid email' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _messageController,
            maxLines: 5,
            decoration: _inputDecoration('Your Message'),
            validator: (value) =>
            value == null || value.trim().isEmpty ? 'Please enter a message' : null,
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _sendEmail(context);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.send),
              label: const Text('Send Message'),
            ),
          ),
        ],
      ),
    );
  }
}
