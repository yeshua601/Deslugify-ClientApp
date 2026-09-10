import 'package:flutter/material.dart';

class LiveTrackingScreen extends StatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  State<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF3),
      body: SafeArea(
        child: Stack(
          children: [
            // ===== MAP AREA =====
            Positioned.fill(
              top: 0,
              bottom: 0,
              child: _buildMapArea(),
            ),

            // ===== TOP APP BAR =====
            _buildAppBar(),

            // ===== FLOATING ETA CARD =====
            const Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: _ETACard(),
            ),

            // ===== BOTTOM TECHNICIAN CARD + NAV =====
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Technician Card
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                    child: _TechnicianCard(),
                  ),
                  // Bottom Navigation
                  const _BottomNav(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF003D1A)),
            onPressed: () => Navigator.pop(context),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "Live Tracking",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF003D1A),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCEmP3IuyKf71_HNQiYs78RNI4Xc-H5ISvY27MaGV7KrdTrDCgnM6B5dmzaUyUo-0b_owHlSMcmAZSYKnjJmZKrS819sTiMY4hFFm0oIz8YWE8CSB5GHQeh3m6NOmMkXK7CS-0t-8cgw0iLTS8nN92fBGZYCt0Mh_h_aYHjgvHB60rUsCGpo04SqMnSIRTY9G5ZK2XEDNrREMWPpWvoV7F1HxRAMhADJMu37F30mM5YjA1oHo_Zk2lLPWzbXzsRFoLSYB9o66XnPJbY',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapArea() {
    return Container(
      color: const Color(0xFFE5E7EB),
      child: Stack(
        children: [
          // Map Grid
          CustomPaint(size: Size.infinite, painter: MapGridPainter()),

          // Route Path
          CustomPaint(size: Size.infinite, painter: RoutePainter()),

          // Technician Marker (animated)
          Positioned(
            left: MediaQuery.of(context).size.width * 0.42,
            top: MediaQuery.of(context).size.height * 0.38,
            child: _TechnicianMarker(controller: _controller),
          ),

          // Destination Pin
          const Positioned(
            right: 70,
            top: 140,
            child: Icon(
              Icons.location_pin,
              color: Color(0xFF003D1A),
              size: 42,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== ETA CARD ====================
class _ETACard extends StatelessWidget {
  const _ETACard();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(999),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.schedule, color: Color(0xFF006D38), size: 20),
            SizedBox(width: 6),
            Text(
              "12 mins",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF006D38),
                fontSize: 15,
              ),
            ),
            SizedBox(width: 14),
            Text("•", style: TextStyle(color: Colors.grey)),
            SizedBox(width: 14),
            Icon(Icons.straighten, color: Colors.grey, size: 18),
            SizedBox(width: 6),
            Text(
              "2.4 km",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== TECHNICIAN MARKER ====================
class _TechnicianMarker extends StatelessWidget {
  final AnimationController controller;

  const _TechnicianMarker({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulse rings
        ...List.generate(3, (index) {
          return AnimatedBuilder(
            animation: controller,
            builder: (_, _) {
              final value = controller.value;
              return Opacity(
                opacity: (1 - value) * (0.55 - index * 0.15),
                child: Container(
                  width: 40 + (value * 55),
                  height: 40 + (value * 55),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF94F4AD).withValues(alpha: 0.55),
                  ),
                ),
              );
            },
          );
        }),
        // Main marker
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFF003D1A),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Icon(
            Icons.local_shipping,
            color: Colors.white,
            size: 26,
          ),
        ),
      ],
    );
  }
}

// ==================== TECHNICIAN CARD ====================
class _TechnicianCard extends StatelessWidget {
  const _TechnicianCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.97),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Status + Progress
          const Row(
            children: [
              Text(
                "En Route",
                style: TextStyle(
                  color: Color(0xFF006D38),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Spacer(),
              Text(
                "Step 2 of 4",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _progressBar(true)),
              const SizedBox(width: 5),
              Expanded(child: _progressBar(true)),
              const SizedBox(width: 5),
              Expanded(child: _progressBar(false)),
              const SizedBox(width: 5),
              Expanded(child: _progressBar(false)),
            ],
          ),
          const SizedBox(height: 18),

          // Technician Info
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuA5ppWPqmoe9ZgywsZHtU7ScEnsjdVQ77eQRujY54FRdnwxjV4Uw4sd-DBXsBg5qozMtFAnSoaaqXrpKiQe2B8PEmMl0-HMRb3AECFZQSGOobuFyXDqfPdkQ63ZN0zHeg3linBf6d1PregagOgO1Gj6-ayMsVU7nENHuX6_pgeFqWyFKWVRO__ol1xcQBMUDTCZjQFzjikt9VRc_ZLWjRLjFvFSZu7sivQcZFx-KFLOALcIPhP3Z_9qBVHTZ-0YIc7o5nJhsZ0qfsww',
                  width: 58,
                  height: 58,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 58,
                    height: 58,
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
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "(128 reviews)",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call, size: 18),
                  label: const Text("Call"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF003D1A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat, size: 18),
                  label: const Text("Message"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF003D1A),
                    side: const BorderSide(color: Color(0xFF003D1A)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _progressBar(bool active) {
    return Container(
      height: 5,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF006D38) : const Color(0xFFE1E3DD),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

// ==================== BOTTOM NAV ====================
class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12, top: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home_outlined, label: "Home"),
          _NavItem(icon: Icons.add_circle, label: "Request", active: true),
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

// ==================== CUSTOM PAINTERS ====================
class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.13)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF94F4AD)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.5, size.height * 0.72)
      ..lineTo(size.width * 0.5, size.height * 0.52)
      ..lineTo(size.width * 0.72, size.height * 0.48)
      ..lineTo(size.width * 0.72, size.height * 0.28)
      ..lineTo(size.width * 0.28, size.height * 0.22);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}