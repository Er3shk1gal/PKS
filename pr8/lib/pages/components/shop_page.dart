import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pr8/components/shopPage/createPostDialog.dart';
import 'package:pr8/components/shopPage/editPostDialog.dart';
import 'package:pr8/components/shopPage/goodCard.dart';
import 'package:pr8/models/cart.dart';
import 'package:pr8/models/goods.dart';
import 'package:pr8/models/likedgoods.dart';
import 'package:pr8/models/product.dart';
import 'package:pr8/models/shoppingcart.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Goods goods = Goods(userId: 1);
  LikedGoods favoriteGoods = LikedGoods(userId: 1);
  ShoppingCart cart = ShoppingCart(userId: 1);

  @override
  void initState() {
    super.initState();
    _loadGoods();
    _loadCart();
  }

  void _loadGoods() {
    final goods = Provider.of<Goods>(context, listen: false);
    _loadLiked();
    setState(() {
      this.goods = goods;
    });
  }

  void _loadLiked() {
    final favoriteGoods = Provider.of<LikedGoods>(context, listen: false);
    setState(() {
      this.favoriteGoods = favoriteGoods;
    });
  }

  void _loadCart() {
    final cart = Provider.of<ShoppingCart>(context, listen: false);
    setState(() {
      this.cart = cart;
    });
  }

  void _toggleLike(Product post) {
    if (favoriteGoods.findGood(post.productID)) {
      favoriteGoods.removeGood(post);
    } else {
      favoriteGoods.addGood(post);
    }
    _loadGoods();
    _loadLiked();
  }

  void _editPost(int postId) async {
    final post = goods.goods.firstWhere((post) => post.productID == postId);
    await showDialog(
      context: context,
      builder: (context) {
        return EditPostDialog(post: post, onSave: (updatedPost) {
          setState(() {
            goods.updateGood(updatedPost);
          });
          _loadGoods();
        });
      },
    );
  }

  void _deletePost(int postId) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm) {
      final postToDelete = goods.goods.firstWhere((post) => post.productID == postId);
      favoriteGoods.removeGood(postToDelete);
      goods.removeGood(postToDelete);
      _loadGoods();
      _loadLiked();
    }
  }

  void _createPost() async {
    await showDialog(
      context: context,
      builder: (context) {
        return CreatePostDialog(onCreate: (newPost) {
          setState(() {
            goods.addGood(newPost);
          });
          _loadGoods();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createPost,
          ),
        ],
      ),
      body: goods.goods.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 1,
              ),
              itemCount: goods.goods.length,
              itemBuilder: (context, index) {
                final post = goods.goods[index];
                return GoodShopCard(
                  post: post,
                  isLiked: favoriteGoods.findGood(post.productID),
                  onToggleLike: () => _toggleLike(post),
                  onEdit: () => _editPost(post.productID),
                  onDelete: () => _deletePost(post.productID),
                  cart: cart,
                  onCartUpdated: () => _loadCart(),
                );
              },
            ),
    );
  }
}
