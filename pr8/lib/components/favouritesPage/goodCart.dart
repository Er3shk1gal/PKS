import 'package:flutter/material.dart';
import 'package:pr8/models/product.dart';

class GoodCard extends StatelessWidget {
  final Product good;
  final Function(Product) onToggleFavorite;

  const GoodCard({
    Key? key,
    required this.good,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (good.imageURL != null)
            Image.network(
              good.imageURL!,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(good.name),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(good.description),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${good.price} руб.'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () => onToggleFavorite(good),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}