// class BouquetProduct {
//   String productId;
//   String name;
//   String description;
//   int price;
//
//   String image;
//
//   BouquetProduct({
//     required this.productId,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.image,
//   });
//   BouquetProduct.fromMap(Map<dynamic, dynamic> res)
//       : productId = res['productId'],
//         image = res['image'],
//         description = res['description'],
//         price = res['price'],
//         name = res['name'];
//   Map<String, dynamic> toMap() {
//     return {
//       'productId': productId,
//       'image': image,
//       'description': description,
//       'price': price,
//       'name': name,
//     };
//   }
// }
//
// List<BouquetProduct> dummyBouquetProduct = [
//   BouquetProduct(
//     productId: '1',
//     name: "Ross yellow",
//     description: "description Ross yellow",
//     price: 2,
//     image:
//         'https://www.nabataty.com/plants/wp-content/uploads/2017/02/rosa-yellow.jpg',
//   ),
//   BouquetProduct(
//     productId: '2',
//     name: "Ross white",
//     description: "description Ross white",
//     price: 2,
//     image:
//         'https://i.pinimg.com/736x/65/1f/c1/651fc1a3a4cc098ac6e9142a36eb5ff4.jpg',
//   ),
//   BouquetProduct(
//     productId: '3',
//     name: "Ross red",
//     description: "description Ross red",
//     price: 2,
//     image: 'https://rjeem.com/wp-content/uploads/2020/05/5356-12.jpg',
//   ),
//   BouquetProduct(
//     productId: '4',
//     name: "pink yellow",
//     description: "description pink yellow",
//     price: 2,
//     image: 'https://birol.solidbtc.works/imgOIP.0sQa3ZKORCjSVrFS0sgagwHaKe',
//   ),
// ];
