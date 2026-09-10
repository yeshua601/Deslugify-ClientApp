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
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilters(context),
            const SizedBox(height: 28),
            _buildActiveTracking(context),
            const SizedBox(height: 28),
            const Text(
              "Recent Requests",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF003D1A),
              ),
            ),
            const SizedBox(height: 16),
            _buildRecentRequests(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(context),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.network(
            'https://lh3.googleusercontent.com/aida/ADBb0uh_XxMS61KUaVNacue5FobV3T-qBgQZATqr4_2LBF35Ax6IoeUPI5kQqj2zIOcMcTmVAoibrf2r8PbVjXS1yhUMwtcIMjFKQUnmRJXa-2kHSmcnmg23Sx9gI31Vp4sD1qijatJaqkk9lGourj33P-ajkOc2NkWSBbPGwNsDFxPUSU0PmY7qRLgYZq4vBSop3JQRRqf80CgNsBL8c0zTV5sr0U2HYFQV6aDkVRGfRfV1XZZwbAf_6Cm_JTFKl21JL8qxex7C9_fGPA8',
            height: 32,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.eco, size: 32, color: Color(0xFF003D1A)),
          ),
          const SizedBox(width: 8),
          const Text(
            "Deslugify",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003D1A),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Color(0xFF707970)),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBrDiNizbkcLGMD2f2zerqt9KeqijC4Z5uPmaI3akKXHo1L3mhjtJQNxQx6FuJabXSYftmYP7Ot0S7TGd8toLFBX1v0SKqptmHnhpP02VrLpCrb183IiWWJQgnS9aNNV7IdykThpiXVVLIWUXrns-k4fOIJmI0zTE1MVnM2XNk9FTHpBM-KJYgyYaNYjN6H878RGtACQ7ZzLeJqFldbFqVMWaB0zgADGxlzkz0dqhk4qWTz7pwImqbrDmS7jAoNosfc8F-0J0T-2ll6',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5EE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC0C9BE)),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search requests...",
          prefixIcon: Icon(Icons.search, color: Color(0xFF707970)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _filterChip("All Tasks", true, onTap: () {}),
          _filterChip(
            "Pending",
            false,
            onTap: () {
              Navigator.pushNamed(context, '/pending-requests');
            },
          ),
          _filterChip(
            "Ongoing",
            false,
            onTap: () {
              Navigator.pushNamed(context, '/ongoing-requests');
            },
          ),
          _filterChip(
            "Completed",
            false,
            onTap: () {
              Navigator.pushNamed(context, '/request-history');
            },
          ),
          _filterChip(
            "Filters",
            false,
            icon: Icons.filter_list,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _filterChip(
    String label,
    bool selected, {
    IconData? icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: selected,
        showCheckmark: false,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: selected ? Colors.white : const Color(0xFF191D19),
              ),
              const SizedBox(width: 4),
            ],
            Text(label),
          ],
        ),
        onSelected: (_) => onTap(),
        backgroundColor: const Color(0xFFE6E9E2),
        selectedColor: const Color(0xFF003D1A),
        labelStyle: TextStyle(
          color: selected ? Colors.white : const Color(0xFF191D19),
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildActiveTracking(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8EBE6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF12562B).withValues(alpha: 0.08),
            blurRadius: 20,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF94F4AD),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.circle, size: 10, color: Color(0xFF006D38)),
                    SizedBox(width: 6),
                    Text(
                      "Live Update",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#REQ-4829",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Industrial Waste Collection - Sector 7",
                      style: TextStyle(color: Color(0xFF707970), fontSize: 13),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Estimated Arrival",
                    style: TextStyle(fontSize: 12, color: Color(0xFF707970)),
                  ),
                  Text(
                    "14 mins",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF006D38),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildTimeline(),
          const SizedBox(height: 16),
          Container(
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
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Lead Technician • 4.9 ★",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF707970)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.call, color: Color(0xFF006D38)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/live-call');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chat, color: Color(0xFF006D38)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/messages');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: const Color(0xFFE1E3DD),
            borderRadius: BorderRadius.circular(999),
          ),
          child: const FractionallySizedBox(
            widthFactor: 0.65,
            alignment: Alignment.centerLeft,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF006D38), Color(0xFFAEF3B9)],
                ),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(999),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _TimelineDot(label: "Request", icon: Icons.check, active: true),
            _TimelineDot(
              label: "Assigned",
              icon: Icons.person_search,
              active: true,
            ),
            _TimelineDot(
              label: "En Route",
              icon: Icons.local_shipping,
              active: true,
            ),
            _TimelineDot(
              label: "Complete",
              icon: Icons.inventory_2,
              active: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentRequests() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _requestCard(
                "Water Quality Check",
                "Zone B - Residential Area",
                "Completed",
                Colors.teal,
                Icons.water_drop,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _requestCard(
                "Air Filtration Service",
                "Central Plaza Hub",
                "Pending",
                Colors.orange,
                Icons.cyclone,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _ecoAuditCard(),
      ],
    );
  }

  Widget _requestCard(
    String title,
    String subtitle,
    String status,
    Color accent,
    IconData icon,
  ) {
    final isCompleted = status.toLowerCase() == "completed";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EBE6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: accent.withValues(alpha: 0.12),
                child: Icon(icon, color: accent, size: 20),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE1E3DD),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
            subtitle,
            style: const TextStyle(color: Color(0xFF707970), fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.schedule,
                color:
                    isCompleted ? const Color(0xFF006D38) : Colors.orange,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                status,
                style: TextStyle(
                  color:
                      isCompleted ? const Color(0xFF006D38) : Colors.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ecoAuditCard() {
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
          const Text(
            "Eco-System Audit",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF003D1A),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Comprehensive survey of local biodiversity corridor.",
            style: TextStyle(color: Color(0xFF707970), fontSize: 13),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _smallInfoBox("Status", "Ongoing"),
              const SizedBox(width: 10),
              _smallInfoBox("Duration", "3 Days"),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF003D1A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text("View Detailed Report"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallInfoBox(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F5EE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Color(0xFF707970)),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF003D1A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, '/schedule-service');
      },
      backgroundColor: const Color(0xFF003D1A),
      foregroundColor: Colors.white,
      icon: const Icon(Icons.add),
      label: const Text("New Request"),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: const Color(0xFF003D1A),
      unselectedItemColor: const Color(0xFF707970),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      onTap: (index) {
        switch (index) {
          case 0:
            // Home
            break;
          case 1:
            // Requests list
            Navigator.pushNamed(context, '/schedule-service');
            break;
          case 2:
            // Tasks / Ongoing
            Navigator.pushNamed(context, '/request-history');
            break;
          case 3:
            // Notifications
            Navigator.pushNamed(context, '/messages');
            break;
          case 4:
            // Profile
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
         icon: Icon(Icons.add_circle_outline),
         activeIcon: Icon(Icons.add_circle_outlined),
         label: "Request",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment_outlined),
          activeIcon: Icon(Icons.assignment),
          label: "Tasks",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          activeIcon: Icon(Icons.notifications),
          label: "Notifications",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}

class _TimelineDot extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;

  const _TimelineDot({
    required this.label,
    required this.icon,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: active ? const Color(0xFF006D38) : const Color(0xFFE1E3DD),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: active ? Colors.white : const Color(0xFF707970),
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
}