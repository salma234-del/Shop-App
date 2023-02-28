import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/components/componants.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          body: ListView.separated(
            itemBuilder: (context, index) => buildCatItem(cubit.categoryModel.data.data[index]),
            separatorBuilder: (context, index) => divider(),
            itemCount: cubit.categoryModel.data.data.length,
          ),
        );
      },
    );
  }

  Widget buildCatItem(DataModel model) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            model.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
