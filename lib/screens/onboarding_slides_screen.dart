import 'package:flutter/material.dart';

class OnboardingSlidesScreen extends StatefulWidget {
  const OnboardingSlidesScreen({super.key});

  @override
  _OnboardingSlidesScreenState createState() => _OnboardingSlidesScreenState();
}

class _OnboardingSlidesScreenState extends State<OnboardingSlidesScreen> with SingleTickerProviderStateMixin {
  int _currentPage = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500), // Adjust duration for smoothness
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    setState(() {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0; // Reset to the first slide
      }
      _controller.forward(from: 0.0); // Restart the animation
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Static background container
          Container(
            color: Colors.white,
            child: Column(
              children: [
                // The text section that will be revealed
                if (_currentPage != 0) buildTextContainer(),
                // The rest of the space
                Expanded(child: Container()),
              ],
            ),
          ),
          // The black overlay that slides down
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500), // Adjust duration for smoothness
            top: _currentPage == 0 ? 0 : 240,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(48)),
              child: Container(
                color: Colors.black,
                child: FadeTransition(
                  opacity: _animation,
                  child: Stack(
                    children: [
                      buildSlideContent(),
                      if (_currentPage == 0)
                        Positioned(
                          bottom: 32,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(32),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/onboarding_slides_image1.png',
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 200), // Space below the image
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // The button and page indicator that remain fixed
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                buildPageIndicator(),
                buildNextButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlideContent() {
    if (_currentPage == 0) {
      return buildFirstSlideContent();
    } else {
      return buildOtherSlidesContent();
    }
  }

  Widget buildFirstSlideContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 75.0),
          child: buildText(
            'We all got no time to make notes of each and every Subject',
            Colors.white,
          ),
        ),
        const Spacer(), // Space to push the image to the bottom
        const SizedBox(height: 16), // Space between text and image
      ],
    );
  }

  Widget buildOtherSlidesContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                _currentPage == 1
                    ? 'assets/onboarding_slides_image2.png'
                    : 'assets/onboarding_slides_image3.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(height: 400), // Space below the image
      ],
    );
  }

  Widget buildTextContainer() {
    switch (_currentPage) {
      case 1:
        return buildTextSection('Sell Your Hardwork Handwritten Notes', true);
      case 2:
        return buildTextSection('Buy Notes and Excel Exams', true);
      default:
        return buildTextSection(
            'We all got no time to make notes of each and every Subject',
            false);
    }
  }

  Widget buildTextSection(String text, bool isTextOnWhiteBackground) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 240,
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 64),
      child: buildText(text, Colors.black),
    );
  }

  Widget buildText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'ClashDisplayVariable',
        color: color,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget buildPageIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) => buildIndicator(index)),
      ),
    );
  }

  Widget buildIndicator(int pageIndex) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: _currentPage == pageIndex ? 45 : 20,
      height: 8.0,
      decoration: BoxDecoration(
        color: _currentPage == pageIndex
            ? const Color(0xFFA883C5)
            : const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  Widget buildNextButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 70),
      child: ElevatedButton(
        onPressed: _nextPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA883C5),
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
              fontFamily: 'ClashDisplayVariable',
              color: Colors.white,
              fontSize: 18.0),
        ),
      ),
    );
  }
}
