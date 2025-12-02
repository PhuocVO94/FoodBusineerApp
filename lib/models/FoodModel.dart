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
    image: "https://imgs.vietnamnet.vn/Images/vnn/2014/08/25/11/20140825110155-bo.jpg?width=0&s=dk-0wXAEOKKgu_B0mZTj7g",
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
    image: "https://cdn2.fptshop.com.vn/unsafe/800x0/banh_mi_thap_cam_1_53ffdd133d.jpg",
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
    image: "https://cdn.tgdd.vn/2021/08/CookProduct/t1-1200x676.jpg",
    description: "Cơm tấm Sài Gòn với sườn nướng mật ong, chả trứng, bì heo.",
    price: 45000,
    rating: 4.6,
    commentsCount: 312,
    location: "2.1km",
    time: "20min",
    userComments: [],
  ),
  // FoodModel(
  //     id: 6,
  //     name: "Bánh Canh Chả Cá Nha Trang",
  //     image: "https://cooponline.vn/tin-tuc/wp-content/uploads/2025/10/bi-quyet-nau-bun-cha-ca-nha-trang-dai-ngon-nuoc-dung-trong-vat.jpg",
  //     description: "Sợi bánh canh dai, chả cá thát lát tươi ngon, nước dùng ngọt thanh vị cá.",
  //     price: 40000,
  //     rating: 4.7,
  //     commentsCount: 180,
  //     location: "2.8km",
  //     time: "22min",
  //     userComments: []
  // ),
  // FoodModel(
  //     id: 7,
  //     name: "Mì Quảng Gà",
  //     image: "https://images.foody.vn/res/g105/1041922/s800/foody-review-o-do-an-trua-1041922-637996716960146036.jpg",
  //     description: "Món đặc sản miền Trung, sợi mì dẹt, nước dùng sệt, có đậu phộng và bánh tráng mè.",
  //     price: 35000,
  //     rating: 4.4,
  //     commentsCount: 95,
  //     location: "4.5km",
  //     time: "30min",
  //     userComments: []
  // ),
  // FoodModel(
  //   id: 8,
  //   name: "Bánh Xèo Tôm Thịt",
  //   image: "https://latravel.com.vn/wp-content/uploads/2025/02/3-27.jpg",
  //   description: "Bánh xèo giòn tan, nhân tôm, thịt, giá đỗ, cuốn với rau sống và nước chấm chua ngọt.",
  //   price: 30000,
  //   rating: 4.6,
  //   commentsCount: 210,
  //   location: "1.0km",
  //   time: "18min",
  //     userComments: []
  // ),
  // FoodModel(
  //     id: 9,
  //     name: "Mì Quảng Gà",
  //     image: "https://images.foody.vn/res/g105/1041922/s800/foody-review-o-do-an-trua-1041922-637996716960146036.jpg",
  //     description: "Món đặc sản miền Trung, sợi mì dẹt, nước dùng sệt, có đậu phộng và bánh tráng mè.",
  //     price: 35000,
  //     rating: 4.4,
  //     commentsCount: 95,
  //     location: "4.5km",
  //     time: "30min",
  //     userComments: []
  // ),
  // FoodModel(
  //     id: 10,
  //     name: "Mì Quảng Gà",
  //     image: "https://images.foody.vn/res/g105/1041922/s800/foody-review-o-do-an-trua-1041922-637996716960146036.jpg",
  //     description: "Món đặc sản miền Trung, sợi mì dẹt, nước dùng sệt, có đậu phộng và bánh tráng mè.",
  //     price: 35000,
  //     rating: 4.4,
  //     commentsCount: 95,
  //     location: "4.5km",
  //     time: "30min",
  //     userComments: []
  // ),
];