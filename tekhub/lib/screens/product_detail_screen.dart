import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/widgets/button.dart';

class SingleItem extends StatelessWidget {
  const SingleItem({required this.article, super.key});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(CupertinoIcons.back),
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 300,
              height: 280,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: CarouselWithIndicatorDemo(),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              height: MediaQuery.of(context).size.height * 0.51,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          article.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Padding(
                          padding:
                              EdgeInsets.only(left: 39, top: 12, bottom: 5),
                          child: Text(
                            'Price',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              fontFamily: 'Raleway',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 39, bottom: 10),
                          child: Text(
                            '${article.price}€',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 126, 217, 87),
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 45),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Get Apple TV+ free for a year',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5, left: 45, right: 10),
                        child: Text(
                          'Available when you purchase any new iPhone, iPad, iPod Touch, Mac or Apple TV, £4.99/',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 45),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Full description ->',
                            style: TextStyle(
                              color: Color.fromARGB(255, 126, 217, 87),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Button(
                          text: 'Add to cart',
                          color: const Color.fromARGB(255, 39, 39, 39),
                          width: MediaQuery.of(context).size.width * 0.7,
                          onClick: () {},
                          height: 60,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: CarouselSlider(
              items: const <Widget>[
                Image(
                  image: AssetImage('assets/images/ipad.png'),
                ),
                Image(
                  image: AssetImage('assets/images/ipad.png'),
                ),
                Image(
                  image: AssetImage('assets/images/ipad.png'),
                ),
              ],
              carouselController: _controller,
              options: CarouselOptions(
                height: 240,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2,
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Image>[
              const Image(
                image: AssetImage('assets/images/ipad.png'),
              ),
              const Image(
                image: AssetImage('assets/images/ipad.png'),
              ),
              const Image(
                image: AssetImage('assets/images/ipad.png'),
              ),
            ].asMap().entries.map((MapEntry<int, Image> entry) {
              return GestureDetector(
                onTap: () async => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12,
                  height: 12,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 39, 39, 39)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
