import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pharmacy/data/kit_remote_data.dart';
import 'package:pharmacy/data/models/kit.dart';
import 'package:pharmacy/data/models/product.dart';
import 'package:pharmacy/presintations/bloc/kit_event.dart';

part 'kit_state.dart';

class KitBloc extends Bloc<KitEvent, KitState> {
  KitRemoteDs remoteDs;

  KitBloc(this.remoteDs) : super(KitInitial()) {
    on<KitEvent>((event, emit) async {
      try {
        if (event is AddKit) {
          emit(KitLoadingState());
          await remoteDs.addKit(event.kit);
          add(GetKit());
        } else if (event is AddKitToCart) {
          emit(KitLoadingState());
          await remoteDs.addToCart(event.kit);
          add(GetKit());
        } else if (event is GetKit) {
          emit(KitLoadingState());
          final kits = await remoteDs.getKit();
          emit(KitLoaded(kits: kits));
        } else if (event is GetCartKit) {
          emit(KitLoadingState());
          final kits = await remoteDs.getCartKit();
          emit(KitLoaded(kits: kits));
        } else if (event is RemoveKit) {
          emit(KitLoadingState());
          await remoteDs.removeKit(event.id);
          add(GetKit());
        } else if (event is RemoveKitFromCart) {
          emit(KitLoadingState());
          await remoteDs.removeKitFromCart(event.id);
          add(GetKit());
        } else if (event is UpdateKit) {
          emit(KitLoadingState());
          await remoteDs.updateKit(event.kit);
          add(GetCartKit());
        }
      } catch (e) {
        emit(KitErrorState(errorMessage: e.toString()));
      }
    });
  }
}
