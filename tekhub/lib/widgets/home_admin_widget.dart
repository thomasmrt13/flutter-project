import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/provider/provider_listener.dart';
import 'package:tekhub/widgets/search/search_bar.dart';
import 'package:tekhub/widgets/search_result.dart';

class HomeAdminWidget extends StatefulWidget {
  const HomeAdminWidget({super.key});

  @override
  HomeAdminWidgetState createState() => HomeAdminWidgetState();
}

class HomeAdminWidgetState extends State<HomeAdminWidget> {
  Future<void> getArticles() async {
    final List<Article> articles = <Article>[
      Article(
        id: '1',
        name: 'Iphone 12',
        price: 525,
        description: 'Iphone 12',
        type: ArticleType.phone,
        imageUrl: 'assets/images/logo.png',
      ),
      Article(
        id: '2',
        name: 'Ipad Pro',
        price: 790,
        description: 'Ipad Pro 2021',
        type: ArticleType.tablet,
        imageUrl: 'assets/images/logo.png',
      ),
      Article(
        id: '3',
        name: 'Iphone 14 Pro',
        price: 950,
        description: 'Iphone 14 Pro Max',
        type: ArticleType.phone,
        imageUrl: 'assets/images/logo.png',
      ),
      Article(
        id: '4',
        name: 'Macbook Pro',
        price: 359,
        description: 'Macbook Pro 2022',
        type: ArticleType.laptop,
        imageUrl: 'assets/images/logo.png',
      ),
    ];
    Provider.of<ProviderListener>(context, listen: false)
        .updateArticles(articles);
  }

  @override
  Widget build(BuildContext context) {
    getArticles();

    // Function to show the modal
    void _showModal() {
      final List<bool> _selectedType = <bool>[true, false, false];
      int _selectedTypeIndex = 0;
      TextEditingController titleController = TextEditingController();
      TextEditingController priceController = TextEditingController();
      TextEditingController descriptionController = TextEditingController();

      const List<Widget> type = <Widget>[
        Text('Iphone'),
        Text('Laptop'),
        Text('Tablet')
      ];

      String _getSelectedType() {
        switch (_selectedTypeIndex) {
          case 0:
            return 'phone';
          case 1:
            return 'laptop';
          case 2:
            return 'tablet';
          default:
            return '';
        }
      }

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Add a product',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.height * 0.45,
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 126, 217, 87))),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Title",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text('Device Type'),
                    const SizedBox(height: 5),
                    ToggleButtons(
                      direction: Axis.horizontal,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedType.length; i++) {
                            _selectedType[i] = i == index;
                          }
                          // Update the selected type index
                          _selectedTypeIndex = index;
                          print(_getSelectedType());
                          // TODO: Modify UI based on the selected type
                          // For example, update Text or other widgets
                        });
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Color.fromARGB(255, 126, 217, 87),
                      borderWidth: 2,
                      selectedColor: Colors.white,
                      fillColor: Color(0xFF272727),
                      color: Color(0xFF272727),
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 80.0,
                      ),
                      isSelected: _selectedType,
                      children: type,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.height * 0.45),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 126, 217, 87))),
                      child: TextField(
                        controller: priceController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Price",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.height * 0.45,
                        maxHeight: MediaQuery.of(context).size.height * 0.3,
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 126, 217, 87),
                        ),
                      ),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.2, // Adjust the height according to your needs
                        child: TextField(
                          controller: descriptionController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Description",
                              focusedBorder: OutlineInputBorder()),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Aligns buttons at the center horizontally
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF272727),
                              fixedSize: Size(
                                MediaQuery.of(context).size.height * 0.25,
                                MediaQuery.of(context).size.height * 0.01,
                              ),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 126, 217, 87),
                                ),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Icon(Icons.add_photo_alternate,
                                    size: 24), // Replace with your icon
                                SizedBox(
                                    width:
                                        8), // Adjust spacing between icon and text
                                Text('Add pictures'),
                              ],
                            ),
                          ),

                          SizedBox(
                              width: 10), // Adding some space between buttons
                          ElevatedButton(
                            onPressed: () {
                              // Retrieve values from controllers
                              String title = titleController.text;
                              String price = priceController.text;
                              String description = descriptionController.text;

                              // Use these values as needed
                              // For example, you can print them
                              print(
                                'Title: $title, Price: $price, Description: $description, type: ' +
                                    _getSelectedType(),
                              );

                              // Close the modal bottom sheet
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF272727),
                              fixedSize: Size(
                                  MediaQuery.of(context).size.height * 0.2, 30),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 126, 217, 87),
                                ),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    ),

                    // Add more ListTile widgets or customize as needed
                  ],
                );
              },
            ),
          );
        },
      );
    }

    return Consumer<ProviderListener>(
      builder: (
        BuildContext context,
        ProviderListener providerListener,
        Widget? child,
      ) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 62),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SearchBarComponent(),
                    ],
                  ),
                ),
              ),
              SearchResult(
                searchtext: providerListener.searchtext,
                articles: providerListener.articles,
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF272727),
            onPressed: _showModal,
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 126, 217, 87),
            ), // You can use any icon here
          ),
        );
      },
    );
  }
}
