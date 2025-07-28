// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutEvent()';
}


}

/// @nodoc
class $CheckoutEventCopyWith<$Res>  {
$CheckoutEventCopyWith(CheckoutEvent _, $Res Function(CheckoutEvent) __);
}


/// Adds pattern-matching-related methods to [CheckoutEvent].
extension CheckoutEventPatterns on CheckoutEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _AddCheckout value)?  addCheckout,TResult Function( _RemoveCheckout value)?  removeCheckout,TResult Function( _DeleteItemCheckout value)?  deleteItemCheckout,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _AddCheckout() when addCheckout != null:
return addCheckout(_that);case _RemoveCheckout() when removeCheckout != null:
return removeCheckout(_that);case _DeleteItemCheckout() when deleteItemCheckout != null:
return deleteItemCheckout(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _AddCheckout value)  addCheckout,required TResult Function( _RemoveCheckout value)  removeCheckout,required TResult Function( _DeleteItemCheckout value)  deleteItemCheckout,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _AddCheckout():
return addCheckout(_that);case _RemoveCheckout():
return removeCheckout(_that);case _DeleteItemCheckout():
return deleteItemCheckout(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _AddCheckout value)?  addCheckout,TResult? Function( _RemoveCheckout value)?  removeCheckout,TResult? Function( _DeleteItemCheckout value)?  deleteItemCheckout,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _AddCheckout() when addCheckout != null:
return addCheckout(_that);case _RemoveCheckout() when removeCheckout != null:
return removeCheckout(_that);case _DeleteItemCheckout() when deleteItemCheckout != null:
return deleteItemCheckout(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( Product product)?  addCheckout,TResult Function( Product product)?  removeCheckout,TResult Function( Product product)?  deleteItemCheckout,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _AddCheckout() when addCheckout != null:
return addCheckout(_that.product);case _RemoveCheckout() when removeCheckout != null:
return removeCheckout(_that.product);case _DeleteItemCheckout() when deleteItemCheckout != null:
return deleteItemCheckout(_that.product);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( Product product)  addCheckout,required TResult Function( Product product)  removeCheckout,required TResult Function( Product product)  deleteItemCheckout,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _AddCheckout():
return addCheckout(_that.product);case _RemoveCheckout():
return removeCheckout(_that.product);case _DeleteItemCheckout():
return deleteItemCheckout(_that.product);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( Product product)?  addCheckout,TResult? Function( Product product)?  removeCheckout,TResult? Function( Product product)?  deleteItemCheckout,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _AddCheckout() when addCheckout != null:
return addCheckout(_that.product);case _RemoveCheckout() when removeCheckout != null:
return removeCheckout(_that.product);case _DeleteItemCheckout() when deleteItemCheckout != null:
return deleteItemCheckout(_that.product);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements CheckoutEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutEvent.started()';
}


}




/// @nodoc


class _AddCheckout implements CheckoutEvent {
  const _AddCheckout(this.product);
  

 final  Product product;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddCheckoutCopyWith<_AddCheckout> get copyWith => __$AddCheckoutCopyWithImpl<_AddCheckout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddCheckout&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'CheckoutEvent.addCheckout(product: $product)';
}


}

/// @nodoc
abstract mixin class _$AddCheckoutCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory _$AddCheckoutCopyWith(_AddCheckout value, $Res Function(_AddCheckout) _then) = __$AddCheckoutCopyWithImpl;
@useResult
$Res call({
 Product product
});




}
/// @nodoc
class __$AddCheckoutCopyWithImpl<$Res>
    implements _$AddCheckoutCopyWith<$Res> {
  __$AddCheckoutCopyWithImpl(this._self, this._then);

  final _AddCheckout _self;
  final $Res Function(_AddCheckout) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(_AddCheckout(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,
  ));
}


}

/// @nodoc


class _RemoveCheckout implements CheckoutEvent {
  const _RemoveCheckout(this.product);
  

 final  Product product;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveCheckoutCopyWith<_RemoveCheckout> get copyWith => __$RemoveCheckoutCopyWithImpl<_RemoveCheckout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveCheckout&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'CheckoutEvent.removeCheckout(product: $product)';
}


}

