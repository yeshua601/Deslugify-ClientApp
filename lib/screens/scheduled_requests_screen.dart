import 'package:flutter/material.dart';

class ScheduledRequestsScreen extends StatelessWidget {
  const ScheduledRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF3),
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReminderBanner(),
            const SizedBox(height: 20),
            _buildFilterChips(context),
            const SizedBox(height: 28),
            const Text(
              "Next Appointment",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF003D1A),
              ),
            ),
            const SizedBox(height: 12),
            _buildNextAppointmentCard(),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Upcoming Requests",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF003D1A),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today, size: 16),
                  label: const Text("View Calendar"),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF006D38),
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildRequestCard(
              reqId: "REQ-88291",
              title: "Waste-to-Energy Optimization",
              subtitle:
                  "Anomaly detected in biogas conversion efficiency levels in residential sector 9...",
              status: "SCHEDULED",
              urgency: "URGENT",
              team: "Eco-Ops Delta",
            ),
            const SizedBox(height: 14),
            _buildRequestCard(
              reqId: "REQ-88245",
              title: "Smart Irrigation Calibration",
              subtitle:
                  "Seasonal recalibration for hydro-sensors across the botanical corridor...",
              status: "SCHEDULED",
              urgency: "NORMAL",
              team: "AquaFlow Prime",
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withValues(alpha: 0.95),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF003D1A)),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Scheduled Requests",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF003D1A),
          fontSize: 18,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_today, color: Color(0xFF003D1A)),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.search, color: Color(0xFF003D1A)),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.only(right: 12),
          child: CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBQ4ny0AbuvWCu-YLRSpcaLttD6wiMeIKNJsTBKGZoL5AcIG8DHb3Dtp9Rbbg-JrBhaAhNcBNesYQwGzH-BSBvoFyHhTeKOeN6cTBbRmtYUO7BGIT9il8bMUL2D3igO_wqwjR9CQDHuwRz8U3M05SYteELIV96McPK94WcvN0quLhMo-aGJWiaUcJ7eB67YAc2P59r5NQzW-0el2FH-0UDlGxkYEfQ0ofF2UkpET3nA_HLpdDP2q0djaUSOex2oUSsuT3lI0l8R91lL',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReminderBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12562B),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_active,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upcoming Action",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "Verification due in 4 hours",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: const Text(
              "DISMISS",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip(
            "All",
            false,
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
          ),
          _chip(
            "Pending",
            false,
            onTap: () {
              Navigator.pushNamed(context, '/pending-requests');
            },
          ),
          _chip(
            "Scheduled",
            true,
            onTap: () {},
          ),
          _chip(
            "Ongoing",
            false,
            onTap: () {
              Navigator.pushNamed(context, '/ongoing-requests');
            },
          ),
          _chip(
            "Completed",
            false,
            onTap: () {
              Navigator.pushNamed(context, '/request-history');
            },
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, bool active, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: active,
        showCheckmark: false,
        onSelected: (_) => onTap(),
        backgroundColor: const Color(0xFFF2F5EE),
        selectedColor: const Color(0xFF003D1A),
        labelStyle: TextStyle(
          color: active ? Colors.white : const Color(0xFF191D19),
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildNextAppointmentCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE8EBE6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF12562B).withValues(alpha: 0.06),
            blurRadius: 20,
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAF3),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE1E3DD)),
                ),
                child: const Column(
                  children: [
                    Text(
                      "OCT",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBA1A1A),
                      ),
                    ),
                    Text(
                      "24",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                        color: Color(0xFF003D1A),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, size: 8, color: Color(0xFF006D38)),
                        SizedBox(width: 6),
                        Text(
                          "Active Schedule",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF006D38),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Eco-System Maintenance",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF003D1A),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Central Park Zone A • Smart Filtration Check",
                      style: TextStyle(
                        color: Color(0xFF707970),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F5EE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "02",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003D1A),
                      ),
                    ),
                    Text("Days",
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFF707970))),
                  ],
                ),
                SizedBox(width: 28),
                Column(
                  children: [
                    Text(
                      "14",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003D1A),
                      ),
                    ),
                    Text("Hours",
                        style:
                            TextStyle(fontSize: 11, color: Color(0xFF707970))),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 28),
          const Row(
            children: [
              Expanded(
                child: _InfoColumn(
                  icon: Icons.schedule,
                  label: "Arrival Window",
                  value: "09:00 - 11:30 AM",
                ),
              ),
              Expanded(
                child: _InfoColumn(
                  icon: Icons.groups,
                  label: "Assigned Team",
                  value: "GreenTech Alpha",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _InfoColumn(
            icon: Icons.location_on,
            label: "Location",
            value: "Sector 4, Plaza North",
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard({
    required String reqId,
    required String title,
    required String subtitle,
    required String status,
    required String urgency,
    required String team,
  }) {
    final isUrgent = urgency == "URGENT";

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EBE6)),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                reqId,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF707970),
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF94F4AD).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Color(0xFF006D38),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isUrgent
                      ? const Color(0xFFFFDAD6)
                      : const Color(0xFFE1E3DD),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  urgency,
                  style: TextStyle(
                    color: isUrgent
                        ? const Color(0xFFBA1A1A)
                        : const Color(0xFF006D38),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF003D1A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF707970),
              height: 1.4,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Text(
                "Team: ",
                style: TextStyle(color: Color(0xFF707970), fontSize: 13),
              ),
              Text(
                team,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF003D1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003D1A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "View Details",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF003D1A),
                    side: const BorderSide(color: Color(0xFFC0C9BE)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Reschedule",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
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
          const _NavItem(
            icon: Icons.assignment,
            label: "Tasks",
            active: true,
          ),
          _NavItem(
            icon: Icons.notifications_outlined,
            label: "Alerts",
            onTap: () {
              Navigator.pushNamed(context, '/messages');
            },
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: "Profile",
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }
}

class _InfoColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoColumn({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF006D38), size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF707970),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Color(0xFF003D1A),
                ),
              ),
            ],
          ),
        ),
      ],
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
    final color = active ? const Color(0xFF006D38) : const Color(0xFF707970);

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
              fontWeight: active ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}