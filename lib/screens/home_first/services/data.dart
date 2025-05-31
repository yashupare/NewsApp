import 'package:inbrief/screens/home_first/models/category_model.dart';

import '../../../utils/constants/image_strings.dart';

List<CategoryModel> getCategories(){
  List<CategoryModel> category=[];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.categoryName="Business";
  categoryModel.image = TImages.businessIcon;
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName="Entertainment";
  categoryModel.image = TImages.entertainmentIcon;
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName="General";
  categoryModel.image = TImages.newsIcon;
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName="Health";
  categoryModel.image = TImages.healthIcon;
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.categoryName="Sports";
  categoryModel.image = TImages.sportIcon;
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;

}