import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tekhub/Firebase/actions/result.dart';
import 'package:tekhub/Firebase/models/articles.dart';
import 'package:tekhub/firebase/actions/article_service.dart';

Future<void> showEditDialog(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController priceController,
    TextEditingController descriptionController,
    Article article,) async {
  final ArticleService articleService = ArticleService();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit article'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final Result<dynamic> result = await articleService.updateArticle(
                articleId: article.id,
                name: titleController.text,
                price: double.parse(priceController.text),
                imageUrl: article.imageUrl,
                description: descriptionController.text,
              );
              if (result.success) {
                if (!context.mounted) return;
                Navigator.pop(context);
                // await onValidationButtonPressed();
                if (!context.mounted) return;
                await Navigator.pushNamed(context, '/');
              } else {
                if (!context.mounted) return;
                // Registration failed, show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(result.message.toString()),
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
