import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';
import '../../../core/utils/string_util.dart';
import '../../../core/utils/validator.dart';
import '../view_model/search_viewmodel.dart';
import 'search_button.dart';

class ContentWidget extends ViewModelWidget<SearchViewModel> {
  final TextEditingController controller;
  final FocusNode focusNode;
  ContentWidget({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key, reactive: false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    var theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Search \nFor Movies',
          textAlign: TextAlign.center,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 30.sp,
          ),
        ),
        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: 30.h,
            left: 10.w,
            right: 10.w,
          ),
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: controller,
                focusNode: focusNode,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Search',
                ),
                onFieldSubmitted: (value) {
                  if (StringUtil.isEmpty(value)) {
                    return;
                  }
                },
                validator: (value) => Validator.validateField(
                  value,
                  errorMessage: 'Required',
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            SearchButton(
              onTap: () {
                if (_formKey.currentState?.validate() ?? false) {
                  viewModel.actionSearchMovie();
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
