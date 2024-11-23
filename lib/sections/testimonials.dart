import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Testimonials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Testimonials',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        CarouselSlider(
          options: CarouselOptions(height: 200),
          items: ['Testimonial 1', 'Testimonial 2', 'Testimonial 3']
              .map((item) => Container(
                    child: Center(child: Text(item)),
                    color: Colors.grey[200],
                  ))
              .toList(),
        ),
      ],
    );
  }
}
