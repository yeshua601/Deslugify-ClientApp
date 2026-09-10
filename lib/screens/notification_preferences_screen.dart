import 'package:flutter/material.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  bool _serviceUpdates = true;
  bool _technicianArrival = true;
  bool _chatMessages = true;
  bool _scheduledReminders = true;
  bool _promotions = false;
  bool _emailNotifications = false;

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
          'Notification Preferences',
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
              'Choose what alerts you want to receive from Deslugify.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF707970),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // Service alerts
            _sectionTitle('Service Alerts'),
            const SizedBox(height: 10),
            _card(
              children: [
                _switchTile(
                  title: 'Service status updates',
                  subtitle: 'Assigned, en route, completed',
                  value: _serviceUpdates,
                  onChanged: (v) => setState(() => _serviceUpdates = v),
                ),
                _divider(),
                _switchTile(
                  title: 'Technician arrival alerts',
                  subtitle: 'Notify when technician is nearby',
                  value: _technicianArrival,
                  onChanged: (v) => setState(() => _technicianArrival = v),
                ),
                _divider(),
                _switchTile(
                  title: 'Scheduled reminders',
                  subtitle: 'Reminders before your appointment',
                  value: _scheduledReminders,
                  onChanged: (v) => setState(() => _scheduledReminders = v),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Messages
            _sectionTitle('Messages'),
            const SizedBox(height: 10),
            _card(
              children: [
                _switchTile(
                  title: 'Chat messages',
                  subtitle: 'Messages from technician or support',
                  value: _chatMessages,
                  onChanged: (v) => setState(() => _chatMessages = v),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Other
            _sectionTitle('Other'),
            const SizedBox(height: 10),
            _card(
              children: [
                _switchTile(
                  title: 'Promotions & tips',
                  subtitle: 'Eco tips, offers, and news',
                  value: _promotions,
                  onChanged: (v) => setState(() => _promotions = v),
                ),
                _divider(),
                _switchTile(
                  title: 'Email notifications',
                  subtitle: 'Receive the same updates by email',
                  value: _emailNotifications,
                  onChanged: (v) => setState(() => _emailNotifications = v),
                ),
              ],
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notification preferences saved'),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003D1A),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Save Preferences',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
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

  Widget _switchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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