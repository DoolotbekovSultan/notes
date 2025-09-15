import 'package:flutter/material.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252525),
      body: Column(
        children: [
          Align(
            child: Text(
              "Пропустить",
              style: TextStyle(
                color: Color(0xFFD88B02),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
#D88B02 - оранжевый(primary)
#5B5B5B - серый(secondary)
#252525 - темно серый backgraund
#353535 - средний серый
#535353 - чуть темнне серый surface
#434343 = 
*/
