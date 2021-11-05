import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_models.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/styles/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  CarouselController buttonCarouselController = CarouselController();
  int activateIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubitProducts = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubitProducts.homeModel != null &&
              cubitProducts.categoriesModel != null,
          builder: (context) =>
              productBuilder(cubitProducts.homeModel, cubitProducts.categoriesModel,context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productBuilder(
    HomeModel? model, CategoriesModel? categoriesModel,context
  ) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model!.data!.banners
                    .map((e) => Image(image: NetworkImage('${e.image}')))
                    .toList(),
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  height: 250,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) =>
                      setState(() => activateIndex = index),
                  scrollDirection: Axis.horizontal,
                )),
            Container(
              alignment: AlignmentDirectional.center,
              child: AnimatedSmoothIndicator(
                activeIndex: activateIndex,
                count: model.data!.banners.length,
                effect: JumpingDotEffect(
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    dotColor: Colors.grey,
                    activeDotColor: colorAll),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                        color: colors,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => builderCategories(categoriesModel!.data!.data[index], context),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 10.0,
                            ),
                        itemCount: categoriesModel!.data!.data.length),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                        color: colors,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Container(
              color: HexColor('F9F9F9'),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 3.0,
                childAspectRatio: 1 / 1.4,
                crossAxisCount: 2,
                children: List.generate(
                    model.data!.products.length,
                    (index) => builderItemGridView(
                        model.data!.products[index], index,context)),
              ),
            ),
          ],
        ),
      );

  Widget builderCategories(CategoriesDataModel modelData,context) => Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(
                '${modelData.image}'),
            height: 150.0,
            width: 150.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
            width: 150.0,
            child: Text(
              '${modelData.name}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      );

  Widget builderItemGridView(
          HomeProductsModel model, int index,context) {
    return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(alignment: AlignmentDirectional.bottomStart, children: [
          Image(
            image: NetworkImage(
              '${model.image}',
            ),
            width: double.infinity,
            height: 200.0,
          ),
          Row(
            children: [
              if (model.old_price != 0)
                Container(
                  color: colors,
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  ShopCubit.get(context).changeFavorite(model.id!);
                },
                icon: Icon(ShopCubit.get(context).favorites[model.id]! ? Icons.favorite : Icons.favorite_border),
                color: Colors.red,
              ),
            ],
          ),
        ]),
        Padding(
          padding: const EdgeInsets.only(
              left: 12.0, top: 12.0, right: 10.0, bottom: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(fontSize: 17.0, color: colors),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  if (model.old_price != null)
                    Text(
                      model.old_price.toString(),
                      style: TextStyle(
                          fontSize: 17.0,
                          color: colors,
                          decoration: TextDecoration.lineThrough),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );}

}
