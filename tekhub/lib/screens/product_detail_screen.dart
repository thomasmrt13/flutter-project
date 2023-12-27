import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/Firebase/models/users.dart';
import 'package:tekhub/provider/provider_listener.dart';
import 'package:tekhub/widgets/button.dart';
import 'package:tekhub/widgets/edit_dialog.dart';

class SingleItem extends StatefulWidget {
  const SingleItem({required this.article, super.key});
  final Article article;

  @override
  SingleItemState createState() => SingleItemState();
}

class SingleItemState extends State<SingleItem> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.article.name);
    priceController = TextEditingController(text: widget.article.price.toString());
    descriptionController = TextEditingController(text: widget.article.description);
  }

  @override
  Widget build(BuildContext context) {
    final MyUser user = Provider.of<ProviderListener>(context).user;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        body: SingleChildScrollView(
          child: Column(
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
                    if (user.role != 'user')
                      Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () async {
                              await showEditDialog(context, nameController, priceController, descriptionController, widget.article);
                            },
                            icon: const Icon(
                              CupertinoIcons.pencil_ellipsis_rectangle,
                            ),
                            color: const Color.fromARGB(255, 126, 217, 87),
                          ),
                          IconButton(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    surfaceTintColor: Colors.white,
                                    title: const Text(
                                      'Alert',
                                      style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                      'Are you sure you want to delete this item ?',
                                      style: TextStyle(fontFamily: 'Raleway'),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold, color: Colors.red),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await Navigator.pushNamed(context, '/');
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold, color: Colors.green),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.trash,
                            ),
                            color: const Color.fromARGB(255, 126, 217, 87),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 300,
              height: 280,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: CarouselWithIndicatorDemo(articleImage: article.imageUrl,),
              ),
              const SizedBox(
                height: 20,
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
                            widget.article.name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                            ),
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
                          child: Text(
                            article.description,
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 5, left: 45, right: 10),
                      //   child: Text(
                      //     article.description,
                      //     style: const TextStyle(
                      //       fontFamily: 'Raleway',
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 17,
                      //       color: Colors.black38,
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   alignment: Alignment.topLeft,
                      //   padding: const EdgeInsets.only(left: 45),
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.all(0), elevation: 0),
                      //     onPressed: () {},
                      //     child: const Text(
                      //       'Full description ->',
                      //       style: TextStyle(color: Color.fromARGB(255, 126, 217, 87), fontSize: 15, fontWeight: FontWeight.w700, fontFamily: 'Raleway'),
                      //     ),
                      //   ),
                      // ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({required this.articleImage, super.key});

  final String articleImage;

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
              items: <Widget>[
                Image(
                  image: AssetImage(widget.articleImage),
                ),
                Image(
                  image: AssetImage(widget.articleImage),
                ),
                Image(
                  image: AssetImage(widget.articleImage),
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
              Image(
                image: AssetImage(widget.articleImage),
              ),
              Image(
                image: AssetImage(widget.articleImage),
              ),
              Image(
                image: AssetImage(widget.articleImage),
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
