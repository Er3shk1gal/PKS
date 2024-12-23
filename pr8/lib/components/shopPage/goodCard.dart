import 'package:flutter/material.dart';
import 'package:pr8/models/product.dart';
import 'package:pr8/models/shoppingcart.dart';

class GoodShopCard extends StatelessWidget {
  final Product post;
  final bool isLiked;
  final VoidCallback onToggleLike;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ShoppingCart cart;
  final VoidCallback onCartUpdated;

  const GoodShopCard({
    Key? key,
    required this.post,
    required this.isLiked,
    required this.onToggleLike,
    required this.onEdit,
    required this.onDelete,
    required this.cart,
    required this.onCartUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.imageURL != null)
            Image.network(
              post.imageURL!,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.name),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.description),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${post.price} руб.'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : null,
                  ),
                  onPressed: onToggleLike,
                ),
                Row(
                  children: [
                    if (cart.findGood(post.productID)) ...[
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cart.removeGood(post);
                          onCartUpdated();
                        },
                      ),
                      Text('${cart.goods.firstWhere((item) => item.productID == post.productID).stock}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cart.addGood(post);
                          onCartUpdated(); // Обновление состояния после добавления
                        },
                      ),
                    ] else ...[
                      ElevatedButton(
                        onPressed: () {
                          cart.addGood(post);
                          onCartUpdated(); // Обновление состояния после добавления
                        },
                        child: const Text('Add to Cart'),
                      ),
                    ],
                  ],
                ),
                const Spacer(),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'delete') {
                      onDelete();
                    }
                    if (value == 'edit') {
                      onEdit();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
