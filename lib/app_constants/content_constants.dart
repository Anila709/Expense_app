import 'package:expenses_app/app_constants/image_constants.dart';
import 'package:expenses_app/models/category_model.dart';

class AppConstants {
  //default categories..
  static final List<CategoryModel> mCategories = [
    CategoryModel(
        catId: 1,
        catTitle: "Coffee",
        catImgPath: ImageConstants.IMG_PATH_COFFEE),
    CategoryModel(
        catId: 2,
        catTitle: "FastFood",
        catImgPath: ImageConstants.IMG_PATH_FASTFOOD),
    CategoryModel(
        catId: 3,
        catTitle: "Hawaiian-Shirt",
        catImgPath: ImageConstants.IMG_PATH_HAWAIIAN_SHIRT),
    CategoryModel(
        catId: 4,
        catTitle: "Hot-Pot",
        catImgPath: ImageConstants.IMG_PATH_HOT_POT),
    CategoryModel(
        catId: 5,
        catTitle: "Makeup-Pouch",
        catImgPath: ImageConstants.IMG_PATH_MACKUP_POUCH),
    CategoryModel(
        catId: 6,
        catTitle: "Mobile-Transfer",
        catImgPath: ImageConstants.IMG_PATH_MOBILE_TRANSFER),
    CategoryModel(
        catId: 7, catTitle: "Music", catImgPath: ImageConstants.IMG_PATH_MUSIC),
    CategoryModel(
        catId: 8,
        catTitle: "PopCorn",
        catImgPath: ImageConstants.IMG_PATH_POPCORN),
    CategoryModel(
        catId: 9,
        catTitle: "Restaurant",
        catImgPath: ImageConstants.IMG_PATH_RESTAURANT),
    CategoryModel(
        catId: 10,
        catTitle: "Shopping-Bag",
        catImgPath: ImageConstants.IMG_PATH_SHOPPING_BAG),
    CategoryModel(
        catId: 11,
        catTitle: "Smartphone",
        catImgPath: ImageConstants.IMG_PATH_SMARTPHONE),
    CategoryModel(
        catId: 12,
        catTitle: "Snack",
        catImgPath: ImageConstants.IMG_PATH_SNACKS),
    CategoryModel(
        catId: 12,
        catTitle: "Tools",
        catImgPath: ImageConstants.IMG_PATH_TOOLS),
    CategoryModel(
        catId: 12,
        catTitle: "Travel",
        catImgPath: ImageConstants.IMG_PATH_TRAVEL),
    CategoryModel(
        catId: 12,
        catTitle: "Vegetables",
        catImgPath: ImageConstants.IMG_PATH_VEGETABLES),
    CategoryModel(
        catId: 12,
        catTitle: "Vehicles",
        catImgPath: ImageConstants.IMG_PATH_VEHICLES),
    CategoryModel(
        catId: 12,
        catTitle: "Watch",
        catImgPath: ImageConstants.IMG_PATH_WATCH),
  ];
}
