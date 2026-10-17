// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActivityCount {

 int get count; double get amount;
/// Create a copy of ActivityCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityCountCopyWith<ActivityCount> get copyWith => _$ActivityCountCopyWithImpl<ActivityCount>(this as ActivityCount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityCount&&(identical(other.count, count) || other.count == count)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,count,amount);

@override
String toString() {
  return 'ActivityCount(count: $count, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $ActivityCountCopyWith<$Res>  {
  factory $ActivityCountCopyWith(ActivityCount value, $Res Function(ActivityCount) _then) = _$ActivityCountCopyWithImpl;
@useResult
$Res call({
 int count, double amount
});




}
/// @nodoc
class _$ActivityCountCopyWithImpl<$Res>
    implements $ActivityCountCopyWith<$Res> {
  _$ActivityCountCopyWithImpl(this._self, this._then);

  final ActivityCount _self;
  final $Res Function(ActivityCount) _then;

/// Create a copy of ActivityCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? amount = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivityCount].
extension ActivityCountPatterns on ActivityCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivityCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivityCount() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivityCount value)  $default,){
final _that = this;
switch (_that) {
case _ActivityCount():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivityCount value)?  $default,){
final _that = this;
switch (_that) {
case _ActivityCount() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivityCount() when $default != null:
return $default(_that.count,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  double amount)  $default,) {final _that = this;
switch (_that) {
case _ActivityCount():
return $default(_that.count,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _ActivityCount() when $default != null:
return $default(_that.count,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _ActivityCount implements ActivityCount {
  const _ActivityCount({required this.count, required this.amount});
  

@override final  int count;
@override final  double amount;

/// Create a copy of ActivityCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivityCountCopyWith<_ActivityCount> get copyWith => __$ActivityCountCopyWithImpl<_ActivityCount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivityCount&&(identical(other.count, count) || other.count == count)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,count,amount);

@override
String toString() {
  return 'ActivityCount(count: $count, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$ActivityCountCopyWith<$Res> implements $ActivityCountCopyWith<$Res> {
  factory _$ActivityCountCopyWith(_ActivityCount value, $Res Function(_ActivityCount) _then) = __$ActivityCountCopyWithImpl;
@override @useResult
$Res call({
 int count, double amount
});




}
/// @nodoc
class __$ActivityCountCopyWithImpl<$Res>
    implements _$ActivityCountCopyWith<$Res> {
  __$ActivityCountCopyWithImpl(this._self, this._then);

  final _ActivityCount _self;
  final $Res Function(_ActivityCount) _then;

/// Create a copy of ActivityCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? amount = null,}) {
  return _then(_ActivityCount(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$DashboardSummary {

 int get totalProducts; double get totalStockQuantity; double get totalStockValue; int get lowStockProducts; int get outOfStockProducts; ActivityCount get todaysSales; ActivityCount get todaysPurchases; ActivityCount get todaysExpenses; ActivityCount get thisMonthExpenses;
/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardSummaryCopyWith<DashboardSummary> get copyWith => _$DashboardSummaryCopyWithImpl<DashboardSummary>(this as DashboardSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardSummary&&(identical(other.totalProducts, totalProducts) || other.totalProducts == totalProducts)&&(identical(other.totalStockQuantity, totalStockQuantity) || other.totalStockQuantity == totalStockQuantity)&&(identical(other.totalStockValue, totalStockValue) || other.totalStockValue == totalStockValue)&&(identical(other.lowStockProducts, lowStockProducts) || other.lowStockProducts == lowStockProducts)&&(identical(other.outOfStockProducts, outOfStockProducts) || other.outOfStockProducts == outOfStockProducts)&&(identical(other.todaysSales, todaysSales) || other.todaysSales == todaysSales)&&(identical(other.todaysPurchases, todaysPurchases) || other.todaysPurchases == todaysPurchases)&&(identical(other.todaysExpenses, todaysExpenses) || other.todaysExpenses == todaysExpenses)&&(identical(other.thisMonthExpenses, thisMonthExpenses) || other.thisMonthExpenses == thisMonthExpenses));
}


@override
int get hashCode => Object.hash(runtimeType,totalProducts,totalStockQuantity,totalStockValue,lowStockProducts,outOfStockProducts,todaysSales,todaysPurchases,todaysExpenses,thisMonthExpenses);

@override
String toString() {
  return 'DashboardSummary(totalProducts: $totalProducts, totalStockQuantity: $totalStockQuantity, totalStockValue: $totalStockValue, lowStockProducts: $lowStockProducts, outOfStockProducts: $outOfStockProducts, todaysSales: $todaysSales, todaysPurchases: $todaysPurchases, todaysExpenses: $todaysExpenses, thisMonthExpenses: $thisMonthExpenses)';
}


}

/// @nodoc
abstract mixin class $DashboardSummaryCopyWith<$Res>  {
  factory $DashboardSummaryCopyWith(DashboardSummary value, $Res Function(DashboardSummary) _then) = _$DashboardSummaryCopyWithImpl;
@useResult
$Res call({
 int totalProducts, double totalStockQuantity, double totalStockValue, int lowStockProducts, int outOfStockProducts, ActivityCount todaysSales, ActivityCount todaysPurchases, ActivityCount todaysExpenses, ActivityCount thisMonthExpenses
});


$ActivityCountCopyWith<$Res> get todaysSales;$ActivityCountCopyWith<$Res> get todaysPurchases;$ActivityCountCopyWith<$Res> get todaysExpenses;$ActivityCountCopyWith<$Res> get thisMonthExpenses;

}
/// @nodoc
class _$DashboardSummaryCopyWithImpl<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  _$DashboardSummaryCopyWithImpl(this._self, this._then);

  final DashboardSummary _self;
  final $Res Function(DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalProducts = null,Object? totalStockQuantity = null,Object? totalStockValue = null,Object? lowStockProducts = null,Object? outOfStockProducts = null,Object? todaysSales = null,Object? todaysPurchases = null,Object? todaysExpenses = null,Object? thisMonthExpenses = null,}) {
  return _then(_self.copyWith(
totalProducts: null == totalProducts ? _self.totalProducts : totalProducts // ignore: cast_nullable_to_non_nullable
as int,totalStockQuantity: null == totalStockQuantity ? _self.totalStockQuantity : totalStockQuantity // ignore: cast_nullable_to_non_nullable
as double,totalStockValue: null == totalStockValue ? _self.totalStockValue : totalStockValue // ignore: cast_nullable_to_non_nullable
as double,lowStockProducts: null == lowStockProducts ? _self.lowStockProducts : lowStockProducts // ignore: cast_nullable_to_non_nullable
as int,outOfStockProducts: null == outOfStockProducts ? _self.outOfStockProducts : outOfStockProducts // ignore: cast_nullable_to_non_nullable
as int,todaysSales: null == todaysSales ? _self.todaysSales : todaysSales // ignore: cast_nullable_to_non_nullable
as ActivityCount,todaysPurchases: null == todaysPurchases ? _self.todaysPurchases : todaysPurchases // ignore: cast_nullable_to_non_nullable
as ActivityCount,todaysExpenses: null == todaysExpenses ? _self.todaysExpenses : todaysExpenses // ignore: cast_nullable_to_non_nullable
as ActivityCount,thisMonthExpenses: null == thisMonthExpenses ? _self.thisMonthExpenses : thisMonthExpenses // ignore: cast_nullable_to_non_nullable
as ActivityCount,
  ));
}
/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityCountCopyWith<$Res> get todaysSales {
  
  return $ActivityCountCopyWith<$Res>(_self.todaysSales, (value) {
    return _then(_self.copyWith(todaysSales: value));
  });
}/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityCountCopyWith<$Res> get todaysPurchases {
  
  return $ActivityCountCopyWith<$Res>(_self.todaysPurchases, (value) {
    return _then(_self.copyWith(todaysPurchases: value));
  });
}/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityCountCopyWith<$Res> get todaysExpenses {
  
  return $ActivityCountCopyWith<$Res>(_self.todaysExpenses, (value) {
    return _then(_self.copyWith(todaysExpenses: value));
  });
}/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityCountCopyWith<$Res> get thisMonthExpenses {
  
  return $ActivityCountCopyWith<$Res>(_self.thisMonthExpenses, (value) {
    return _then(_self.copyWith(thisMonthExpenses: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardSummary].
extension DashboardSummaryPatterns on DashboardSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardSummary value)  $default,){
final _that = this;
switch (_that) {
case _DashboardSummary():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardSummary value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalProducts,  double totalStockQuantity,  double totalStockValue,  int lowStockProducts,  int outOfStockProducts,  ActivityCount todaysSales,  ActivityCount todaysPurchases,  ActivityCount todaysExpenses,  ActivityCount thisMonthExpenses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that.totalProducts,_that.totalStockQuantity,_that.totalStockValue,_that.lowStockProducts,_that.outOfStockProducts,_that.todaysSales,_that.todaysPurchases,_that.todaysExpenses,_that.thisMonthExpenses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalProducts,  double totalStockQuantity,  double totalStockValue,  int lowStockProducts,  int outOfStockProducts,  ActivityCount todaysSales,  ActivityCount todaysPurchases,  ActivityCount todaysExpenses,  ActivityCount thisMonthExpenses)  $default,) {final _that = this;
switch (_that) {
case _DashboardSummary():
return $default(_that.totalProducts,_that.totalStockQuantity,_that.totalStockValue,_that.lowStockProducts,_that.outOfStockProducts,_that.todaysSales,_that.todaysPurchases,_that.todaysExpenses,_that.thisMonthExpenses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalProducts,  double totalStockQuantity,  double totalStockValue,  int lowStockProducts,  int outOfStockProducts,  ActivityCount todaysSales,  ActivityCount todaysPurchases,  ActivityCount todaysExpenses,  ActivityCount thisMonthExpenses)?  $default,) {final _that = this;
switch (_that) {
case _DashboardSummary() when $default != null:
return $default(_that.totalProducts,_that.totalStockQuantity,_that.totalStockValue,_that.lowStockProducts,_that.outOfStockProducts,_that.todaysSales,_that.todaysPurchases,_that.todaysExpenses,_that.thisMonthExpenses);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardSummary implements DashboardSummary {
  const _DashboardSummary({required this.totalProducts, required this.totalStockQuantity, required this.totalStockValue, required this.lowStockProducts, required this.outOfStockProducts, required this.todaysSales, required this.todaysPurchases, required this.todaysExpenses, required this.thisMonthExpenses});
  

@override final  int totalProducts;
@override final  double totalStockQuantity;
@override final  double totalStockValue;
@override final  int lowStockProducts;
@override final  int outOfStockProducts;
@override final  ActivityCount todaysSales;
@override final  ActivityCount todaysPurchases;
@override final  ActivityCount todaysExpenses;
@override final  ActivityCount thisMonthExpenses;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardSummaryCopyWith<_DashboardSummary> get copyWith => __$DashboardSummaryCopyWithImpl<_DashboardSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardSummary&&(identical(other.totalProducts, totalProducts) || other.totalProducts == totalProducts)&&(identical(other.totalStockQuantity, totalStockQuantity) || other.totalStockQuantity == totalStockQuantity)&&(identical(other.totalStockValue, totalStockValue) || other.totalStockValue == totalStockValue)&&(identical(other.lowStockProducts, lowStockProducts) || other.lowStockProducts == lowStockProducts)&&(identical(other.outOfStockProducts, outOfStockProducts) || other.outOfStockProducts == outOfStockProducts)&&(identical(other.todaysSales, todaysSales) || other.todaysSales == todaysSales)&&(identical(other.todaysPurchases, todaysPurchases) || other.todaysPurchases == todaysPurchases)&&(identical(other.todaysExpenses, todaysExpenses) || other.todaysExpenses == todaysExpenses)&&(identical(other.thisMonthExpenses, thisMonthExpenses) || other.thisMonthExpenses == thisMonthExpenses));
}


@override
int get hashCode => Object.hash(runtimeType,totalProducts,totalStockQuantity,totalStockValue,lowStockProducts,outOfStockProducts,todaysSales,todaysPurchases,todaysExpenses,thisMonthExpenses);

@override
String toString() {
  return 'DashboardSummary(totalProducts: $totalProducts, totalStockQuantity: $totalStockQuantity, totalStockValue: $totalStockValue, lowStockProducts: $lowStockProducts, outOfStockProducts: $outOfStockProducts, todaysSales: $todaysSales, todaysPurchases: $todaysPurchases, todaysExpenses: $todaysExpenses, thisMonthExpenses: $thisMonthExpenses)';
}


}

/// @nodoc
abstract mixin class _$DashboardSummaryCopyWith<$Res> implements $DashboardSummaryCopyWith<$Res> {
  factory _$DashboardSummaryCopyWith(_DashboardSummary value, $Res Function(_DashboardSummary) _then) = __$DashboardSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalProducts, double totalStockQuantity, double totalStockValue, int lowStockProducts, int outOfStockProducts, ActivityCount todaysSales, ActivityCount todaysPurchases, ActivityCount todaysExpenses, ActivityCount thisMonthExpenses
});


@override $ActivityCountCopyWith<$Res> get todaysSales;@override $ActivityCountCopyWith<$Res> get todaysPurchases;@override $ActivityCountCopyWith<$Res> get todaysExpenses;@override $ActivityCountCopyWith<$Res> get thisMonthExpenses;

}
/// @nodoc
class __$DashboardSummaryCopyWithImpl<$Res>
    implements _$DashboardSummaryCopyWith<$Res> {
  __$DashboardSummaryCopyWithImpl(this._self, this._then);

  final _DashboardSummary _self;
  final $Res Function(_DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalProducts = null,Object? totalStockQuantity = null,Object? totalStockValue = null,Object? lowStockProducts = null,Object? outOfStockProducts = null,Object? todaysSales = null,Object? todaysPurchases = null,Object? todaysExpenses = null,Object? thisMonthExpenses = null,}) {
  return _then(_DashboardSummary(
totalProducts: null == totalProducts ? _self.totalProducts : totalProducts // ignore: cast_nullable_to_non_nullable
as int,totalStockQuantity: null == totalStockQuantity ? _self.totalStockQuantity : totalStockQuantity // ignore: cast_nullable_to_non_nullable
as double,totalStockValue: null == totalStockValue ? _self.totalStockValue : totalStockValue // ignore: cast_nullable_to_non_nullable
as double,lowStockProducts: null == lowStockProducts ? _self.lowStockProducts : lowStockProducts // ignore: cast_nullable_to_non_nullable
as int,outOfStockProducts: null == outOfStockProducts ? _self.outOfStockProducts : outOfStockProducts // ignore: cast_nullable_to_non_nullable
as int,todaysSales: null == todaysSales ? _self.todaysSales : todaysSales // ignore: cast_nullable_to_non_nullable
as ActivityCount,todaysPurchases: null == todaysPurchases ? _self.todaysPurchases : todaysPurchases // ignore: cast_nullable_to_non_nullable
as ActivityCount,todaysExpenses: null == todaysExpenses ? _self.todaysExpenses : todaysExpenses // ignore: cast_nullable_to_non_nullable
as ActivityCount,thisMonthExpenses: null == thisMonthExpenses ? _self.thisMonthExpenses : thisMonthExpenses // ignore: cast_nullable_to_non_nullable
as ActivityCount,
  ));
}

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityCountCopyWith<$Res> get todaysSales {
  
  return $ActivityCountCopyWith<$Res>(_self.todaysSales, (value) {
    return _then(_self.copyWith(todaysSales: value));
  });
}/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityCountCopyWith<$Res> get todaysPurchases {
  
  return $ActivityCountCopyWith<$Res>(_self.todaysPurchases, (value) {
    return _then(_self.copyWith(todaysPurchases: value));
  });
}/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityCountCopyWith<$Res> get todaysExpenses {
  
  return $ActivityCountCopyWith<$Res>(_self.todaysExpenses, (value) {
    return _then(_self.copyWith(todaysExpenses: value));
  });
}/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivityCountCopyWith<$Res> get thisMonthExpenses {
  
  return $ActivityCountCopyWith<$Res>(_self.thisMonthExpenses, (value) {
    return _then(_self.copyWith(thisMonthExpenses: value));
  });
}
}

// dart format on
