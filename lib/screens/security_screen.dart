import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool _twoFactorEnabled = false;
  bool _biometricEnabled = true;
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF3),
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 0.95),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF003D1A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Security',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF003D1A),
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Manage your password and account protection settings.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF707970),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // Change Password
            _sectionTitle('Change Password'),
            const SizedBox(height: 10),
            _card(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    children: [
                      _passwordField(
                        label: 'Current Password',
                        controller: _currentPasswordController,
                        obscure: _obscureCurrent,
                        onToggle: () {
                          setState(() => _obscureCurrent = !_obscureCurrent);
                        },
                      ),
                      const SizedBox(height: 14),
                      _passwordField(
                        label: 'New Password',
                        controller: _newPasswordController,
                        obscure: _obscureNew,
                        onToggle: () {
                          setState(() => _obscureNew = !_obscureNew);
                        },
                      ),
                      const SizedBox(height: 14),
                      _passwordField(
                        label: 'Confirm New Password',
                        controller: _confirmPasswordController,
                        obscure: _obscureConfirm,
                        onToggle: () {
                          setState(() => _obscureConfirm = !_obscureConfirm);
                        },
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _updatePassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF003D1A),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Update Password',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),

            const SizedBox(height: 24),

            // Protection
            _sectionTitle('Account Protection'),
            const SizedBox(height: 10),
            _card(
              children: [
                _switchTile(
                  icon: Icons.phonelink_lock_outlined,
                  title: 'Two-Factor Authentication',
                  subtitle: 'Extra security with a verification code',
                  value: _twoFactorEnabled,
                  onChanged: (v) {
                    setState(() => _twoFactorEnabled = v);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          v
                              ? 'Two-Factor Authentication enabled'
                              : 'Two-Factor Authentication disabled',
                        ),
                      ),
                    );
                  },
                ),
                _divider(),
                _switchTile(
                  icon: Icons.fingerprint,
                  title: 'Biometric Login',
                  subtitle: 'Use fingerprint or face unlock',
                  value: _biometricEnabled,
                  onChanged: (v) {
                    setState(() => _biometricEnabled = v);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          v
                              ? 'Biometric login enabled'
                              : 'Biometric login disabled',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Sessions
            _sectionTitle('Sessions'),
            const SizedBox(height: 10),
            _card(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF94F4AD).withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.devices_outlined,
                      color: Color(0xFF006D38),
                      size: 22,
                    ),
                  ),
                  title: const Text(
                    'Log out of all devices',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF003D1A),
                    ),
                  ),
                  subtitle: const Text(
                    'Sign out everywhere except this phone',
                    style: TextStyle(fontSize: 13, color: Color(0xFF707970)),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Color(0xFF707970),
                  ),
                  onTap: _logoutAllDevices,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updatePassword() {
    if (_currentPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all password fields')),
      );
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match')),
      );
      return;
    }

    if (_newPasswordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password updated successfully')),
    );

    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  void _logoutAllDevices() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out all devices?'),
        content: const Text(
          'You will stay signed in on this phone. All other sessions will be ended.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out of all other devices')),
              );
            },
            child: const Text(
              'Confirm',
              style: TextStyle(color: Color(0xFFBA1A1A)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF003D1A),
        ),
      ),
    );
  }

  Widget _card({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EBE6)),
      ),
      child: Column(children: children),
    );
  }

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF191D19),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAF3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE1E3DD)),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              const Icon(Icons.lock_outline, color: Color(0xFF707970), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscure,
                  decoration: const InputDecoration(
                    hintText: '••••••••',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: const Color(0xFF707970),
                  size: 20,
                ),
                onPressed: onToggle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      secondary: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF94F4AD).withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: const Color(0xFF006D38), size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Color(0xFF003D1A),
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 13, color: Color(0xFF707970)),
      ),
      value: value,
      activeThumbColor: const Color(0xFF006D38),
      activeTrackColor: const Color(0xFF94F4AD),
      onChanged: onChanged,
    );
  }

  Widget _divider() => const Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
        color: Color(0xFFE1E3DD),
      );
}