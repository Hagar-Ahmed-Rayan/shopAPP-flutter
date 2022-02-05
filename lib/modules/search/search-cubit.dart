import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/models/search-model.dart';
import 'package:untitled2/modules/search/search-states.dart';
import 'package:untitled2/shared/consts.dart';
import 'package:untitled2/shared/network/end-poins.dart';
import 'package:untitled2/shared/network/remote/dio-healper.dart';

class SearchCubit extends Cubit<SearchStates> {
SearchCubit() : super(SearchInitialState());

static SearchCubit get(context) => BlocProvider.of(context);

late SearchModel model;

void search(String text) {
  emit(SearchLoadingState());

  DioHelper.postData(
    url: SEARCH,
    token: token,
    data: {
      'text': text,
    },
  ).then((value)
  {
    model = SearchModel.fromJson(value.data);

    emit(SearchSuccessState());
  }).catchError((error)
  {
    print(error.toString());
    emit(SearchErrorState());
  });
}
}