import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialIconButton extends StatelessWidget {
  final Widget icon;
  final String url;
  final Color color;
  final double size;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.url,
    this.color = Colors.deepPurple,
    this.size = 28,
  });

  void _launchUrl() async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: _launchUrl, icon: icon,iconSize: size,color: color,);
  }
}
