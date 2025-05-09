import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.onClose,
    required this.showContent,
  });

  final VoidCallback onClose;
  final bool showContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.green)),
          AnimatedPositioned(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            left: 0,
            right: 0,
            top: showContent ? 0 : MediaQuery.of(context).size.height,
            bottom: showContent ? 0 : -MediaQuery.of(context).size.height,

            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildCloseButton(), buildLogo()],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(50),
                      Text(
                        'About Us',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.white,
                        ),
                      ),

                      Gap(15),

                      Text(
                        'We are a creative branding agency that helps you build stable, structured and scalable brands. We think creatively, strategically and commercially, to generate inspiring, functional and result oriented design solutions. We create growth for our clients through persuasive designs & campaigns, engaged audiences and well executed brand experiences',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Gap(60),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Social Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Gap(25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Transform buildLogo() {
    return Transform.translate(
      offset: const Offset(0, -15),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            width: 150,
            child: SvgPicture.asset(
              'Assets/logo-white.svg',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildCloseButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.close_rounded),
            color: Colors.white,
            onPressed: onClose,
          ),
        ),
      ],
    );
  }
}
