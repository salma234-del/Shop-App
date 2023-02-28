import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/constants.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          // ignore: unnecessary_null_comparison
          condition: cubit.homeModel != null && cubit.categoryModel != null,
          builder: (context) =>
              productsBuilder(cubit.homeModel, cubit.categoryModel),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model, CategoriesModel catModel) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1,
                autoPlay: true,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildCategoryItem(catModel.data.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: catModel.data.data.length,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    color: Colors.grey[300],
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1 / 1.5,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          model.data.products.length,
                          (index) =>
                              gridProductBuilder(model.data.products[index])),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
  Widget gridProductBuilder(ProductModel model) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  height: 200,
                  width: double.infinity,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(5),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              model.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Text(
                  model.price.toString(),
                  style: TextStyle(
                    color: defaultColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if (model.discount != 0)
                  Text(
                    model.oldPrice.toString(),
                    style: TextStyle(
                        color: Colors.grey[500],
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryItem(DataModel model) {
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image(
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            image: NetworkImage(model.image)),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.7),
          child: Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
