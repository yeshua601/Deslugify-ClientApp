import 'package:flutter/material.dart';

class RequestHistoryScreen extends StatelessWidget {
  const RequestHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF0F1410) : const Color(0xFFF8FAF3);
    final card = isDark ? const Color(0xFF1A211C) : Colors.white;
    final text = isDark ? const Color(0xFFE8EBE6) : const Color(0xFF003D1A);
    final muted = isDark ? const Color(0xFF9AA39A) : const Color(0xFF707970);
    final border = isDark ? const Color(0xFF2A332C) : const Color(0xFFE8EBE6);
    final accent = isDark ? const Color(0xFF94F4AD) : const Color(0xFF006D38);
    final chipBg = isDark ? const Color(0xFF2A332C) : const Color(0xFFECEFE8);
    final chipInactive = isDark ? const Color(0xFF2A332C) : const Color(0xFFE6E9E2);
    final infoBox = isDark ? const Color(0xFF243028) : const Color(0xFFF2F5EE);

    return Scaffold(
      backgroundColor: bg,
      appBar: _buildAppBar(context, isDark, accent, text),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsOverview(card, border, text, muted),
            const SizedBox(height: 28),
            _buildFilters(chipBg, chipInactive, text),
            const SizedBox(height: 24),
            Text(
              "Request History",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: text,
              ),
            ),
            const SizedBox(height: 16),
            _buildTimelineItem(
              icon: Icons.cleaning_services,
              iconColor: accent,
              title: "Eco-Industrial Desludging",
              id: "#DSL-99201",
              date: "Oct 24, 2023",
              status: "COMPLETED",
              statusColor: accent,
              technician: "Marcus Thorne",
              technicianRole: "Lead Technician • 4.9★",
              duration: "2h 45m",
              volume: "450 Liters",
              rating: 5,
              card: card,
              border: border,
              text: text,
              muted: muted,
              infoBox: infoBox,
            ),
            const SizedBox(height: 20),
            _buildTimelineItem(
              icon: Icons.block,
              iconColor: const Color(0xFFBA1A1A),
              title: "Emergency Pipe Check",
              id: "#DSL-98105",
              date: "Oct 12, 2023",
              status: "CANCELLED",
              statusColor: const Color(0xFFBA1A1A),
              technician: null,
              isCancelled: true,
              card: card,
              border: border,
              text: text,
              muted: muted,
              infoBox: infoBox,
            ),
            const SizedBox(height: 20),
            _buildTimelineItem(
              icon: Icons.history,
              iconColor: muted,
              title: "Routine Tank Drainage",
              id: "#DSL-97554",
              date: "Sep 28, 2023",
              status: "COMPLETED",
              statusColor: accent,
              technician: "Sarah Jenkins",
              technicianRole: "Senior Field Expert • 5.0★",
              duration: "1h 15m",
              rating: 4,
              card: card,
              border: border,
              text: text,
              muted: muted,
              infoBox: infoBox,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, isDark, card),
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    bool isDark,
    Color accent,
    Color text,
  ) {
    return AppBar(
      backgroundColor: isDark ? const Color(0xFF1A211C) : Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: isDark ? accent : const Color(0xFF003D1A)),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Icon(Icons.eco, color: isDark ? accent : const Color(0xFF003D1A), size: 26),
          const SizedBox(width: 8),
          Text(
            "Request History",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? accent : const Color(0xFF003D1A),
              fontSize: 18,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: isDark ? accent : const Color(0xFF003D1A)),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.tune, color: isDark ? accent : const Color(0xFF003D1A)),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.only(right: 12),
          child: CircleAvatar(
            radius: 17,
            backgroundImage: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCOQj0NSMnWaawOJ_dI4HPUSvtHaokihmiJUepNf-W4vzRow47jZAxxMg9PjY2E1UPZduFMAcJcz917N-uZ4NSpGbzPubkjz04JY6-69DIq1Gx2OWHA-VKDok6-GTmk4hcQwMhq0F-z-cyTmq0-aoXUMmUTj6lxswu3Cf2_4ASZj1mBqFAdij5_i_remkNyE0OlUDjxqCPIeMtwlPJaUzabt5BT1_9JkoT7lr5cT6Q55Lg2Y8ByX7cu86DHo4SidJHeiU7cU2jf-95c',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsOverview(
    Color card,
    Color border,
    Color text,
    Color muted,
  ) {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            "COMPLETED",
            "24",
            Icons.check_circle,
            const Color(0xFF006D38),
            card,
            border,
            text,
            muted,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            "CANCELLED",
            "2",
            Icons.cancel,
            const Color(0xFFBA1A1A),
            card,
            border,
            text,
            muted,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: _impactCard()),
      ],
    );
  }

  Widget _statCard(
    String label,
    String value,
    IconData icon,
    Color color,
    Color card,
    Color border,
    Color text,
    Color muted,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: muted,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: text,
                ),
              ),
              Icon(icon, color: color, size: 26),
            ],
          ),
        ],
      ),
    );
  }

  Widget _impactCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF12562B),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "IMPACT",
            style: TextStyle(fontSize: 11, color: Colors.white70),
          ),
          SizedBox(height: 8),
          Text(
            "120 kg",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            "CO₂ offset",
            style: TextStyle(fontSize: 11, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(Color chipBg, Color chipInactive, Color text) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: chipBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Text(
                  "All Requests",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: text,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.expand_more, size: 18, color: text),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _filterChip("This Year", true, chipInactive, text),
          const SizedBox(width: 8),
          _filterChip("Sort by Date", false, chipInactive, text),
        ],
      ),
    );
  }

  Widget _filterChip(
    String label,
    bool active,
    Color chipInactive,
    Color text,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF94F4AD) : chipInactive,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: active ? const Color(0xFF003D1A) : text,
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String id,
    required String date,
    required String status,
    required Color statusColor,
    String? technician,
    String? technicianRole,
    String? duration,
    String? volume,
    int? rating,
    bool isCancelled = false,
    required Color card,
    required Color border,
    required Color text,
    required Color muted,
    required Color infoBox,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: iconColor.withValues(alpha: 0.12),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            if (!isCancelled)
              Container(
                width: 2,
                height: 120,
                margin: const EdgeInsets.symmetric(vertical: 6),
                color: border,
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: text,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "$id • $date",
                            style: TextStyle(color: muted, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if (technician != null) ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: muted.withValues(alpha: 0.2),
                        child: Icon(Icons.person, size: 18, color: muted),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            technician,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: text,
                            ),
                          ),
                          Text(
                            technicianRole ?? "",
                            style: TextStyle(fontSize: 12, color: muted),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                if (duration != null || volume != null) ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      if (duration != null)
                        Expanded(
                          child: _infoBox("Duration", duration, infoBox, text, muted),
                        ),
                      if (volume != null) ...[
                        const SizedBox(width: 10),
                        Expanded(
                          child: _infoBox("Volume", volume, infoBox, text, muted),
                        ),
                      ],
                    ],
                  ),
                ],
                if (rating != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Icon(
                        i < rating ? Icons.star : Icons.star_border,
                        color: const Color(0xFF7BDA96),
                        size: 18,
                      ),
                    ),
                  ),
                ],
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
                          "View Report",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: text,
                          side: BorderSide(color: border),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Download",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: text,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoBox(
    String label,
    String value,
    Color infoBox,
    Color text,
    Color muted,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: infoBox,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 11, color: muted)),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, bool isDark, Color card) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? card : Colors.white.withValues(alpha: 0.95),
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
          // Tasks active — History is under Tasks
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
        ? (isDark ? const Color(0xFF94F4AD) : const Color(0xFF006D38))
        : (isDark ? const Color(0xFF9AA39A) : const Color(0xFF707970));

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