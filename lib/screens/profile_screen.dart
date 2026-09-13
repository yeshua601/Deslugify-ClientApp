import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'theme_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _selectProfilePicture() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () async {
                  Navigator.pop(context);

                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 85,
                  );

                  if (image != null) {
                    setState(() {
                      _profileImage = File(image.path);
                    });
                  }
                },
              ),

              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);

                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 85,
                  );

                  if (image != null) {
                    setState(() {
                      _profileImage = File(image.path);
                    });
                  }
                },
              ),

              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark
        ? const Color(0xFF0F1410)
        : const Color(0xFFF8FAF3);

    final card = isDark
        ? const Color(0xFF1A211C)
        : Colors.white;

    final text = isDark
        ? const Color(0xFFE8EBE6)
        : const Color(0xFF003D1A);

    final muted = isDark
        ? const Color(0xFF9AA39A)
        : const Color(0xFF707970);

    final border = isDark
        ? const Color(0xFF2A332C)
        : const Color(0xFFE8EBE6);

    final accent = isDark
        ? const Color(0xFF94F4AD)
        : const Color(0xFF006D38);

    final iconBg = isDark
        ? const Color(0xFF94F4AD).withValues(alpha: 0.15)
        : const Color(0xFF94F4AD).withValues(alpha: 0.25);

    return Scaffold(
      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: isDark
            ? const Color(0xFF1A211C)
            : Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        title: Row(
          children: [
            Icon(Icons.eco, color: accent, size: 26),
            const SizedBox(width: 10),
            Text(
              "Deslugify",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark
                    ? accent
                    : const Color(0xFF003D1A),
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: isDark
                  ? accent
                  : const Color(0xFF003D1A),
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),

        child: Column(
          children: [
            _buildProfileHeader(text, muted),

            const SizedBox(height: 28),

            _buildContactInfo(
              card,
              border,
              text,
              muted,
              accent,
              iconBg,
            ),

            const SizedBox(height: 28),

            _buildSettingsSection(
              context,
              card,
              border,
              text,
              muted,
              accent,
            ),

            const SizedBox(height: 32),

            _buildLogoutButton(context),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomNav(
        context,
        isDark,
        card,
      ),
    );
  }

  Widget _buildProfileHeader(Color text, Color muted) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            GestureDetector(
              onTap: _selectProfilePicture,

              child: Container(
                width: 120,
                height: 120,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),

                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 16,
                    ),
                  ],
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),

                  child: _profileImage != null
                      ? Image.file(
                          _profileImage!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: isDark
                              ? const Color(0xFF2A332C)
                              : const Color(0xFFE1E3DD),

                          child: Icon(
                            Icons.person,
                            size: 55,
                            color: isDark
                                ? const Color(0xFF94F4AD)
                                : const Color(0xFF006D38),
                          ),
                        ),
                ),
              ),
            ),

            Positioned(
              bottom: 2,
              right: 2,

              child: GestureDetector(
                onTap: _selectProfilePicture,

                child: Container(
                  padding: const EdgeInsets.all(7),

                  decoration: BoxDecoration(
                    color: const Color(0xFF006D38),
                    borderRadius: BorderRadius.circular(10),

                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),

                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Text(
          "Julian Thorne",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: text,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          "Senior Urban Ecologist",
          style: TextStyle(
            fontSize: 15,
            color: muted,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(
    Color card,
    Color border,
    Color text,
    Color muted,
    Color accent,
    Color iconBg,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _contactCard(
                Icons.email_outlined,
                "Email",
                "j.thorne@ecocorp.city",
                card,
                border,
                text,
                muted,
                accent,
                iconBg,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _contactCard(
                Icons.phone_outlined,
                "Phone",
                "+1 (555) 012-3456",
                card,
                border,
                text,
                muted,
                accent,
                iconBg,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        _contactCard(
          Icons.location_on_outlined,
          "Home Address",
          "Emerald Skyway, Suite 402, Neo-Portland, OR",
          card,
          border,
          text,
          muted,
          accent,
          iconBg,
        ),
      ],
    );
  }

  Widget _contactCard(
    IconData icon,
    String label,
    String value,
    Color card,
    Color border,
    Color text,
    Color muted,
    Color accent,
    Color iconBg,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(
              icon,
              color: accent,
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: muted,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: text,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(
    BuildContext context,
    Color card,
    Color border,
    Color text,
    Color muted,
    Color accent,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),

          child: Text(
            "Account Settings",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: text,
            ),
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: border),
          ),

          child: Column(
            children: [
              _settingsTile(
                Icons.notifications_outlined,
                "Notification preferences",
                text: text,
                muted: muted,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/notification-preferences',
                  );
                },
              ),

              _divider(border),

              _settingsTile(
                Icons.lock_outline,
                "Security",
                subtitle: "Change Password & 2FA",
                text: text,
                muted: muted,
                onTap: () {
                  Navigator.pushNamed(context, '/security');
                },
              ),

              _divider(border),

              _settingsTile(
                Icons.palette_outlined,
                "App Theme",
                text: text,
                muted: muted,

                trailing: ValueListenableBuilder<ThemeMode>(
                  valueListenable: ThemeController.themeMode,

                  builder: (context, mode, _) {
                    final label = switch (mode) {
                      ThemeMode.dark => 'Dark Mode',
                      ThemeMode.system => 'System',
                      _ => 'Light Mode',
                    };

                    return Text(
                      label,
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    );
                  },
                ),

                onTap: () => _showThemeDialog(context),
              ),

              _divider(border),

              _settingsTile(
                Icons.visibility_outlined,
                "Privacy",
                text: text,
                muted: muted,
                onTap: () {
                  Navigator.pushNamed(context, '/privacy');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,

      builder: (ctx) => AlertDialog(
        title: const Text('App Theme'),

        content: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            ListTile(
              leading: const Icon(
                Icons.light_mode,
                color: Color(0xFF006D38),
              ),

              title: const Text('Light Mode'),

              onTap: () {
                ThemeController.setLight();
                Navigator.pop(ctx);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Light Mode selected'),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.dark_mode,
                color: Color(0xFF006D38),
              ),

              title: const Text('Dark Mode'),

              onTap: () {
                ThemeController.setDark();
                Navigator.pop(ctx);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Dark Mode selected'),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.brightness_auto,
                color: Color(0xFF006D38),
              ),

              title: const Text('System Default'),

              onTap: () {
                ThemeController.setSystem();
                Navigator.pop(ctx);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('System Default selected'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsTile(
    IconData icon,
    String title, {
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    required Color text,
    required Color muted,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 2,
      ),

      leading: Icon(icon, color: muted),

      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: text,
        ),
      ),

      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: muted,
              ),
            )
          : null,

      trailing: trailing ?? Icon(
        Icons.chevron_right,
        color: muted,
      ),

      onTap: onTap,
    );
  }

  Widget _divider(Color border) {
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: border,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: OutlinedButton.icon(
        onPressed: () {
          showDialog(
            context: context,

            builder: (ctx) => AlertDialog(
              title: const Text("Logout"),

              content: const Text(
                "Are you sure you want to logout?",
              ),

              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Cancel"),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                    );
                  },

                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      color: Color(0xFFBA1A1A),
                    ),
                  ),
                ),
              ],
            ),
          );
        },

        icon: const Icon(
          Icons.logout,
          color: Color(0xFFBA1A1A),
        ),

        label: const Text(
          "Logout",
          style: TextStyle(
            color: Color(0xFFBA1A1A),
            fontWeight: FontWeight.w600,
          ),
        ),

        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),

          side: const BorderSide(
            color: Color(0xFFBA1A1A),
            width: 1.5,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(
    BuildContext context,
    bool isDark,
    Color card,
  ) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),

      padding: const EdgeInsets.symmetric(vertical: 10),

      decoration: BoxDecoration(
        color: isDark
            ? card
            : Colors.white.withValues(alpha: 0.95),

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: "Home",

            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
          ),

          _NavItem(
            icon: Icons.add_circle_outline,
            label: "Request",

            onTap: () {
              Navigator.pushNamed(context, '/schedule-service');
            },
          ),

          _NavItem(
            icon: Icons.assignment_outlined,
            label: "Tasks",

            onTap: () {
              Navigator.pushNamed(context, '/request-history');
            },
          ),

          _NavItem(
            icon: Icons.notifications_outlined,
            label: "Alerts",

            onTap: () {
              Navigator.pushNamed(context, '/messages');
            },
          ),

          const _NavItem(
            icon: Icons.person,
            label: "Profile",
            active: true,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final color = active
        ? (isDark
            ? const Color(0xFF94F4AD)
            : const Color(0xFF006D38))
        : (isDark
            ? const Color(0xFF9AA39A)
            : const Color(0xFF707970));

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,

      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(icon, color: color, size: 24),

          const SizedBox(height: 3),

          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: active
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

