import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pr6/components/shopPage/createPostDialog.dart';
import 'package:pr6/components/shopPage/editPostDialog.dart';
import 'package:pr6/components/shopPage/goodCard.dart';
import 'package:pr6/models/cart.dart';
import 'package:pr6/models/goods.dart';
import 'package:pr6/models/liked_goods.dart';
import 'package:provider/provider.dart';
import '../../models/good.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Goods goods = Goods();
  LikedGoods favoriteGoods = LikedGoods();
  Cart cart = Cart();

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
    final cart = Provider.of<Cart>(context, listen: false);
    setState(() {
      this.cart = cart;
    });
  }

  void _toggleLike(Good post) {
    if (favoriteGoods.findGood(post.title)) {
      favoriteGoods.removeGood(post);
    } else {
      favoriteGoods.addGood(post);
    }
    _loadGoods();
    _loadLiked();
  }

  void _editPost(int postId) async {
    final post = goods.goods.firstWhere((post) => post.id == postId);
    await showDialog(
      context: context,
      builder: (context) {
        return EditPostDialog(post: post, onSave: (updatedPost) {
          setState(() {
            goods.goods[goods.goods.indexOf(post)] = updatedPost;
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
      final postToDelete = goods.goods.firstWhere((post) => post.id == postId);
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
        title: const Text('Shop'),
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
                  isLiked: favoriteGoods.findGood(post.title),
                  onToggleLike: () => _toggleLike(post),
                  onEdit: () => _editPost(post.id),
                  onDelete: () => _deletePost(post.id),
                  cart: cart,
                  onCartUpdated: () => _loadCart(),
                );
              },
            ),
    );
  }
}
