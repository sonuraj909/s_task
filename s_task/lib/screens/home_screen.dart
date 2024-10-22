import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/home_screen_model.dart';
import 'package:s_task/models/home_screen_model.dart' as model;

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Fish Market'),
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        HomeData? homeDataValue = homeController.homeData.value.data;

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMainSlider(homeDataValue!.mainSlider),
                const SizedBox(height: 16),
                _buildNearestStore(homeDataValue.nearestStore),
                const SizedBox(height: 16),
                _buildAnimatedSection(
                  title: 'Trending Products',
                  child: _buildTrendingProducts(homeDataValue.trendingProducts),
                ),
                const SizedBox(height: 16),
                _buildAnimatedSection(
                  title: 'Categories',
                  child: _buildCategories(homeDataValue.categories),
                ),
                const SizedBox(height: 16),
                _buildAnimatedSection(
                  title: 'Product Listings',
                  child: _buildListings(homeDataValue.listings),
                ),
                const SizedBox(height: 16),
                _buildAnimatedSection(
                  title: 'Stores',
                  child: _buildStores(homeDataValue.stores),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildMainSlider(List<model.Slider> sliderImages) {
    if (sliderImages.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.easeInOut,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
      ),
      items: sliderImages.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                image.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildNearestStore(Store? nearestStore) {
    if (nearestStore == null) {
      return const ListTile(
        title: Text('Nearest Store'),
        subtitle: Text('No stores found nearby'),
      );
    }

    return ListTile(
      title: const Text('Nearest Store'),
      subtitle: Text(nearestStore.name),
      trailing: Text('${nearestStore.distance.toStringAsFixed(2)} km away'),
    );
  }

  Widget _buildAnimatedSection({
    required String title,
    required Widget child,
  }) {
    return AnimatedOpacity(
      opacity: child is SizedBox ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildTrendingProducts(List<TrendingProduct> products) {
    if (products.isEmpty) {
      return const SizedBox();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/placeholder.png',
                    image: products[index].productImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products[index].productName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      products[index].productPrice,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategories(List<Category> categories) {
    if (categories.isEmpty) {
      return const SizedBox();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: categories[index].image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              categories[index].name,
              style: const TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        );
      },
    );
  }

  Widget _buildStores(List<Store> stores) {
    if (stores.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stores.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(stores[index].name),
              subtitle: Text(
                  'Distance: ${stores[index].distance.toStringAsFixed(2)} km'),
              leading: const Icon(Icons.store),
            );
          },
        ),
      ],
    );
  }

  Widget _buildListings(List<Listing> listings) {
    if (listings.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listings.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    listings[index].title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listings[index].products.length,
                  itemBuilder: (context, productIndex) {
                    final product = listings[index].products[productIndex];
                    return Card(
                      child: ListTile(
                        leading: Image.network(product.cuttingImage,
                            width: 50, fit: BoxFit.cover),
                        title: Text(product.productName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Weight: ${product.netWeight}'),
                            Text('Original Price: \$${product.originalPrice}'),
                            if (product.offerPrice != null)
                              Text('Offer Price: \$${product.offerPrice}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
