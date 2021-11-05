import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/styles/style.dart';

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => widget
));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    ),
    (Route<dynamic> route) => false
);
void showToast({
  required String text,
  required ToastStates state
}) =>
{
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: changeToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0)
};

enum ToastStates {SUCCESS, ERROR, WREAD}


Color changeToastColor(ToastStates states)
{
  Color color;
  switch(states)
  {
    case ToastStates.ERROR:
      return color = HexColor('3e6787');
      break;
    case ToastStates.SUCCESS:
      return color = HexColor('b48b8b');
      break;
    case ToastStates.WREAD:
      return color = HexColor('f4d4bd');
      break;
  }
  return color;
}




Widget elevatedButtonBuilder({
  onPressed,
  required String text,
  double? width
}) => ElevatedButton(
  style: ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )),
    backgroundColor: MaterialStateProperty.all<Color>(colorAll),
    fixedSize: MaterialStateProperty.all<Size?>(Size(width!, 60.0)),
  ),
  onPressed: onPressed,
  child: Text(
    text,
    style: const TextStyle(
        fontSize: 26.0
    ),
  ),
);

Widget defaultFormField({
  onTap,
  required TextInputType type,
  required String label,
  required IconData prefix,
  required TextEditingController controller,
  IconData? suffix,
  bool isPassword = false,
  bool isClickable = true,
  onChanged,
  validate,
  onFieldSubmitted,
  suffixPassword,
  InputBorder? border
}) => TextFormField(
  obscureText: isPassword,
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onFieldSubmitted,
  validator: validate,
  onChanged: onChanged,
  onTap: onTap,
  enabled: isClickable,
  cursorHeight: 20.0,
  decoration: InputDecoration(
    border: border,
    suffixIcon: suffix != null ? IconButton(
      icon: Icon(suffix),
      onPressed: suffixPassword,
    ) : null,
    labelText: label,
    prefixIcon: Icon(prefix),
  ),
);


Widget defaultFormFields({
  onPressed,
  required String text,
  double? width,
}) => Container(
  width: width,
  height: 60.0,
  color: colorAll,
  child:   MaterialButton(
      onPressed: onPressed,
      child: Text(text),
      ),
);

Widget defaultTextBottom({
  onPressed,
  required String? text,
}) => TextButton(
    onPressed: onPressed,
    child: Text(
        text!,
      style: TextStyle(
        color: colorAll,
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),
    ),
);



Widget builderFavItem(ProductModel model, context, bool isSearch) => Padding(
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





