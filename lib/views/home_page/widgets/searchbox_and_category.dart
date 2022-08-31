// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modul_fe/bloc/book/get_book_list/get_book_list_bloc.dart';
import 'package:flutter_modul_fe/bloc/book/get_book_list_settings_cubit/get_book_list_settings_cubit.dart';
import 'package:flutter_modul_fe/models/book_model/search_type_enum.dart';
import 'package:flutter_modul_fe/theme/style.dart';

class SearchboxAndCategory extends StatefulWidget {
  const SearchboxAndCategory({Key? key}) : super(key: key);

  @override
  SearchboxAndCategoryState createState() => SearchboxAndCategoryState();
}

class SearchboxAndCategoryState extends State<SearchboxAndCategory> {
  final TextEditingController _textController = TextEditingController();
  bool showClearButton = false;
  List<SearchType> searchType = SearchType.values;
  List<String> searchValue = [];
  String? selectedValue;

  @override
  void initState() {
    searchValue =
        searchType.map((e) => SearchByType.convertValueForUi(e)).toList();

    selectedValue = searchValue[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UsedColors.blueButton,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(left: 22, right: 16, top: 10),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (_textController.text.trim().isNotEmpty) {
                    showClearButton = true;

                    BlocProvider.of<GetBookListSettingsCubit>(context)
                        .searchByParam(
                      SearchByType(
                        searchType: SearchType.values.firstWhere(
                          (element) =>
                              SearchByType.convertValueForUi(element) ==
                              selectedValue,
                        ),
                        param: _textController.text.trim(),
                      ),
                    );
                  } else {
                    showClearButton = false;

                    BlocProvider.of<GetBookListBloc>(context)
                        .add(GetBookListFromApi());
                  }
                });
              },
              icon: Icon(
                Icons.search_outlined,
                color: Colors.white,
                size: 32,
              ),
              splashRadius: 1,
            ),
            SizedBox(width: 10),
            Flexible(
              child: FormBuilderTextField(
                name: "searchbox",
                controller: _textController,
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxHeight: 45, minHeight: 45),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  hintText: "Search...",
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: showClearButton == true
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _textController.clear();
                              showClearButton = false;
                            });
                          },
                          icon: Icon(
                            Icons.cancel_rounded,
                            size: 20,
                          ),
                          splashRadius: 1,
                        )
                      : null,
                ),
                valueTransformer: (String? value) {
                  if (value != null) {
                    return value.trim();
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Flexible(
              child: FormBuilderDropdown(
                name: "category",
                items: searchValue
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                initialValue: selectedValue,
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxHeight: 45, minHeight: 45),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
