import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/componets/components.dart';
import 'package:shop_app/shared/styles/style.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitFavorites = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopChaneFavoritesLoadingStates,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => builderFavItem(cubitFavorites.favoritesModel!.data!.data[index].product!,context, true),
            separatorBuilder: (context, index) => const SizedBox(),
            itemCount: cubitFavorites.favoritesModel!.data!.data.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }


}
