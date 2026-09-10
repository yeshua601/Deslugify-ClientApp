import 'package:flutter/material.dart';

class RequestHistoryScreen extends StatelessWidget {
  const RequestHistoryScreen({super.key});

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
            // Overview Stats
            _buildStatsOverview(),
            const SizedBox(height: 28),

            // Filters
            _buildFilters(),
            const SizedBox(height: 24),

            // Timeline History
            const Text(
              "Request History",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF003D1A),
              ),
            ),
            const SizedBox(height: 16),

            _buildTimelineItem(
              icon: Icons.cleaning_services,
              iconColor: const Color(0xFF006D38),
              title: "Eco-Industrial Desludging",
              id: "#DSL-99201",
              date: "Oct 24, 2023",
              status: "COMPLETED",
              statusColor: const Color(0xFF006D38),
              technician: "Marcus Thorne",
              technicianRole: "Lead Technician • 4.9★",
              duration: "2h 45m",
              volume: "450 Liters",
              rating: 5,
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
            ),
            const SizedBox(height: 20),

            _buildTimelineItem(
              icon: Icons.history,
              iconColor: const Color(0xFF707970),
              title: "Routine Tank Drainage",
              id: "#DSL-97554",
              date: "Sep 28, 2023",
              status: "COMPLETED",
              statusColor: const Color(0xFF006D38),
              technician: "Sarah Jenkins",
              technicianRole: "Senior Field Expert • 5.0★",
              duration: "1h 15m",
              rating: 4,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withValues(alpha: 0.95),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: const Row(
        children: [
          Icon(Icons.eco, color: Color(0xFF003D1A), size: 26),
          SizedBox(width: 8),
          Text(
            "Request History",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF003D1A),
              fontSize: 18,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Color(0xFF003D1A)),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.tune, color: Color(0xFF003D1A)),
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

  Widget _buildStatsOverview() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            "COMPLETED",
            "24",
            Icons.check_circle,
            const Color(0xFF006D38),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard(
            "CANCELLED",
            "2",
            Icons.cancel,
            const Color(0xFFBA1A1A),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: _impactCard()),
      ],
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8EBE6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF707970),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF003D1A),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "IMPACT",
            style: TextStyle(fontSize: 11, color: Colors.white70),
          ),
          const SizedBox(height: 8),
          const Text(
            "120 kg",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const Text(
            "CO₂ offset",
            style: TextStyle(fontSize: 11, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFECEFE8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Text(
                  "All Requests",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                ),
                SizedBox(width: 6),
                Icon(Icons.expand_more, size: 18),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _filterChip("This Year", true),
          const SizedBox(width: 8),
          _filterChip("Sort by Date", false),
        ],
      ),
    );
  }

  Widget _filterChip(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF94F4AD) : const Color(0xFFE6E9E2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: active ? const Color(0xFF003D1A) : const Color(0xFF191D19),
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
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
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
                color: const Color(0xFFC0C9BE),
              ),
          ],
        ),
        const SizedBox(width: 14),

        // Card
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE8EBE6)),
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
                // Title + Status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF003D1A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "$id • $date",
                            style: const TextStyle(
                              color: Color(0xFF707970),
                              fontSize: 12,
                            ),
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

                // Technician
                if (technician != null) ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(Icons.person, size: 18),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            technician,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            technicianRole ?? "",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF707970),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],

                // Duration / Volume
                if (duration != null || volume != null) ...[
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      if (duration != null)
                        Expanded(child: _infoBox("Duration", duration)),
                      if (volume != null) ...[
                        const SizedBox(width: 10),
                        Expanded(child: _infoBox("Volume", volume)),
                      ],
                    ],
                  ),
                ],

                // Rating
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

                // Buttons
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
                          foregroundColor: const Color(0xFF003D1A),
                          side: const BorderSide(color: Color(0xFFC0C9BE)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Download",
                          style: TextStyle(fontWeight: FontWeight.w600),
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

  Widget _infoBox(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5EE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF707970)),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF003D1A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home_outlined, label: "Home"),
          _NavItem(icon: Icons.add_circle_outline, label: "Request"),
          _NavItem(icon: Icons.assignment, label: "Tasks", active: true),
          _NavItem(icon: Icons.notifications_outlined, label: "Alerts"),
          _NavItem(icon: Icons.person_outline, label: "Profile"),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _NavItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF006D38) : const Color(0xFF707970);

    return Column(
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
    );
  }
}