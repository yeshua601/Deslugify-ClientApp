import 'package:flutter/material.dart';

class ServiceFeedbackScreen extends StatefulWidget {
  const ServiceFeedbackScreen({super.key});

  @override
  State<ServiceFeedbackScreen> createState() => _ServiceFeedbackScreenState();
}

class _ServiceFeedbackScreenState extends State<ServiceFeedbackScreen> {
  int _serviceRating = 0;
  int _operatorRating = 0;
  final TextEditingController _feedbackController = TextEditingController();
  final Set<String> _selectedTags = {};
  final List<String> _attachments = []; // Track multiple attachments

  // Constants for design consistency
  static const primaryColor = Color(0xFF006D38);
  static const backgroundColor = Color(0xFFF8FAF3);
  static const textColorDark = Color(0xFF003D1A);
  static const textColorMedium = Color(0xFF707970);
  static const lightGreen = Color(0xFF94F4AD);
  static const lightGrey = Color(0xFFC0C9BE);

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildServiceSummary(),
            const SizedBox(height: 32),
            _buildStarRating(
              title: "Rate the Service",
              rating: _serviceRating,
              onRatingChanged: (val) => setState(() => _serviceRating = val),
            ),
            const SizedBox(height: 12),
            _buildQuickTags(),
            const SizedBox(height: 32),
            _buildStarRating(
              title: "Rate the Field Operator",
              subtitle: "Professionalism & Efficiency",
              rating: _operatorRating,
              onRatingChanged: (val) => setState(() => _operatorRating = val),
            ),
            const SizedBox(height: 32),
            _buildTextFeedback(),
            const SizedBox(height: 32),
            _buildAttachmentSection(),
            const SizedBox(height: 40),
            _buildSubmitButtons(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white.withValues(alpha: 0.85),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Row(
        children: [
          Icon(Icons.eco, color: textColorDark),
          SizedBox(width: 8),
          Text("Deslugify", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service Feedback",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: textColorDark,
          ),
        ),
        Text(
          "Rate your completed Sipsip Poso Negro service experience",
          style: TextStyle(fontSize: 16, color: textColorMedium),
        ),
      ],
    );
  }

  Widget _buildServiceSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBQG35G7COCdYQirjKlkxBtZw-3rAoo4La9yMEETsvYKTMF5uJ2jtroykZWJsOQItSS2EZsbpkfNRiKILbKyALN5tyqGLCGwPV57MY3kZUC-p-d_j9K8o5UznJF2gwy782dyPycOTI-RDlhoMOSATFxGOcAvS2AVvZJm3tl5KiWQN2ZHsZzp7kGyhVW8-jm6WNP_cwI3xLVtEz8fvIVE47hbWUw-TTyYwcLNqZAxB0W_THoqCKDxfZhCnhdehliKyiid4muG87uIFp2',
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 64),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Marcus Thorne",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const Text(
                  "Lead Technician",
                  style: TextStyle(color: textColorMedium),
                ),
                Row(
                  children: [
                    const Icon(Icons.plumbing, size: 16, color: primaryColor),
                    const SizedBox(width: 6),
                    const Text("Sipsip Poso Negro", style: TextStyle(color: primaryColor)),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: lightGreen,
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              "Completed",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColorDark,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRating({
    required String title,
    String? subtitle,
    required int rating,
    required ValueChanged<int> onRatingChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Text(
              rating > 0 ? rating.toStringAsFixed(1) : "0.0",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        if (subtitle != null)
          Text(
            subtitle,
            style: const TextStyle(color: textColorMedium, fontSize: 14),
          ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final starValue = index + 1;
            return GestureDetector(
              onTap: () => onRatingChanged(starValue),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  starValue <= rating ? Icons.star : Icons.star_border,
                  size: 48,
                  color: starValue <= rating ? primaryColor : lightGrey,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildQuickTags() {
    final tags = const [
      "Fast response",
      "On-time arrival",
      "Good quality",
      "Professional equipment",
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        final isSelected = _selectedTags.contains(tag);
        return GestureDetector(
          onTap: () {
            setState(() {
              isSelected ? _selectedTags.remove(tag) : _selectedTags.add(tag);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? lightGreen : Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isSelected ? primaryColor : lightGrey,
              ),
            ),
            child: Text(
              tag,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected ? textColorDark : textColorMedium,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextFeedback() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Detailed Feedback",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _feedbackController,
          maxLines: 5,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: "Write your feedback here...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "${_feedbackController.text.length} / 500",
            style: const TextStyle(color: textColorMedium, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Attachment (Optional)",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _attachmentButton(Icons.add_a_photo, "ADD PHOTO", onPressed: _addPhoto),
            if (_attachments.isNotEmpty) ...[
              const SizedBox(width: 12),
              ..._attachments.take(2).map((url) => _buildAttachmentPreview(url)),
            ],
          ],
        ),
        if (_attachments.length > 2) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _attachments.skip(2).map((url) => _buildAttachmentPreview(url)).toList(),
          ),
        ],
      ],
    );
  }

  Widget _attachmentButton(IconData icon, String label, {VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: lightGrey, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: primaryColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentPreview(String url) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => _removeAttachment(url),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitFeedback,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Submit Feedback",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Icon(Icons.send),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "Skip for now",
            style: TextStyle(color: textColorMedium),
          ),
        ),
      ],
    );
  }

  void _addPhoto() {
    // In a real app, you would implement image picker logic here
    // For demo purposes, we'll add a placeholder image
    setState(() {
      if (_attachments.length < 5) { // Limit to 5 attachments
        _attachments.add('https://picsum.photos/id/${_attachments.length * 100}/200/200');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Maximum 5 attachments allowed')),
        );
      }
    });
  }

  void _removeAttachment(String url) {
    setState(() {
      _attachments.remove(url);
    });
  }

  void _submitFeedback() {
    // Validate and submit feedback
    if (_serviceRating == 0 && _operatorRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please rate at least one category')),
      );
      return;
    }

    // Process submission here (would normally be API call)
    final feedbackData = {
      'service_rating': _serviceRating,
      'operator_rating': _operatorRating,
      'feedback': _feedbackController.text,
      'tags': _selectedTags.toList(),
      'attachments': _attachments,
    };

    debugPrint('Submitting feedback: $feedbackData');
    Navigator.of(context).pop();
  }
}
