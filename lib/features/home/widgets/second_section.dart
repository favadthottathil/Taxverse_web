import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SecondSection extends StatefulWidget {
  const SecondSection({super.key, required this.controller});

  final ScrollController controller;

  @override
  State<SecondSection> createState() => _SecondSectionState();
}

class _SecondSectionState extends State<SecondSection>
    with TickerProviderStateMixin {
  final GlobalKey _targetKey = GlobalKey();
  late AnimationController _animationController;

  late Animation<double> _slideOffset;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Small slide animation (20px right to original position)
    _slideOffset = Tween<double>(
      begin: -20.0, // Start 20px to the left
      end: 0.0, // End at original position
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0, // Fully transparent
      end: 1.0, // Fully opaque
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Listen to scroll events
    widget.controller.addListener(_checkVisibility);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(80),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_slideOffset.value, 0),
                child: Opacity(opacity: _fadeAnimation.value, child: child),
              );
            },
            child: Column(
              key: _targetKey,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WE ARE A CREATIVE BRANDING AGENCY',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(20),
                Text(
                  'We are a creative branding agency that helps you build stable, struct',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Gap(60),
          Row(
            children: [
              // First hover widget
              Expanded(child: HoverWidget()),
              Gap(40),
              // Second hover widget
              Expanded(child: HoverWidget()),
              Gap(40),
              // Third hover widget
              Expanded(child: HoverWidget()),
            ],
          ),
        ],
      ),
    );
  }

  void _checkVisibility() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox =
          _targetKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final position = renderBox.localToGlobal(Offset.zero);
      final scrollPosition = widget.controller.position;
      final viewportHeight = scrollPosition.viewportDimension;
      final scrollOffset = scrollPosition.pixels;

      // Check if the widget is within the visible scroll area
      bool isVisible =
          position.dy + renderBox.size.height > scrollOffset &&
          position.dy < scrollOffset + viewportHeight;

      if (isVisible && !_animationController.isAnimating) {
        _animationController.forward();
      } else if (!isVisible &&
          _animationController.status == AnimationStatus.completed) {
        // _animationController.reverse();
      }
    });
  }
}

class HoverWidget extends StatefulWidget {
  const HoverWidget({super.key});

  @override
  State<HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<Offset>(
      begin: const Offset(-1.0, 0),
      end: const Offset(1.0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _handleHover(true),
      onExit: (event) => _handleHover(false),
      child: Container(
        height: 550,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.amber,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              // Slide transition container
              SlideTransition(
                position: _animation,
                child: Container(
                  height: 550,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleHover(bool isHovered) {
    if (isHovered) {
      // Animate to midpoint (0.5) for left-to-center transition
      _controller.animateTo(0.5);
    } else {
      // Animate to end (1.0) for center-to-right transition
      _controller.animateTo(1.0).then((_) {
        // Reset controller after completing right exit
        _controller.reset();
      });
    }
  }
}
