import 'package:flutter/material.dart';

class ScheduleServiceScreen extends StatefulWidget {
  const ScheduleServiceScreen({super.key});

  @override
  State<ScheduleServiceScreen> createState() => _ScheduleServiceScreenState();
}

class _ScheduleServiceScreenState extends State<ScheduleServiceScreen> {
  final _nameController = TextEditingController(text: 'John Domingo');
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _descriptionController = TextEditingController(
    text: 'Potential septic overflow detected. Visible surface pooling and dark soil saturation around tank lid.',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF3),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Schedule Service',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Color(0xFF003D1A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fill in the details below to request a professional desludging team to your location.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF707970),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),

            _label('FULL NAME'),
            const SizedBox(height: 8),
            _inputField(
              controller: _nameController,
              hint: 'John Domingo',
            ),
            const SizedBox(height: 20),

            _label('ADDRESS'),
            const SizedBox(height: 8),
            _inputField(
              controller: _addressController,
              hint: 'e.g 123 Malabon St. Quezon City',
            ),
            const SizedBox(height: 20),

            _label('CONTACT NUMBER'),
            const SizedBox(height: 8),
            _inputField(
              controller: _contactController,
              hint: 'e.g. 0917 123 4567',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _label('DESCRIPTION OF ISSUE'),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    '[Edit]',
                    style: TextStyle(
                      color: Color(0xFF006D38),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE1E3DD)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _descriptionController,
                    maxLines: 4,
                    maxLength: 500,
                    style: const TextStyle(fontSize: 14, color: Color(0xFF191D19)),
                    decoration: const InputDecoration(
                      hintText: 'Pre-filled from the AI',
                      hintStyle: TextStyle(color: Color(0xFF9AA39A)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(16, 14, 16, 8),
                      counterText: '',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_descriptionController.text.length}/500',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9AA39A),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              '*Pre-filled from the AI',
              style: TextStyle(fontSize: 12, color: Color(0xFF9AA39A)),
            ),
            const SizedBox(height: 24),

            _label('SITE PHOTOS (REQUIRED)'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _photoSlot()),
                const SizedBox(width: 12),
                Expanded(child: _photoSlot()),
                const SizedBox(width: 12),
                Expanded(child: _photoSlot()),
              ],
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/upload-images');
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
                  'Continue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'By submitting, you agree to our Service Terms\nand local environmental regulations.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Color(0xFF9AA39A), height: 1.4),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF8FAF3),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: const Padding(
        padding: EdgeInsets.only(left: 12),
        child: Icon(Icons.eco, color: Color(0xFF003D1A), size: 28),
      ),
      title: const Text(
        'Desludgify',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF003D1A),
          fontSize: 18,
        ),
      ),
      centerTitle: false,
      titleSpacing: 4,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Color(0xFF003D1A)),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Color(0xFF707970),
        letterSpacing: 0.4,
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 15, color: Color(0xFF191D19)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9AA39A), fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE1E3DD)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE1E3DD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF006D38), width: 1.5),
        ),
      ),
    );
  }

  Widget _photoSlot() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE1E3DD), style: BorderStyle.solid),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_photo_alternate_outlined, color: Color(0xFF9AA39A), size: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE8EBE6))),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_outlined, 'Home', false, () {
                Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
              }),
              _navItem(Icons.add_circle, 'Request', true, () {}),
              _navItem(Icons.assignment_outlined, 'Task', false, () {
                Navigator.pushNamed(context, '/request-history');
              }),
              _navItem(Icons.notifications_outlined, 'Alerts', false, () {
                Navigator.pushNamed(context, '/messages');
              }),
              _navItem(Icons.person_outline, 'Profile', false, () {
                Navigator.pushNamed(context, '/profile');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool active, VoidCallback onTap) {
    final color = active ? const Color(0xFF006D38) : const Color(0xFF707970);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
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