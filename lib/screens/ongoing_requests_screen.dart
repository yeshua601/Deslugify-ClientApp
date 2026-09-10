import 'package:flutter/material.dart';

class OngoingRequestsScreen extends StatelessWidget {
  const OngoingRequestsScreen({super.key});

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
            _buildLiveStatus(),
            const SizedBox(height: 18),
            _buildSearchAndFilters(context),
            const SizedBox(height: 24),
            _buildActiveRequestCard(),
            const SizedBox(height: 20),
            _buildTechnicianCard(context),
            const SizedBox(height: 20),
            _buildServiceTimeline(),
            const SizedBox(height: 28),
            _buildActionButtons(context),
            const SizedBox(height: 20),
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
      title: const Row(
        children: [
          Icon(Icons.eco, color: Color(0xFF003D1A), size: 26),
          SizedBox(width: 10),
          Text(
            "Ongoing Requests",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF003D1A),
              fontSize: 18,
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: Color(0xFF003D1A)),
              onPressed: () {
                Navigator.pushNamed(context, '/messages');
              },
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFBA1A1A),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(right: 14),
          child: CircleAvatar(
            radius: 17,
            backgroundImage: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuCW0vld2eIL2W_emIQFlQfbO31RPpBjSoMB811HyCMjH7Kx_g8QRfchwNp2ohKkzFXXD6p0ZEe34UgvsQO75a_cG9SwqKrE17nRVTFNjjPYeyAgw_ckG10dvzC3hyQ5e8wZa4vLZMH8JXIPkw6uesFugzmyz9D75llNYFF5IvZIHB96Qcp3M1oAqR31jQODczO6YsucVzrP2y6KRggF3VnOGPLQgq0VpM-PI09JC2zG0ve80F0FCNZdulfhrjGtnEWulmG2Nw5TVBTQ',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLiveStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF94F4AD).withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 9, color: Color(0xFF006D38)),
          SizedBox(width: 8),
          Text(
            "Live Tracking Active",
            style: TextStyle(
              color: Color(0xFF006D38),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters(BuildContext context) {
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
              hintText: "Search Request ID...",
              hintStyle: TextStyle(color: Color(0xFF707970)),
              prefixIcon: Icon(Icons.search, color: Color(0xFF707970)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
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
                "Ongoing",
                true,
                onTap: () {},
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
        ),
      ],
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

  Widget _buildActiveRequestCard() {
    return Container(
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
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#DSG-882910",
                      style: TextStyle(
                        color: Color(0xFF707970),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Industrial Waste Collection",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF003D1A),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF94F4AD).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  "En Route",
                  style: TextStyle(
                    color: Color(0xFF006D38),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(child: _infoBox("Arrival Estimate", "12 mins")),
              Expanded(child: _infoBox("Volume", "4.5 Tons")),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCkPTFuhtKtZQ_SNRPjZIgazb4hrPZaOJ_ooiNqILpsh8A_WmdU6dZ656I-P5UNjwjuNvc7y_GtlPuWhePGUsldN4qG1sqp6ZEIvM7EeoiYHYZBYWeCU-D8T08nI_6gzo2eriuYCpMdGslZZJiN2ZiXV_MTnCxK0ZKzlUoJZM4-FHzr4cDaaFxqxDMFskeB6mm65OC19NstwLuYgJoPMrR4zbmWq1RQe459ZxYIvynYVYRWn2BB-DhXjhdCjcES1ke4rcvgHD4RBVlj',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    height: 120,
                    color: const Color(0xFFE1E3DD),
                    child: const Center(
                      child:
                          Icon(Icons.map, size: 40, color: Color(0xFF707970)),
                    ),
                  ),
                ),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.35),
                      ],
                    ),
                  ),
                ),
                const Center(
                  child: Icon(
                    Icons.local_shipping,
                    color: Colors.white,
                    size: 38,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 8)],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF707970)),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xFF003D1A),
          ),
        ),
      ],
    );
  }

  Widget _buildTechnicianCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EBE6)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAOrLFbOnGpA-jGS4VRwUBqgyz2KgdNGcOxZ8bzsUEaT_vcUKoJ7eV6seW_vmP2KfM6iaxbW4A5nr83sIfxahZ10cZTEVZ2flP0Jvzx9QQTH0uwL_PpolbK8S4sgt4D91zkyZmgXr0zhTSiNeDNT3ttz82DyMMYWPwHUsqYY9zjTRS37SPldCFPTfdkPpB6J5-qtbDWO-zd1adUz1zqUzA2rLjmVgHo0PKy7pPPSUd87MEod9yPkgU7IyYhlgTCaPTbzGI1nbT19uMU',
              width: 54,
              height: 54,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 54,
                height: 54,
                color: const Color(0xFFE1E3DD),
                child: const Icon(Icons.person, color: Color(0xFF006D38)),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Marcus Chen",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF003D1A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "Lead Technician",
                  style: TextStyle(color: Color(0xFF707970), fontSize: 13),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Color(0xFF7BDA96), size: 16),
                    Text(
                      " 4.9 ",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    Text(
                      "(240+ jobs)",
                      style: TextStyle(fontSize: 12, color: Color(0xFF707970)),
                    ),
                  ],
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
    );
  }

  Widget _buildServiceTimeline() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE8EBE6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Service Timeline",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF003D1A),
            ),
          ),
          const SizedBox(height: 20),
          _timelineStep("Request Submitted", "09:00 AM • Verified", true),
          _timelineStep("Team Assigned", "09:15 AM • Marcus C.", true),
          _timelineStep(
            "En Route",
            "Estimated arrival 12:42 PM",
            true,
            isActive: true,
          ),
          _timelineStep("Ongoing Service", "Waiting for arrival", false),
          _timelineStep("Completed", "", false, isLast: true),
        ],
      ),
    );
  }

  Widget _timelineStep(
    String title,
    String subtitle,
    bool completed, {
    bool isActive = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF006D38)
                    : completed
                        ? const Color(0xFF94F4AD)
                        : const Color(0xFFE1E3DD),
                shape: BoxShape.circle,
              ),
              child: isActive
                  ? const Icon(Icons.local_shipping,
                      color: Colors.white, size: 14)
                  : completed
                      ? const Icon(Icons.check, color: Colors.white, size: 14)
                      : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 42,
                color: completed
                    ? const Color(0xFF94F4AD)
                    : const Color(0xFFE1E3DD),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive
                        ? const Color(0xFF003D1A)
                        : const Color(0xFF191D19),
                    fontSize: 14,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF707970),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF003D1A),
              side: const BorderSide(color: Color(0xFFC0C9BE)),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Cancel Request",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/live-tracking');
            },
            icon: const Icon(Icons.map, size: 20),
            label: const Text(
              "Track Live",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003D1A),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
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