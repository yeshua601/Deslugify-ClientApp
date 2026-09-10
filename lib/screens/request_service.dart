import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
            // Search & Filters
            _buildSearchAndFilters(),
            const SizedBox(height: 28),

            // Active Tracking
            _buildActiveTracking(context),
            const SizedBox(height: 28),

            // Recent Requests
            _buildRecentRequests(),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withValues(alpha: 0.95),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: Row(
        children: [
          Image.network(
            'https://lh3.googleusercontent.com/aida/ADBb0uh_XxMS61KUaVNacue5FobV3T-qBgQZATqr4_2LBF35Ax6IoeUPI5kQqj2zIOcMcTmVAoibrf2r8PbVjXS1yhUMwtcIMjFKQUnmRJXa-2kHSmcnmg23Sx9gI31Vp4sD1qijatJaqkk9lGourj33P-ajkOc2NkWSBbPGwNsDFxPUSU0PmY7qRLgYZq4vBSop3JQRRqf80CgNsBL8c0zTV5sr0U2HYFQV6aDkVRGfRfV1XZZwbAf_6Cm_JTFKl21JL8qxex7C9_fGPA8',
            height: 30,
            errorBuilder: (_, _, _) =>
                const Icon(Icons.eco, color: Color(0xFF003D1A), size: 28),
          ),
          const SizedBox(width: 10),
          const Text(
            "Deslugify",
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
        const Padding(
          padding: EdgeInsets.only(right: 14),
          child: CircleAvatar(
            radius: 17,
            backgroundImage: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBrDiNizbkcLGMD2f2zerqt9KeqijC4Z5uPmaI3akKXHo1L3mhjtJQNxQx6FuJabXSYftmYP7Ot0S7TGd8toLFBX1v0SKqptmHnhpP02VrLpCrb183IiWWJQgnS9aNNV7IdykThpiXVVLIWUXrns-k4fOIJmI0zTE1MVnM2XNk9FTHpBM-KJYgyYaNYjN6H878RGtACQ7ZzLeJqFldbFqVMWaB0zgADGxlzkz0dqhk4qWTz7pwImqbrDmS7jAoNosfc8F-0J0T-2ll6',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE1E3DD)),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Search requests...",
              hintStyle: TextStyle(color: Color(0xFF707970)),
              prefixIcon: Icon(Icons.search, color: Color(0xFF707970)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 14),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _filterChip("All Tasks", true),
              _filterChip("Pending", false),
              _filterChip("Ongoing", false),
              _filterChip("Completed", false),
              _filterChip("Filters", false, icon: Icons.filter_list),
            ],
          ),
        ),
      ],
    );
  }

  Widget _filterChip(String label, bool active, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: active,
        showCheckmark: false,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: active ? Colors.white : const Color(0xFF191D19)),
              const SizedBox(width: 4),
            ],
            Text(label),
          ],
        ),
        onSelected: (_) {},
        backgroundColor: const Color(0xFFE6E9E2),
        selectedColor: const Color(0xFF003D1A),
        labelStyle: TextStyle(
          color: active ? Colors.white : const Color(0xFF191D19),
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      ),
    );
  }

  Widget _buildActiveTracking(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8EBE6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Active Tracking",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF003D1A),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF94F4AD),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.circle, size: 8, color: Color(0xFF006D38)),
                    SizedBox(width: 6),
                    Text(
                      "Live Update",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#REQ-4829",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF003D1A),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Industrial Waste Collection - Sector 7",
                      style: TextStyle(
                        color: Color(0xFF707970),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Estimated Arrival",
                    style: TextStyle(fontSize: 11, color: Color(0xFF707970)),
                  ),
                  Text(
                    "14 mins",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF006D38),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildTimeline(),
          const SizedBox(height: 18),
          _buildTechnicianInfo(),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _timelineDot("Request", Icons.check, true),
        _timelineDot("Assigned", Icons.person_search, true),
        _timelineDot("En Route", Icons.local_shipping, true),
        _timelineDot("Complete", Icons.inventory_2, false),
      ],
    );
  }

  Widget _timelineDot(String label, IconData icon, bool active) {
    return Column(
      children: [
        CircleAvatar(
          radius: 17,
          backgroundColor:
              active ? const Color(0xFF006D38) : const Color(0xFFE1E3DD),
          child: Icon(
            icon,
            color: active ? Colors.white : const Color(0xFF707970),
            size: 16,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: active ? const Color(0xFF003D1A) : const Color(0xFF707970),
          ),
        ),
      ],
    );
  }

  Widget _buildTechnicianInfo() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5EE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuC3DSUpM2JGGU4UvkCgm8LM4LL96F03hSGhOWWUOlrsDPE7BrDjHQ5Y8YpbehWP14-bEntMaN02cVUJJUQktARUGU16KSuowY0BQO3wMBtfr8QftLrwMiP9Aus_ShPhVC-Rnvuzc02-Cw4sQyLT4SX8KefpL7WG1IJYG03--LTycCCiCKtjYK8JqGVApHMlPZ2sJUzRucJKRZ_7knYv198lcAUzc2bMOnlukb6-0dniu6YDmmdcZVuNMx4doZ8PkKw_lnzA7q7UubeY",
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Marcus Chen",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF003D1A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "Lead Technician • 4.9 ★",
                  style: TextStyle(fontSize: 12, color: Color(0xFF707970)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Color(0xFF006D38)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat, color: Color(0xFF006D38)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildRecentRequests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Requests",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF003D1A),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _requestCard(
                "Water Quality Check",
                "Zone B",
                "Completed",
                const Color(0xFF006D38),
                Icons.water_drop,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _requestCard(
                "Air Filtration Service",
                "Central Plaza",
                "Pending",
                Colors.orange,
                Icons.cyclone,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _requestCard(
    String title,
    String location,
    String status,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EBE6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: color.withValues(alpha: 0.12),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF003D1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            location,
            style: const TextStyle(color: Color(0xFF707970), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: const Color(0xFF003D1A),
      foregroundColor: Colors.white,
      elevation: 4,
      child: const Icon(Icons.add, size: 28),
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
          _NavItem(icon: Icons.home, label: "Home", active: true),
          _NavItem(icon: Icons.add_circle_outline, label: "Request"),
          _NavItem(icon: Icons.assignment_outlined, label: "Tasks"),
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