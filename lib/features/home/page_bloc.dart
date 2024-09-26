import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class PageBloc extends Cubit<int> {
  final PageController pageController = PageController(initialPage: 0);

  PageBloc() : super(0);

  void changePage(int index) {
    pageController.jumpToPage(index);
    emit(index);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}