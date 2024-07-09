import '../../domain/domain.dart';
import '../model/model.dart';

class ProductMapper {
  static Product toProductEntity(ProductModel product) => Product(
        idProduct: product.idproduct,
        nameProduct: product.nameproduct,
        brand: product.brand,
        description: product.description,
        status: product.status,
        img: product.imgproduct,
        price: product.price,
        amount: product.amount,
        idCategory: product.idcategory,
        createAt: product.createAt,
        expireProduct: product.expireProduct,
        updateAt: product.updateAt,
      );
}
