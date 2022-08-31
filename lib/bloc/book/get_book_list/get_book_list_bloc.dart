// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_modul_fe/bloc/book/get_book_list_additional_cubit/get_book_list_additional_cubit.dart';
import 'package:flutter_modul_fe/bloc/book/get_book_list_settings_cubit/get_book_list_settings_cubit.dart';
import 'package:flutter_modul_fe/bloc/cart/add_to_cart/add_to_cart_bloc.dart';
import 'package:flutter_modul_fe/bloc/login/user_data/user_data_cubit.dart';
import 'package:flutter_modul_fe/models/book_model/book_by_search_model.dart';
import 'package:flutter_modul_fe/models/book_model/book_list_model.dart';
import 'package:flutter_modul_fe/models/book_model/search_type_enum.dart';
import 'package:flutter_modul_fe/models/cart_model/cart_list_model.dart';
import 'package:flutter_modul_fe/repositories/book_repository/book_repository.dart';
import 'package:flutter_modul_fe/repositories/cart_repository/cart_repository.dart';
import 'package:meta/meta.dart';

part 'get_book_list_event.dart';
part 'get_book_list_state.dart';

class GetBookListBloc extends Bloc<GetBookListEvent, GetBookListState> {
  final BookRepository _repository = BookRepository();
  final CartRepository _cartRepository = CartRepository();
  final GetBookListSettingsCubit settingsCubit;
  final GetBookListAdditionalCubit additionalCubit;
  final AddToCartBloc addToCartBloc;
  late StreamSubscription settingsListener;
  late StreamSubscription addListener;
  final UserDataCubit userDataCubit;

  GetBookListBloc({
    required this.settingsCubit,
    required this.additionalCubit,
    required this.addToCartBloc,
    required this.userDataCubit,
  }) : super(GetBookListInitial()) {
    on<GetBookListFromApi>((event, emit) async {
      emit(GetBookListLoading());

      additionalCubit.changeState(GetBookListAdditionalInitial());

      try {
        settingsCubit.data = [];
        settingsCubit.cartData = [];

        GetBookListModelPack data = await _repository.getBookList(
          page: settingsCubit.pageNumber,
          limit: settingsCubit.limit,
        );
        settingsCubit.getBookListData(data.data.dataPerPage);
        settingsCubit.getBookListPaginationData(data.data);

        List<GetCartListDataModel> cartData =
            await _cartRepository.getListCartByUserId(
          userId: userDataCubit.state.userData!.id,
        );

        settingsCubit.updateCartData(cartData);

        emit(GetBookListDone(
          data: data.data.dataPerPage,
          cartData: settingsCubit.cartData,
        ));
      } catch (exception) {
        emit(GetBookListFailed(errorMessage: exception.toString()));
      }
    });

    on<GetBookListFromApiNextPage>((event, emit) async {
      if (additionalCubit.state is GetBookListAdditionalFailed) {
        return;
      }

      if (settingsCubit.pageNumber >= settingsCubit.totalPage) {
        return;
      }

      try {
        additionalCubit.changeState(GetBookListAdditionalLoading());

        if (settingsCubit.pageNumber < settingsCubit.totalPage) {
          settingsCubit.goToPage(settingsCubit.pageNumber + 1);

          GetBookListModelPack data = await _repository.getBookList(
            page: settingsCubit.pageNumber,
            limit: settingsCubit.limit,
          );
          settingsCubit.getBookListData(data.data.dataPerPage);
          settingsCubit.getBookListPaginationData(data.data);

          additionalCubit.changeState(GetBookListAdditionalDone());
          emit(GetBookListDone(
            data: settingsCubit.data,
            cartData: settingsCubit.cartData,
          ));
        }
      } catch (exception) {
        additionalCubit.changeState(GetBookListAdditionalFailed());
      }
    });

    on<GetBookListFromApiBySearch>((event, emit) async {
      emit(GetBookListLoading());

      try {
        List<GetBookBySearchData> data = await _repository.getBookBySearch(
          param: settingsCubit.searchParam,
        );

        List<GetCartListDataModel> cartData =
            await _cartRepository.getListCartByUserId(
          userId: userDataCubit.state.userData!.id,
        );

        emit(GetBookListBySearchDone(
          data: data,
          cartData: cartData,
        ));
      } catch (exception) {
        emit(GetBookListBySearchFailed(errorMessage: exception.toString()));
      }
    });

    settingsListener = settingsCubit.stream.listen((state) {
      if (state is GetBookListSettingsDone) {
        add(GetBookListFromApiBySearch(param: settingsCubit.searchParam));
      }
    });

    addListener = addToCartBloc.stream.listen((state) {
      if (state is AddToCartDone) {
        if (settingsCubit.searchParam.param.trim().isNotEmpty) {
          add(GetBookListFromApiBySearch(param: settingsCubit.searchParam));
        } else {
          add(GetBookListFromApi());
        }
      }
    });

    add(GetBookListFromApi());
  }

  @override
  Future<void> close() {
    settingsListener.cancel();
    addListener.cancel();
    return super.close();
  }
}
