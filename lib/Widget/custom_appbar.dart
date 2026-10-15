import 'package:flutter/material.dart';
import 'package:purohitset_app/Widget/rps_custom_painter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final double appBarHeight;

  final bool showLogo;
  final bool showMenu;
  final bool showNotification;
  final bool centerTitle;

  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;

  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.appBarHeight = 120,
    this.showLogo = true,
    this.showMenu = false,
    this.showNotification = false,
    this.centerTitle = false,
    this.onMenuTap,
    this.onNotificationTap,
    this.leading,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: appBarHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipPath(
            clipper: RPSCustomClipper(),
            child: Image.asset(
              'Assets/Images/app_bar_image.png',
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12, right: 8, bottom: 24),
            child: Row(
              children: [
                if (leading != null)
                  leading!
                else if (showLogo)
                  Image.asset(
                    'Assets/Images/purohit-setu-logo.webp',
                    height: 60,
                    width: 60,
                    fit: BoxFit.contain,
                  ),

                if (leading != null || showLogo) const SizedBox(width: 8),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: centerTitle
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        textAlign: centerTitle
                            ? TextAlign.center
                            : TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          textAlign: centerTitle
                              ? TextAlign.center
                              : TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                if (actions != null) ...actions!,

                if (showMenu)
                  IconButton(
                    onPressed:
                        onMenuTap ??
                        () {
                          Scaffold.of(context).openDrawer();
                        },
                    icon: const Icon(Icons.menu, color: Colors.white, size: 26),
                    tooltip: 'Open Menu',
                  ),

                if (showNotification)
                  IconButton(
                    onPressed: onNotificationTap,
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 26,
                    ),
                    tooltip: 'Notifications',
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
