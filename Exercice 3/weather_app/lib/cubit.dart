import 'package:flutter_bloc/flutter_bloc.dart';

class QueryCubit extends Cubit<String> {
  String _query = "Montpellier";

  QueryCubit() : super("Montpellier");

  set query(String query) {
    _query = query;
  }
}
