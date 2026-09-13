import 'package:flutter/material.dart';
import 'live_map_widget.dart';

class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF3),
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF003D1A)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Live Tracking',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003D1A),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // MAP fills remaining space above bottom card
            const Expanded(
              child: LiveMapWidget(),
            ),

            // ETA strip
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.schedule, color: Color(0xFF006D38), size: 20),
                  SizedBox(width: 6),
                  Text(
                    '12 mins',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006D38),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text('•  2.4 km', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            // Technician card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    children: [
                      Text(
                        'En Route',
                        style: TextStyle(
                          color: Color(0xFF006D38),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text('Step 2 of 4',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuA5ppWPqmoe9ZgywsZHtU7ScEnsjdVQ77eQRujY54FRdnwxjV4Uw4sd-DBXsBg5qozMtFAnSoaaqXrpKiQe2B8PEmMl0-HMRb3AECFZQSGOobuFyXDqfPdkQ63ZN0zHeg3linBf6d1PregagOgO1Gj6-ayMsVU7nENHuX6_pgeFqWyFKWVRO__ol1xcQBMUDTCZjQFzjikt9VRc_ZLWjRLjFvFSZu7sivQcZFx-KFLOALcIPhP3Z_9qBVHTZ-0YIc7o5nJhsZ0qfsww',
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            width: 52,
                            height: 52,
                            color: const Color(0xFFE1E3DD),
                            child: const Icon(Icons.person,
                                color: Color(0xFF006D38)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Marcus Chen',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003D1A),
                              ),
                            ),
                            Text(
                              'Lead Technician · 4.9★',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF707970),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/live-call'),
                          icon: const Icon(Icons.call, size: 18),
                          label: const Text('Call'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF003D1A),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/messages'),
                          icon: const Icon(Icons.chat, size: 18),
                          label: const Text('Message'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF003D1A),
                            side: const BorderSide(color: Color(0xFF003D1A)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}