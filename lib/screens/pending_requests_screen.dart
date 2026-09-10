import 'package:flutter/material.dart';

class PendingRequestsScreen extends StatelessWidget {
  const PendingRequestsScreen({super.key});

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
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilterChips(context),
            const SizedBox(height: 24),
            _buildRequestCard(
              id: "DSL-82910",
              title: "Septic Inspection",
              date: "Oct 24, 2023",
              estimate: "Est. 2-3 Days",
              urgency: "HIGH",
              description:
                  "Periodic maintenance inspection for residential sludge filtration system in Sector 4.",
              location: "Silver Creek, S4",
            ),
            const SizedBox(height: 14),
            _buildRequestCard(
              id: "DSL-82944",
              title: "Filter Replacement",
              date: "Oct 26, 2023",
              estimate: "Est. 12 Hours",
              urgency: "LOW",
              description:
                  "Carbon filter replacement for the main kitchen drainage outlet. Sensor reports 85% capacity.",
            ),
            const SizedBox(height: 14),
            _buildRequestCard(
              id: "DSL-83002",
              title: "System Diagnostic",
              date: "Oct 28, 2023",
              estimate: "Est. 24 Hours",
              urgency: "MEDIUM",
              description:
                  "Comprehensive system health check for main treatment unit.",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/schedule-service');
        },
        backgroundColor: const Color(0xFF003D1A),
        foregroundColor: Colors.white,
        elevation: 4,
        child: const Icon(Icons.add, size: 28),
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
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        color: const Color(0xFF003D1A),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        "Pending Requests",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF003D1A),
          fontSize: 18,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Color(0xFF003D1A)),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.only(right: 14),
          child: CircleAvatar(
            radius: 17,
            backgroundImage: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuC-OehhiqlGqSeyEr6u8ofNNtqgh4Lj9_lyPan_dznGWLmxBEPR1zeY85kbehOaFI3rAkBaUXYgJRkA0Xp5_lKzx3JEveDoRjDBXsG3lMRXyn6jCseQgjV_u89_qMe1oEoiT9NKGST0e74Z38PSPDn_WLMfIzZ6EfQZMxq31sKysfClwd8OHR6zDOuBe0ukYrNsZZgL-AY7a9bpHELriEbTBsN47DOyJDTrZthDFtZ7slImIeB99fNoNivIsWFYM_5wjYrbROQqeqnR',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE1E3DD)),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search Request ID or Type...",
          hintStyle: TextStyle(color: Color(0xFF707970)),
          prefixIcon: Icon(Icons.search, color: Color(0xFF707970)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
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
          _chip("Pending", true, onTap: () {}),
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
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF003D1A) : const Color(0xFFECEFE8),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: active ? Colors.white : const Color(0xFF191D19),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCard({
    required String id,
    required String title,
    required String date,
    required String estimate,
    required String urgency,
    required String description,
    String? location,
  }) {
    Color urgencyBg;
    Color urgencyText;

    switch (urgency) {
      case "HIGH":
        urgencyBg = const Color(0xFFFFDAD6);
        urgencyText = const Color(0xFFBA1A1A);
        break;
      case "MEDIUM":
        urgencyBg = const Color(0xFF94F4AD).withValues(alpha: 0.35);
        urgencyText = const Color(0xFF006D38);
        break;
      default:
        urgencyBg = const Color(0xFFE1E3DD);
        urgencyText = const Color(0xFF006D38);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE8EBE6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
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
                      id,
                      style: const TextStyle(
                        color: Color(0xFF707970),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF003D1A),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: urgencyBg,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      urgency,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: urgencyText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF12562B).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      "PENDING",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003D1A),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.calendar_today,
                  size: 16, color: Color(0xFF006D38)),
              const SizedBox(width: 6),
              Text(date, style: const TextStyle(fontSize: 14)),
              const Spacer(),
              const Icon(Icons.schedule, size: 16, color: Color(0xFF006D38)),
              const SizedBox(width: 6),
              Text(estimate, style: const TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF707970),
              height: 1.45,
              fontSize: 14,
            ),
          ),
          if (location != null) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBfewjABXMc18FBaw_koz5I5cAtOSUATKgueBOVSFgcTjSPW2oSg8fc7eFmf--a6QOfGsHtPCAioXMiPd78oMIxnw9-98b0jO1XoxXDYrgKOaDnQVrZDZx-FtZE7AF8g2CbsAppneiV6AI-LMudiWsAAw8L61NXFllsuW03a_m2Yx5_dI7B5XJK0CH4NZfI9rTmGEUhZEvkuDhcHfW22tNMPI1TbaU9X5ngic25I7Y10CnSJy6AtMWLGmEyXhE_zTh5T-DqUJXb8Nd9',
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      height: 100,
                      color: const Color(0xFFE1E3DD),
                      child: const Center(
                        child: Icon(Icons.map, color: Color(0xFF707970)),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.location_on,
                              size: 14, color: Color(0xFF006D38)),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                    padding: const EdgeInsets.symmetric(vertical: 14),
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
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Edit Request",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          if (urgency == "HIGH") ...[
            const SizedBox(height: 6),
            Center(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFBA1A1A),
                ),
                child: const Text(
                  "Cancel Request",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
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
          // Home active — Pending is part of Home flow
          const _NavItem(
            icon: Icons.home,
            label: "Home",
            active: true,
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