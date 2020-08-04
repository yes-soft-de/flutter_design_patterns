import 'package:patterns_app/coord_model.dart';

abstract class CoordState {}

class CoordLoadingState extends CoordState {}

class CoordLoadSuccessState extends CoordState {
  CoordModel coordModel;
  CoordLoadSuccessState(this.coordModel);
}

class CoordLoadErrorState extends CoordState {
}

class CoordInitState extends CoordState {}
