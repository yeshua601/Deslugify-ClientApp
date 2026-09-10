import 'package:flutter/material.dart';

class DeslugifyHomeScreen extends StatelessWidget {
  const DeslugifyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF3),
      body: Stack(
        children: [
          // Background
          _buildBackground(),

          // Content
          SafeArea(
            child: Column(
              children: [
                // App Bar
                _buildAppBar(),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildBrandHeader(),
                        const SizedBox(height: 32),
                        _buildHeroImage(context),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),

                // Bottom Action Panel
                _buildActionPanel(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.2, -0.3),
              radius: 1.2,
              colors: [
                Color(0xFFF4F7F5),
                Color(0xFFE8F5E9),
              ],
            ),
          ),
        ),
        Positioned(
          top: -120,
          right: -120,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              color: const Color(0xFF94F4AD).withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -150,
          left: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              color: const Color(0xFF93D69E).withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Image.network(
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDw3afp7Np-iCm1wRIP5dpMN6XgCY1nqpWGG-McQhGwOPdcfn2TxwLPBgzlMrnVPO-AnXz5IKTqiFW5sSedF2LMbufFZrJRvQ-w-vb0jfTm6iBKOIAi674HXDSFs3FJrS8SoHBJ-yXKLZaGT7SnPy_WQDnBEIyeceyqEoDRdlffJE2Bax96ZHxrHUgsGglTDztFKpkJmP8ZqbjZOBDaLfd_fUBUo_9KvBIQZT3TODTJi-TmCjIL9fWsE1USFpxIXQnTWa3hnlGjD7zH',
            height: 36,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.eco, size: 36, color: Color(0xFF003D1A));
            },
          ),
          const SizedBox(width: 10),
          const Text(
            "Deslugify",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003D1A),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.eco, color: Color(0xFF006D38)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBrandHeader() {
    return const Column(
      children: [
        Text(
          "PLATFORM EXCELLENCE",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
            color: Color(0xFF006D38),
          ),
        ),
        SizedBox(height: 12),
        Text(
          "Smart Environmental\nService Management",
          style: TextStyle(
            fontSize: 28,
            height: 1.15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF003D1A),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 14),
        Text(
          "Connecting infrastructure with nature through high-precision intelligence.",
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF707970),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.38;

    return Container(
      height: imageHeight.clamp(280.0, 420.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF12562B).withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Image.network(
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA-_HFnlbRBQdayGD92BKepUTifAnzIfXZsDiMBE-OpG4B59lmhp7k0dSbFeKf2SmkNH1CO5LVC7r-EDYN0EvsTq_kPGBcrmf8eXkBjHV4DYighLYfH-50X0Z1XAcGmMz318i4dsYuPQIthUxrSNsTg2PDbDdY1vvwpZDfEMLeQJkjCGAQ1S1QzMimXcGWhIVz3tEx5uxW_u6pH2CEHuuMTJ2_aMjmC8R3cJc7IV839iJi1VsMvINPQ1LeIVFJVcAVe1FNwgit5lZ6P',
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFFE1E3DD),
              child: const Center(
                child: Icon(
                  Icons.forest,
                  size: 64,
                  color: Color(0xFF006D38),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionPanel(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Get Started → Login
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF12562B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Learn More
          GestureDetector(
            onTap: () {},
            child: const Text(
              "Learn More about Deslugify",
              style: TextStyle(
                color: Color(0xFF006D38),
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}