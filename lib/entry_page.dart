
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/actions_button.dart';
import 'widgets/nav_bar.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: theme.background,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                _buildOnboardingPage(
                  context,
                  theme,
                  title: 'Hello Coordies,\nAnd Whoever is\nReviewing It',
                  imageUrl:
                      'https://i.pinimg.com/originals/78/d9/da/78d9daee2f7de40c23c7790837d59d5a.jpg',
                ),
                _buildOnboardingPage(
                  context,
                  theme,
                  title:
                      'Some of the not so \n random photos.\n Have been like this\n in the pre-midsems.',
                  imageUrl:
                      'https://i.pinimg.com/originals/36/a2/d0/36a2d01b71d30527abf62fcf25f8f479.jpg',
                  isWhiteText: true, // Text will be white on this page
                ),
                _buildOnboardingPage(
                  context,
                  theme,
                  title:
                      'Anyways, I am highly\n enthusiastic for \n Inter-IIT. So let\'s...',
                  imageUrl:
                      'https://i.pinimg.com/originals/cc/45/8d/cc458d7cf1ac36048f0f53088195842d.jpg',
                  showButton:
                      true, // "Get Started" button will show only on this page
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                    expansionFactor: 4,
                    spacing: 8,
                    radius: 8,
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: theme.primary.withOpacity(0.3),
                    activeDotColor: theme.primary,
                    paintStyle: PaintingStyle.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(
    BuildContext context,
    ColorScheme theme, {
    required String title,
    required String imageUrl,
    bool isWhiteText = false,
    bool showButton = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image:
              NetworkImage(imageUrl), // Use NetworkImage for the external URL
        ),
      ),
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          children: [
            const SizedBox(height: 100), // Adds space at the top
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24, // Smaller font size
                  fontWeight: FontWeight.w600,
                  color: isWhiteText
                      ? Colors.white
                      : theme.onBackground, // Text color
                ),
              ),
            ),
            SizedBox(height: 50),
            if (showButton)
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Action_Buttons(
                  context: context,
                  label: 'Grab The Gold',
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavPage(
                                selectedIndex: 0,
                              )),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
