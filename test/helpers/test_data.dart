import 'package:e_commerce/data/models/brand_model.dart';
import 'package:e_commerce/data/models/products_model.dart';
import 'package:e_commerce/data/models/user_info_model.dart';
import 'package:e_commerce/utils/global_enums.dart';

ProductsModel testProduct({String id = 'p1'}) => ProductsModel(
  id: id,
  brandModel: BrandModel(
    id: 'b1',
    brandName: 'Nike',
    iconName: 'nike',
    productCount: 5,
  ),
  categoryId: 'c1',
  currency: 'EUR',
  productImageList: ['https://example.com/1.jpg'],
  productName: 'Air Max',
  discount: 10,
  price: 100,
  productSize: ['41', '42'],
  stock: 10,
);

UserInfoModel testUser() => UserInfoModel(
  id: 'u1',
  firstName: 'John',
  lastName: 'Doe',
  email: 'test@example.com',
  username: 'johndoe',
  phoneNumber: '+381600000000',
  dateOfBirth: DateTime(1990, 5, 20),
  gender: Gender.male,
);
