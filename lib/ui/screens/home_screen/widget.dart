import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<Widget> carouselWidgetList = [
    carouselWidgets('assets/images/banner/watm_banner.png'),
    // carouselWidgets('assets/images/banner/ohiya_banner.png'),
    carouselWidgets('assets/images/banner/wow_banner.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: carouselWidgetList,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayInterval: Duration(seconds: 5),
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 1.8,
              initialPage: 2,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselWidgetList.asMap().entries.map((entry) {
                return Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                );
              }).toList(),
            ),
          ],
        ),
      ],
    );
  }
}

Widget carouselWidgets(String imageLoction) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image:
            DecorationImage(image: AssetImage(imageLoction), fit: BoxFit.fill),
      ),
    ),
  );
}

Widget homeScreenCard(Size size, String image, String text,
    {Color color = Colors.blue}) {
  return Material(
    color: color.withOpacity(0.8),
    elevation: 10,
    borderRadius: BorderRadius.circular(20),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Material(
            shape: const CircleBorder(),
            color: Colors.grey.shade200,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: size.width * 0.15,
                height: size.width * 0.15,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
                      height: size.width * 0.12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Material(
            color: Colors.blue,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget prePaidCardWidget(Size size) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
              colors: [Colors.white, Colors.transparent],
              begin: Alignment.bottomLeft),
          color: Colors.black.withOpacity(0.8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/prepaid_card.png',
                height: 80,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                color: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {},
                child: const Text(
                  'RECHAEGE',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                color: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {},
                child: const Text(
                  'TOPUP LOG',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              MaterialButton(
                color: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {},
                child: const Text(
                  'TXN LOG',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
