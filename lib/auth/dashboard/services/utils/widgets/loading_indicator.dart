import 'package:flutter/material.dart';
import 'package:mini_taskhub/app/theme.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;
  final Color color;
  final double size;

  const LoadingIndicator({
    super.key,
    this.message,
    this.color = AppTheme.primaryColor,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size,
            width: size,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(color),
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: AppTheme.captionStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
