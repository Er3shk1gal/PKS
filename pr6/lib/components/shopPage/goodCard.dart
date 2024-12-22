import 'package:flutter/material.dart';
import 'package:pr6/models/cart.dart';
import 'package:pr6/models/good.dart';

class GoodShopCard extends StatelessWidget {
  final Good post;
  final bool isLiked;
  final VoidCallback onToggleLike;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Cart cart;
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
          if (post.filePath != null)
            Image.network(
              post.filePath!,
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.title),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.content),
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
                    if (cart.goods.any((item) => item.title == post.title)) ...[
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cart.removeGood(post);
                          onCartUpdated(); // Обновление состояния после удаления
                        },
                      ),
                      Text('${cart.goods.firstWhere((item) => item.title == post.title).amount}'),
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
