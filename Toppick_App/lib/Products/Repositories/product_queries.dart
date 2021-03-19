import '../Models/combo.dart';
import '../Models/producto.dart';
import '../Models/producto.dart';
import '../Models/producto.dart';

class ProductQueries {
  List<Producto> getAllAvailableProducts() {
    List<Producto> queryResult = [];
    //queryResult = dio("url server")
    queryResult = [
      Producto(
          1,
          "Pescadito",
          3000,
          "NINFO",
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          20,
          4.5,
          "Horneados"),
      Producto(
          2,
          "Hamburguesa",
          10000,
          "NINFO",
          "Rica hamburguesa de la PUJ, preparada con la mejor carne y vegetales de Colombia.",
          20,
          4.5,
          "A la carta"),
      Producto(
          3,
          "Te",
          2000,
          "NINFO",
          "Te frio de la PUJ, perfecto para combinar con otras comidas que ofrece la universidad.",
          20,
          4.5,
          "Bebidas"),
      Producto(
          4,
          "Avena",
          1200,
          "NINFO",
          "Avena alpina como la conoces, simple pero muy rica.",
          20,
          4.5,
          "Bebidas"),
      Producto(
          5,
          "Chocorramo",
          2000,
          "NINFO",
          "Ponque de vainilla recubierto en chocolate",
          20,
          4.5,
          "Empaquetados"),
      Producto(6, "Combo del mes", 5000, "NINFO", "Pescadito con Te.", 20, 4.5,
          "Combos"),
    ];
    return queryResult;
  }

  List<Producto> getAllAvailableComboProducts() {
    List<Combo> queryResult = [];
    List<Producto> productList = [];
    //queryResult = dio("url server")
    productList = [
      Producto(
          1,
          "Pescadito",
          3000,
          "NINFO",
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          20,
          4.5,
          "Horneados"),
      Producto(
          2,
          "Hamburguesa",
          10000,
          "NINFO",
          "Rica hamburguesa de la PUJ, preparada con la mejor carne y vegetales de Colombia.",
          20,
          4.5,
          "A la carta"),
      Producto(
          3,
          "Te",
          2000,
          "NINFO",
          "Te frio de la PUJ, perfecto para combinar con otras comidas que ofrece la universidad.",
          20,
          4.5,
          "Bebidas")
    ];
    //queryResult = dio("url server")
    queryResult = [
      Combo(
          DateTime.parse("2021-03-01 00:01:00Z"),
          DateTime.parse("2021-03-31 23:59:00Z"),
          productList,
          1,
          "Pescadito",
          3000,
          "NINFO",
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          20,
          4.5,
          "Horneados"),
      Combo(
          DateTime.parse("2021-03-01 00:01:00Z"),
          DateTime.parse("2021-03-31 23:59:00Z"),
          productList,
          2,
          "Pescadito",
          3000,
          "NINFO",
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          20,
          4.5,
          "Horneados"),
      Combo(
          DateTime.parse("2021-03-01 00:01:00Z"),
          DateTime.parse("2021-03-31 23:59:00Z"),
          productList,
          3,
          "Pescadito",
          3000,
          "NINFO",
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          20,
          4.5,
          "Horneados")
    ];
    return queryResult;
  }

  List<Producto> getProductCatalogueById(int storeId) {
    List<Producto> queryResult = [];
    //queryResult = dio("url server")
    queryResult = [
      Producto(
          1,
          "Pescadito",
          3000,
          "NINFO",
          "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
          20,
          4.5,
          "Horneados"),
      Producto(
          2,
          "Hamburguesa",
          10000,
          "NINFO",
          "Rica hamburguesa de la PUJ, preparada con la mejor carne y vegetales de Colombia.",
          20,
          4.5,
          "A la carta"),
      Producto(
          3,
          "Te",
          2000,
          "NINFO",
          "Te frio de la PUJ, perfecto para combinar con otras comidas que ofrece la universidad.",
          20,
          4.5,
          "Bebidas"),
      Producto(
          4,
          "Avena",
          1200,
          "NINFO",
          "Avena alpina como la conoces, simple pero muy rica.",
          20,
          4.5,
          "Bebidas"),
      Producto(
          5,
          "Chocorramo",
          2000,
          "NINFO",
          "Ponque de vainilla recubierto en chocolate",
          20,
          4.5,
          "Empaquetados"),
      Producto(6, "Combo del mes", 5000, "NINFO", "Pescadito con Te.", 20, 4.5,
          "Combos"),
    ];
    return queryResult;
  }

  Producto getProductById(int id) {
    Producto queryResult;
    //queryResult = dio("url server")
    queryResult = Producto(
        1,
        "Pescadito",
        3000,
        "NINFO",
        "Hojaldre relleno de arequipe, preparado por los mejores cocineros de toda la universidad.",
        20,
        4.5,
        "Horneados");
    return queryResult;
  }
}
