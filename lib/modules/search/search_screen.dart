import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/componets/components.dart';
import 'package:shop_app/shared/styles/style.dart';

class SearchScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var _formKye = GlobalKey<FormState>();

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, states) => {},
      builder: (context, states)
      {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: _formKye,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
              child: Column(
                children: [
                  defaultFormField(
                      border: InputBorder.none,
                      type: TextInputType.name,
                      label: '',
                      prefix: Icons.search,
                      controller: searchController,
                      validate: (String value)
                      {
                        if(value.isEmpty)
                        {
                          return 'Must write text search';
                        }
                        return null;
                      },
                    onFieldSubmitted: (String text)
                    {
                      ShopCubit.get(context).search(text);
                    }
                  ),
                  const SizedBox(height: 10.0,),

                  if(states is ShopSearchLoadingStates)
                    const LinearProgressIndicator(),

                  if (states is ShopSearchSuccessStates)
                    Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => builderSearchItem(ShopCubit.get(context).searchModel!.data!.data[index],context, false),
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: ShopCubit.get(context).searchModel!.data!.data.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget builderSearchItem(DataProducts model, context, bool isSearch) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: 120,
                height: 120.0,
              ),
              Row(
                children: [
                  if (model.old_price != 0 && isSearch)
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
                ],
              ),

            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, top: 12.0, right: 10.0, bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(fontSize: 17.0, color: colors),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      if (model.old_price != null && isSearch)
                        Text(
                          '${model.old_price}',
                          style: TextStyle(
                              fontSize: 17.0,
                              color: colors,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorite(model.id!);
                        },
                        icon: Icon(ShopCubit.get(context).favorites[model.id!]! ? Icons.favorite : Icons.favorite_border),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
