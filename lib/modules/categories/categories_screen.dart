import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_models.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return ListView.separated(
            itemBuilder: (context, index) => builderCatItem(cubit.categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => Container(
              width: 1.0,
              height: 1.0,
              color: Colors.grey,
            ),
            itemCount: cubit.categoriesModel!.data!.data.length
        );
      },
    );
  }

  Widget builderCatItem(CategoriesDataModel categoriesModel) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                  '${categoriesModel.image}'),
              width: 120.0,
              height: 120.0,
            ),
            const SizedBox(width: 10.0,),
            Text('${categoriesModel.name}'),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );

}
