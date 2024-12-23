import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pr8/components/favouritesPage/goodCart.dart';
import 'package:pr8/models/likedgoods.dart';
import 'package:pr8/models/product.dart';
import 'package:pr8/models/user.dart';
import 'package:provider/provider.dart';
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late LikedGoods favoriteGoods;

  @override
  void initState() {
    super.initState();
    _loadFavoritePosts();
  }

  void _loadFavoritePosts() {
    setState(() {
      favoriteGoods = Provider.of<LikedGoods>(context, listen: false);
    });
  }

  void _toggleFavorite(Product good) {
    if (favoriteGoods.findGood(good.productID)) {
      favoriteGoods.removeGood(good);
    } else {
      favoriteGoods.addGood(good);
    }
    _loadFavoritePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteGoods.goods.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _buildFavoritesGrid(),
    );
  }

  Widget _buildFavoritesGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: favoriteGoods.goods.length,
      itemBuilder: (context, index) {
        final good = favoriteGoods.goods[index];
        return GoodCard(
          good: good,
          onToggleFavorite: _toggleFavorite,
        );
      },
    );
  }
}