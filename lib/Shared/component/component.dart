import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget BuildArticleItem(artcle, context) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage("${artcle['urlToImage']}"),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${artcle['title']}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1),
              Text("${artcle['publishedAt']}",
                  style: TextStyle(fontSize: 20, color: Colors.grey))
            ],
          ),
        )
      ],
    ),
  );
}

Widget MyDivider() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    width: 1,
    height: 1,
    color: Colors.grey,
  );
}

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
  required Function validate,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
  // ignore: use_function_type_syntax_for_parameters, non_constant_identifier_names
}) =>
    TextFormField(
      onTap: () {
        onTap!();
      },
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged: (s) {
        onChange!(s);
      },
      validator: (value) {
        return validate(value);
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          /* borderSide: const BorderSide(
            color: MyColors.basColor,
            width: 2.0,
          ),*/
        ),
        labelText: label,
        labelStyle: const TextStyle(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
