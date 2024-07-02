import 'package:bloc/bloc.dart';
import 'package:pharmacy/data/products_remote_data_source.dart';
import 'package:pharmacy/presintations/bloc/products_event.dart';
import 'package:pharmacy/presintations/bloc/products_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRemoteDs remoteDs;
  ProductBloc(this.remoteDs) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      try {
        if (event is AddProduct) {
          emit(ProductLoadingState());
          await remoteDs.addProduct(event.product);
          add(GetProduct());
        } 
        else if (event is AddProductToCart) {
          emit(ProductLoadingState());
          await remoteDs.addToCart(event.product);
          add(GetProduct());
        }
         else if (event is GetProduct) {
          emit(ProductLoadingState());
          final products = await remoteDs.getProduct();
          emit(ProductLoaded(products: products));
        } else if (event is GetCartProduct) {
          emit(ProductLoadingState());
          final products = await remoteDs.getCartProduct();
          emit(ProductLoaded(products: products));
        } else if (event is RemoveProduct) {
          emit(ProductLoadingState());
          await remoteDs.removeProduct(event.id);
          add(GetProduct());
        }else if (event is RemoveProductFromCart) {
          emit(ProductLoadingState());
          await remoteDs.removeProductFromCart(event.id);
          add(GetCartProduct());
        }
        
         else if (event is UpdateProduct) {
          emit(ProductLoadingState());
          await remoteDs.updateProduct(event.product);
          add(GetProduct());
        }
      } catch (e) {
        emit(ProductErrorState(errorMessage: e.toString()));
      }
    });
  }
}
