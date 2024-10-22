class HomeResponse {
  final bool status;
  final HomeData? data;
  final String? message;

  HomeResponse({
    required this.status,
    this.data,
    this.message,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      status: json['status'] ?? false,
      data: json['data'] != null ? HomeData.fromJson(json['data']) : null,
      message: json['message'] ?? '',
    );
  }
}

class HomeData {
  final List<Store> stores;
  final Store? nearestStore;
  final List<TrendingProduct> trendingProducts;
  final List<Slider> mainSlider;
  final List<Slider> bottomSlider;
  final List<Listing> listings;
  final List<Category> categories;

  HomeData({
    required this.stores,
    this.nearestStore,
    required this.trendingProducts,
    required this.mainSlider,
    required this.bottomSlider,
    required this.listings,
    required this.categories,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      stores: (json['stores'] as List<dynamic>?)
              ?.map((store) => Store.fromJson(store))
              .toList() ??
          [],
      nearestStore: json['nearest_store'] != null
          ? Store.fromJson(json['nearest_store'])
          : null,
      trendingProducts: (json['trending_products'] as List<dynamic>?)
              ?.map((product) => TrendingProduct.fromJson(product))
              .toList() ??
          [],
      mainSlider: (json['main_slider'] as List<dynamic>?)
              ?.map((slider) => Slider.fromJson(slider))
              .toList() ??
          [],
      bottomSlider: (json['bottom_slider'] as List<dynamic>?)
              ?.map((slider) => Slider.fromJson(slider))
              .toList() ??
          [],
      listings: (json['listings'] as List<dynamic>?)
              ?.map((listing) => Listing.fromJson(listing))
              .toList() ??
          [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((category) => Category.fromJson(category))
              .toList() ??
          [],
    );
  }
}

class Store {
  final int id;
  final String name;
  final String latitude;
  final String longitude;
  final double distance;

  Store({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.distance,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      latitude: json['latitude'] ?? '0',
      longitude: json['longitude'] ?? '0',
      distance: (json['distance'] ?? 0).toDouble(),
    );
  }
}

class TrendingProduct {
  final int productId;
  final String productName;
  final String productPrice;
  final String productImage;

  TrendingProduct({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  factory TrendingProduct.fromJson(Map<String, dynamic> json) {
    const String baseUrl =
        'https://ourworks.co.in/sigofish-backend/public/storage/';
    return TrendingProduct(
      productId: json['product_id'] ?? 0,
      productName: json['product_name'] ?? '',
      productPrice: json['product_price'] ?? '',
      productImage: baseUrl + (json['product_image'] ?? ''),
    );
  }
}

class Slider {
  final int id;
  final String image;
  final int sliderType;
  final int deviceType;

  Slider({
    required this.id,
    required this.image,
    required this.sliderType,
    required this.deviceType,
  });

  factory Slider.fromJson(Map<String, dynamic> json) {
    const String baseUrl =
        'https://ourworks.co.in/sigofish-backend/public/storage/';
    return Slider(
      id: json['id'] ?? 0,
      image: baseUrl + (json['image'] ?? ''),
      sliderType: json['slider_type'] ?? 0,
      deviceType: json['device_type'] ?? 0,
    );
  }
}

class Listing {
  final int id;
  final String title;
  final List<Product> products;

  Listing({
    required this.id,
    required this.title,
    required this.products,
  });

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      products: (json['products'] as List<dynamic>?)
              ?.map((product) => Product.fromJson(product))
              .toList() ??
          [],
    );
  }
}

class Product {
  final int productId;
  final String productName;
  final int cuttingTypeId;
  final String type;
  final String cuttingImage;
  final String netWeight;
  final String grossWeight;
  final String originalPrice;
  final String? offerPrice;
  final String? offerPercentage;
  final String stock;
  final List<dynamic> wishlist;

  Product({
    required this.productId,
    required this.productName,
    required this.cuttingTypeId,
    required this.type,
    required this.cuttingImage,
    required this.netWeight,
    required this.grossWeight,
    required this.originalPrice,
    this.offerPrice,
    this.offerPercentage,
    required this.stock,
    required this.wishlist,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    const String baseUrl =
        'https://ourworks.co.in/sigofish-backend/public/storage/';
    return Product(
      productId: json['product_id'] ?? 0,
      productName: json['product_name'] ?? '',
      cuttingTypeId: json['cutting_type_id'] ?? 0,
      type: json['type'] ?? '',
      cuttingImage: baseUrl + (json['cutting_image'] ?? ''),
      netWeight: json['net_weight'] ?? '',
      grossWeight: json['gross_weight'] ?? '',
      originalPrice: json['original_price'] ?? '',
      offerPrice: json['offer_price'],
      offerPercentage: json['offer_percentage'],
      stock: json['stock'] ?? '',
      wishlist: json['wishlist'] ?? [],
    );
  }
}

class Category {
  final int id;
  final String name;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    const String baseUrl =
        'https://ourworks.co.in/sigofish-backend/public/storage/';
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: baseUrl + (json['image'] ?? ''),
    );
  }
}
