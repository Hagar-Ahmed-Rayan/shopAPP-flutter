
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/modules/search/search-cubit.dart';
import 'package:untitled2/modules/search/search-states.dart';
import 'package:untitled2/shared/components.dart';
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    TextFormField(

                      controller: searchController,
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(
                        labelText:'Search',
                        prefixIcon: Icon(
                          Icons.search,

                        ),






                        border: OutlineInputBorder(),
                      ),







                      onFieldSubmitted: (String value) {
                        print(value);
                        SearchCubit.get(context).search(value);

                      },


                      //   suffixPressed: () {
                      //    ShopLoginCubit.get(context)
                      //     .changePasswordVisibility();
                      //  },
                      validator: ( value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }

                        return null;
                      },



                    ),








                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context).model.data.data[index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount:
                          SearchCubit.get(context).model.data.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}