/// @nodoc
abstract mixin class _$RemoveCheckoutCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory _$RemoveCheckoutCopyWith(_RemoveCheckout value, $Res Function(_RemoveCheckout) _then) = __$RemoveCheckoutCopyWithImpl;
@useResult
$Res call({
 Product product
});




}
/// @nodoc
class __$RemoveCheckoutCopyWithImpl<$Res>
    implements _$RemoveCheckoutCopyWith<$Res> {
  __$RemoveCheckoutCopyWithImpl(this._self, this._then);

  final _RemoveCheckout _self;
  final $Res Function(_RemoveCheckout) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(_RemoveCheckout(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,
  ));
}


}

/// @nodoc


class _DeleteItemCheckout implements CheckoutEvent {
  const _DeleteItemCheckout(this.product);
  

 final  Product product;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteItemCheckoutCopyWith<_DeleteItemCheckout> get copyWith => __$DeleteItemCheckoutCopyWithImpl<_DeleteItemCheckout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteItemCheckout&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode => Object.hash(runtimeType,product);

@override
String toString() {
  return 'CheckoutEvent.deleteItemCheckout(product: $product)';
}


}

/// @nodoc
abstract mixin class _$DeleteItemCheckoutCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory _$DeleteItemCheckoutCopyWith(_DeleteItemCheckout value, $Res Function(_DeleteItemCheckout) _then) = __$DeleteItemCheckoutCopyWithImpl;
@useResult
$Res call({
 Product product
});




}
/// @nodoc
class __$DeleteItemCheckoutCopyWithImpl<$Res>
    implements _$DeleteItemCheckoutCopyWith<$Res> {
  __$DeleteItemCheckoutCopyWithImpl(this._self, this._then);

  final _DeleteItemCheckout _self;
  final $Res Function(_DeleteItemCheckout) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(_DeleteItemCheckout(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product,
  ));
}


}

/// @nodoc
mixin _$CheckoutState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState()';
}


}

/// @nodoc
class $CheckoutStateCopyWith<$Res>  {
$CheckoutStateCopyWith(CheckoutState _, $Res Function(CheckoutState) __);
}


/// Adds pattern-matching-related methods to [CheckoutState].
extension CheckoutStatePatterns on CheckoutState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( Success value)?  success,TResult Function( Failure value)?  failure,TResult Function( Empty value)?  empty,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Failure() when failure != null:
return failure(_that);case Empty() when empty != null:
return empty(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( Success value)  success,required TResult Function( Failure value)  failure,required TResult Function( Empty value)  empty,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Loading():
return loading(_that);case Success():
return success(_that);case Failure():
return failure(_that);case Empty():
return empty(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( Success value)?  success,TResult? Function( Failure value)?  failure,TResult? Function( Empty value)?  empty,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Failure() when failure != null:
return failure(_that);case Empty() when empty != null:
return empty(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<OrderItem> products,  int total,  int qty)?  success,TResult Function( String message)?  failure,TResult Function()?  empty,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.products,_that.total,_that.qty);case Failure() when failure != null:
return failure(_that.message);case Empty() when empty != null:
return empty();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<OrderItem> products,  int total,  int qty)  success,required TResult Function( String message)  failure,required TResult Function()  empty,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Loading():
return loading();case Success():
return success(_that.products,_that.total,_that.qty);case Failure():
return failure(_that.message);case Empty():
return empty();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<OrderItem> products,  int total,  int qty)?  success,TResult? Function( String message)?  failure,TResult? Function()?  empty,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.products,_that.total,_that.qty);case Failure() when failure != null:
return failure(_that.message);case Empty() when empty != null:
return empty();case _:
  return null;

}
}

}

/// @nodoc


class Initial implements CheckoutState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.initial()';
}


}




/// @nodoc


class Loading implements CheckoutState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.loading()';
}


}




/// @nodoc


class Success implements CheckoutState {
  const Success(final  List<OrderItem> products, this.total, this.qty): _products = products;
  

 final  List<OrderItem> _products;
 List<OrderItem> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  int total;
 final  int qty;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.total, total) || other.total == total)&&(identical(other.qty, qty) || other.qty == qty));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),total,qty);

@override
String toString() {
  return 'CheckoutState.success(products: $products, total: $total, qty: $qty)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 List<OrderItem> products, int total, int qty
});




}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? total = null,Object? qty = null,}) {
  return _then(Success(
null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<OrderItem>,null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class Failure implements CheckoutState {
  const Failure(this.message);
  

 final  String message;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CheckoutState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(Failure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Empty implements CheckoutState {
  const Empty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Empty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CheckoutState.empty()';
}


}




// dart format on
