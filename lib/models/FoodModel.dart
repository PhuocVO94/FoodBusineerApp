class FoodModel {
  final int id;
  final String name;
  final String image;
  final String description;
  final double price;
  final double rating;
  final int commentsCount;
  final String location;
  final String time;
  final List<Map<String, String>> userComments;

  FoodModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.rating,
    required this.commentsCount,
    required this.location,
    required this.time,
    required this.userComments,
  });
}

// Danh sách món ăn Việt Nam
final List<FoodModel> vietnameseFoods = [
  FoodModel(
    id: 1,
    name: "Phở Bò Tái Nạm",
    image: "https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
    description: "Phở là món ăn truyền thống của Việt Nam, với nước dùng ninh từ xương bò trong nhiều giờ.",
    price: 50000,
    rating: 4.8,
    commentsCount: 128,
    location: "1.2km",
    time: "15min",
    userComments: [
      {"user": "Minh Anh", "content": "Nước dùng rất ngọt!", "date": "20/11/2023"},
    ],
  ),
  FoodModel(
    id: 2,
    name: "Bánh Mì Thập Cẩm",
    image: "https://images.unsplash.com/photo-1626804475315-0937501f39f8?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
    description: "Bánh mì Việt Nam giòn rụm, nhân pate gan, thịt nguội, chả lụa.",
    price: 25000,
    rating: 4.5,
    commentsCount: 542,
    location: "0.5km",
    time: "5min",
    userComments: [],
  ),
  FoodModel(
    id: 3,
    name: "Bún Chả Hà Nội",
    image: "https://images.unsplash.com/photo-1585325701165-351af916e581?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
    description: "Thịt nướng than hoa thơm lừng ăn kèm bún rối và nước chấm chua ngọt.",
    price: 60000,
    rating: 4.7,
    commentsCount: 230,
    location: "3.0km",
    time: "25min",
    userComments: [],
  ),
  FoodModel(
    id: 4,
    name: "Gỏi Cuốn Tôm Thịt",
    image: "https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
    description: "Món ăn thanh đạm với tôm, thịt heo, bún và rau sống.",
    price: 10000,
    rating: 4.9,
    commentsCount: 89,
    location: "1.5km",
    time: "10min",
    userComments: [],
  ),
  FoodModel(
    id: 5,
    name: "Cơm Tấm Sườn",
    image: "https://images.unsplash.com/photo-1589227170949-a7442762d6f3?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
    description: "Cơm tấm Sài Gòn với sườn nướng mật ong, chả trứng, bì heo.",
    price: 45000,
    rating: 4.6,
    commentsCount: 312,
    location: "2.1km",
    time: "20min",
    userComments: [],
  ),
];