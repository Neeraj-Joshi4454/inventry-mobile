// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExpenseActivityCount {

 int get count; double get amount;
/// Create a copy of ExpenseActivityCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseActivityCountCopyWith<ExpenseActivityCount> get copyWith => _$ExpenseActivityCountCopyWithImpl<ExpenseActivityCount>(this as ExpenseActivityCount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseActivityCount&&(identical(other.count, count) || other.count == count)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,count,amount);

@override
String toString() {
  return 'ExpenseActivityCount(count: $count, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $ExpenseActivityCountCopyWith<$Res>  {
  factory $ExpenseActivityCountCopyWith(ExpenseActivityCount value, $Res Function(ExpenseActivityCount) _then) = _$ExpenseActivityCountCopyWithImpl;
@useResult
$Res call({
 int count, double amount
});




}
/// @nodoc
class _$ExpenseActivityCountCopyWithImpl<$Res>
    implements $ExpenseActivityCountCopyWith<$Res> {
  _$ExpenseActivityCountCopyWithImpl(this._self, this._then);

  final ExpenseActivityCount _self;
  final $Res Function(ExpenseActivityCount) _then;

/// Create a copy of ExpenseActivityCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? amount = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseActivityCount].
extension ExpenseActivityCountPatterns on ExpenseActivityCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseActivityCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseActivityCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseActivityCount value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseActivityCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseActivityCount value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseActivityCount() when $default != null:
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
case _ExpenseActivityCount() when $default != null:
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
case _ExpenseActivityCount():
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
case _ExpenseActivityCount() when $default != null:
return $default(_that.count,_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class _ExpenseActivityCount implements ExpenseActivityCount {
  const _ExpenseActivityCount({required this.count, required this.amount});
  

@override final  int count;
@override final  double amount;

/// Create a copy of ExpenseActivityCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseActivityCountCopyWith<_ExpenseActivityCount> get copyWith => __$ExpenseActivityCountCopyWithImpl<_ExpenseActivityCount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseActivityCount&&(identical(other.count, count) || other.count == count)&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,count,amount);

@override
String toString() {
  return 'ExpenseActivityCount(count: $count, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$ExpenseActivityCountCopyWith<$Res> implements $ExpenseActivityCountCopyWith<$Res> {
  factory _$ExpenseActivityCountCopyWith(_ExpenseActivityCount value, $Res Function(_ExpenseActivityCount) _then) = __$ExpenseActivityCountCopyWithImpl;
@override @useResult
$Res call({
 int count, double amount
});




}
/// @nodoc
class __$ExpenseActivityCountCopyWithImpl<$Res>
    implements _$ExpenseActivityCountCopyWith<$Res> {
  __$ExpenseActivityCountCopyWithImpl(this._self, this._then);

  final _ExpenseActivityCount _self;
  final $Res Function(_ExpenseActivityCount) _then;

/// Create a copy of ExpenseActivityCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? amount = null,}) {
  return _then(_ExpenseActivityCount(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$PreviousMonthComparison {

 double get previousMonthAmount; double get currentMonthAmount; double get change; double get changePercent;
/// Create a copy of PreviousMonthComparison
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PreviousMonthComparisonCopyWith<PreviousMonthComparison> get copyWith => _$PreviousMonthComparisonCopyWithImpl<PreviousMonthComparison>(this as PreviousMonthComparison, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PreviousMonthComparison&&(identical(other.previousMonthAmount, previousMonthAmount) || other.previousMonthAmount == previousMonthAmount)&&(identical(other.currentMonthAmount, currentMonthAmount) || other.currentMonthAmount == currentMonthAmount)&&(identical(other.change, change) || other.change == change)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent));
}


@override
int get hashCode => Object.hash(runtimeType,previousMonthAmount,currentMonthAmount,change,changePercent);

@override
String toString() {
  return 'PreviousMonthComparison(previousMonthAmount: $previousMonthAmount, currentMonthAmount: $currentMonthAmount, change: $change, changePercent: $changePercent)';
}


}

/// @nodoc
abstract mixin class $PreviousMonthComparisonCopyWith<$Res>  {
  factory $PreviousMonthComparisonCopyWith(PreviousMonthComparison value, $Res Function(PreviousMonthComparison) _then) = _$PreviousMonthComparisonCopyWithImpl;
@useResult
$Res call({
 double previousMonthAmount, double currentMonthAmount, double change, double changePercent
});




}
/// @nodoc
class _$PreviousMonthComparisonCopyWithImpl<$Res>
    implements $PreviousMonthComparisonCopyWith<$Res> {
  _$PreviousMonthComparisonCopyWithImpl(this._self, this._then);

  final PreviousMonthComparison _self;
  final $Res Function(PreviousMonthComparison) _then;

/// Create a copy of PreviousMonthComparison
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? previousMonthAmount = null,Object? currentMonthAmount = null,Object? change = null,Object? changePercent = null,}) {
  return _then(_self.copyWith(
previousMonthAmount: null == previousMonthAmount ? _self.previousMonthAmount : previousMonthAmount // ignore: cast_nullable_to_non_nullable
as double,currentMonthAmount: null == currentMonthAmount ? _self.currentMonthAmount : currentMonthAmount // ignore: cast_nullable_to_non_nullable
as double,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PreviousMonthComparison].
extension PreviousMonthComparisonPatterns on PreviousMonthComparison {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PreviousMonthComparison value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PreviousMonthComparison() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PreviousMonthComparison value)  $default,){
final _that = this;
switch (_that) {
case _PreviousMonthComparison():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PreviousMonthComparison value)?  $default,){
final _that = this;
switch (_that) {
case _PreviousMonthComparison() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double previousMonthAmount,  double currentMonthAmount,  double change,  double changePercent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PreviousMonthComparison() when $default != null:
return $default(_that.previousMonthAmount,_that.currentMonthAmount,_that.change,_that.changePercent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double previousMonthAmount,  double currentMonthAmount,  double change,  double changePercent)  $default,) {final _that = this;
switch (_that) {
case _PreviousMonthComparison():
return $default(_that.previousMonthAmount,_that.currentMonthAmount,_that.change,_that.changePercent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double previousMonthAmount,  double currentMonthAmount,  double change,  double changePercent)?  $default,) {final _that = this;
switch (_that) {
case _PreviousMonthComparison() when $default != null:
return $default(_that.previousMonthAmount,_that.currentMonthAmount,_that.change,_that.changePercent);case _:
  return null;

}
}

}

/// @nodoc


class _PreviousMonthComparison implements PreviousMonthComparison {
  const _PreviousMonthComparison({required this.previousMonthAmount, required this.currentMonthAmount, required this.change, required this.changePercent});
  

@override final  double previousMonthAmount;
@override final  double currentMonthAmount;
@override final  double change;
@override final  double changePercent;

/// Create a copy of PreviousMonthComparison
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PreviousMonthComparisonCopyWith<_PreviousMonthComparison> get copyWith => __$PreviousMonthComparisonCopyWithImpl<_PreviousMonthComparison>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PreviousMonthComparison&&(identical(other.previousMonthAmount, previousMonthAmount) || other.previousMonthAmount == previousMonthAmount)&&(identical(other.currentMonthAmount, currentMonthAmount) || other.currentMonthAmount == currentMonthAmount)&&(identical(other.change, change) || other.change == change)&&(identical(other.changePercent, changePercent) || other.changePercent == changePercent));
}


@override
int get hashCode => Object.hash(runtimeType,previousMonthAmount,currentMonthAmount,change,changePercent);

@override
String toString() {
  return 'PreviousMonthComparison(previousMonthAmount: $previousMonthAmount, currentMonthAmount: $currentMonthAmount, change: $change, changePercent: $changePercent)';
}


}

/// @nodoc
abstract mixin class _$PreviousMonthComparisonCopyWith<$Res> implements $PreviousMonthComparisonCopyWith<$Res> {
  factory _$PreviousMonthComparisonCopyWith(_PreviousMonthComparison value, $Res Function(_PreviousMonthComparison) _then) = __$PreviousMonthComparisonCopyWithImpl;
@override @useResult
$Res call({
 double previousMonthAmount, double currentMonthAmount, double change, double changePercent
});




}
/// @nodoc
class __$PreviousMonthComparisonCopyWithImpl<$Res>
    implements _$PreviousMonthComparisonCopyWith<$Res> {
  __$PreviousMonthComparisonCopyWithImpl(this._self, this._then);

  final _PreviousMonthComparison _self;
  final $Res Function(_PreviousMonthComparison) _then;

/// Create a copy of PreviousMonthComparison
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? previousMonthAmount = null,Object? currentMonthAmount = null,Object? change = null,Object? changePercent = null,}) {
  return _then(_PreviousMonthComparison(
previousMonthAmount: null == previousMonthAmount ? _self.previousMonthAmount : previousMonthAmount // ignore: cast_nullable_to_non_nullable
as double,currentMonthAmount: null == currentMonthAmount ? _self.currentMonthAmount : currentMonthAmount // ignore: cast_nullable_to_non_nullable
as double,change: null == change ? _self.change : change // ignore: cast_nullable_to_non_nullable
as double,changePercent: null == changePercent ? _self.changePercent : changePercent // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$ExpenseCategorySummaryRow {

 String get categoryId; String get categoryName; double get amount; int get count;
/// Create a copy of ExpenseCategorySummaryRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseCategorySummaryRowCopyWith<ExpenseCategorySummaryRow> get copyWith => _$ExpenseCategorySummaryRowCopyWithImpl<ExpenseCategorySummaryRow>(this as ExpenseCategorySummaryRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseCategorySummaryRow&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,categoryName,amount,count);

@override
String toString() {
  return 'ExpenseCategorySummaryRow(categoryId: $categoryId, categoryName: $categoryName, amount: $amount, count: $count)';
}


}

/// @nodoc
abstract mixin class $ExpenseCategorySummaryRowCopyWith<$Res>  {
  factory $ExpenseCategorySummaryRowCopyWith(ExpenseCategorySummaryRow value, $Res Function(ExpenseCategorySummaryRow) _then) = _$ExpenseCategorySummaryRowCopyWithImpl;
@useResult
$Res call({
 String categoryId, String categoryName, double amount, int count
});




}
/// @nodoc
class _$ExpenseCategorySummaryRowCopyWithImpl<$Res>
    implements $ExpenseCategorySummaryRowCopyWith<$Res> {
  _$ExpenseCategorySummaryRowCopyWithImpl(this._self, this._then);

  final ExpenseCategorySummaryRow _self;
  final $Res Function(ExpenseCategorySummaryRow) _then;

/// Create a copy of ExpenseCategorySummaryRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? categoryName = null,Object? amount = null,Object? count = null,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseCategorySummaryRow].
extension ExpenseCategorySummaryRowPatterns on ExpenseCategorySummaryRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseCategorySummaryRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseCategorySummaryRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseCategorySummaryRow value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseCategorySummaryRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseCategorySummaryRow value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseCategorySummaryRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  String categoryName,  double amount,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseCategorySummaryRow() when $default != null:
return $default(_that.categoryId,_that.categoryName,_that.amount,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  String categoryName,  double amount,  int count)  $default,) {final _that = this;
switch (_that) {
case _ExpenseCategorySummaryRow():
return $default(_that.categoryId,_that.categoryName,_that.amount,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  String categoryName,  double amount,  int count)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseCategorySummaryRow() when $default != null:
return $default(_that.categoryId,_that.categoryName,_that.amount,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _ExpenseCategorySummaryRow implements ExpenseCategorySummaryRow {
  const _ExpenseCategorySummaryRow({required this.categoryId, required this.categoryName, required this.amount, required this.count});
  

@override final  String categoryId;
@override final  String categoryName;
@override final  double amount;
@override final  int count;

/// Create a copy of ExpenseCategorySummaryRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseCategorySummaryRowCopyWith<_ExpenseCategorySummaryRow> get copyWith => __$ExpenseCategorySummaryRowCopyWithImpl<_ExpenseCategorySummaryRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseCategorySummaryRow&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,categoryName,amount,count);

@override
String toString() {
  return 'ExpenseCategorySummaryRow(categoryId: $categoryId, categoryName: $categoryName, amount: $amount, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ExpenseCategorySummaryRowCopyWith<$Res> implements $ExpenseCategorySummaryRowCopyWith<$Res> {
  factory _$ExpenseCategorySummaryRowCopyWith(_ExpenseCategorySummaryRow value, $Res Function(_ExpenseCategorySummaryRow) _then) = __$ExpenseCategorySummaryRowCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, String categoryName, double amount, int count
});




}
/// @nodoc
class __$ExpenseCategorySummaryRowCopyWithImpl<$Res>
    implements _$ExpenseCategorySummaryRowCopyWith<$Res> {
  __$ExpenseCategorySummaryRowCopyWithImpl(this._self, this._then);

  final _ExpenseCategorySummaryRow _self;
  final $Res Function(_ExpenseCategorySummaryRow) _then;

/// Create a copy of ExpenseCategorySummaryRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? categoryName = null,Object? amount = null,Object? count = null,}) {
  return _then(_ExpenseCategorySummaryRow(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ExpenseMethodSummaryRow {

 String get paymentMethod; double get amount; int get count;
/// Create a copy of ExpenseMethodSummaryRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseMethodSummaryRowCopyWith<ExpenseMethodSummaryRow> get copyWith => _$ExpenseMethodSummaryRowCopyWithImpl<ExpenseMethodSummaryRow>(this as ExpenseMethodSummaryRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseMethodSummaryRow&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,paymentMethod,amount,count);

@override
String toString() {
  return 'ExpenseMethodSummaryRow(paymentMethod: $paymentMethod, amount: $amount, count: $count)';
}


}

/// @nodoc
abstract mixin class $ExpenseMethodSummaryRowCopyWith<$Res>  {
  factory $ExpenseMethodSummaryRowCopyWith(ExpenseMethodSummaryRow value, $Res Function(ExpenseMethodSummaryRow) _then) = _$ExpenseMethodSummaryRowCopyWithImpl;
@useResult
$Res call({
 String paymentMethod, double amount, int count
});




}
/// @nodoc
class _$ExpenseMethodSummaryRowCopyWithImpl<$Res>
    implements $ExpenseMethodSummaryRowCopyWith<$Res> {
  _$ExpenseMethodSummaryRowCopyWithImpl(this._self, this._then);

  final ExpenseMethodSummaryRow _self;
  final $Res Function(ExpenseMethodSummaryRow) _then;

/// Create a copy of ExpenseMethodSummaryRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentMethod = null,Object? amount = null,Object? count = null,}) {
  return _then(_self.copyWith(
paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseMethodSummaryRow].
extension ExpenseMethodSummaryRowPatterns on ExpenseMethodSummaryRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseMethodSummaryRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseMethodSummaryRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseMethodSummaryRow value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseMethodSummaryRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseMethodSummaryRow value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseMethodSummaryRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentMethod,  double amount,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseMethodSummaryRow() when $default != null:
return $default(_that.paymentMethod,_that.amount,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentMethod,  double amount,  int count)  $default,) {final _that = this;
switch (_that) {
case _ExpenseMethodSummaryRow():
return $default(_that.paymentMethod,_that.amount,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentMethod,  double amount,  int count)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseMethodSummaryRow() when $default != null:
return $default(_that.paymentMethod,_that.amount,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _ExpenseMethodSummaryRow implements ExpenseMethodSummaryRow {
  const _ExpenseMethodSummaryRow({required this.paymentMethod, required this.amount, required this.count});
  

@override final  String paymentMethod;
@override final  double amount;
@override final  int count;

/// Create a copy of ExpenseMethodSummaryRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseMethodSummaryRowCopyWith<_ExpenseMethodSummaryRow> get copyWith => __$ExpenseMethodSummaryRowCopyWithImpl<_ExpenseMethodSummaryRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseMethodSummaryRow&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,paymentMethod,amount,count);

@override
String toString() {
  return 'ExpenseMethodSummaryRow(paymentMethod: $paymentMethod, amount: $amount, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ExpenseMethodSummaryRowCopyWith<$Res> implements $ExpenseMethodSummaryRowCopyWith<$Res> {
  factory _$ExpenseMethodSummaryRowCopyWith(_ExpenseMethodSummaryRow value, $Res Function(_ExpenseMethodSummaryRow) _then) = __$ExpenseMethodSummaryRowCopyWithImpl;
@override @useResult
$Res call({
 String paymentMethod, double amount, int count
});




}
/// @nodoc
class __$ExpenseMethodSummaryRowCopyWithImpl<$Res>
    implements _$ExpenseMethodSummaryRowCopyWith<$Res> {
  __$ExpenseMethodSummaryRowCopyWithImpl(this._self, this._then);

  final _ExpenseMethodSummaryRow _self;
  final $Res Function(_ExpenseMethodSummaryRow) _then;

/// Create a copy of ExpenseMethodSummaryRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentMethod = null,Object? amount = null,Object? count = null,}) {
  return _then(_ExpenseMethodSummaryRow(
paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ExpenseSummary {

 ExpenseActivityCount get todayExpenses; ExpenseActivityCount get thisMonthExpenses; ExpenseActivityCount get totalExpenses; PreviousMonthComparison get previousMonthComparison; List<ExpenseCategorySummaryRow> get expensesByCategory; List<ExpenseMethodSummaryRow> get expensesByPaymentMethod;
/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseSummaryCopyWith<ExpenseSummary> get copyWith => _$ExpenseSummaryCopyWithImpl<ExpenseSummary>(this as ExpenseSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseSummary&&(identical(other.todayExpenses, todayExpenses) || other.todayExpenses == todayExpenses)&&(identical(other.thisMonthExpenses, thisMonthExpenses) || other.thisMonthExpenses == thisMonthExpenses)&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses)&&(identical(other.previousMonthComparison, previousMonthComparison) || other.previousMonthComparison == previousMonthComparison)&&const DeepCollectionEquality().equals(other.expensesByCategory, expensesByCategory)&&const DeepCollectionEquality().equals(other.expensesByPaymentMethod, expensesByPaymentMethod));
}


@override
int get hashCode => Object.hash(runtimeType,todayExpenses,thisMonthExpenses,totalExpenses,previousMonthComparison,const DeepCollectionEquality().hash(expensesByCategory),const DeepCollectionEquality().hash(expensesByPaymentMethod));

@override
String toString() {
  return 'ExpenseSummary(todayExpenses: $todayExpenses, thisMonthExpenses: $thisMonthExpenses, totalExpenses: $totalExpenses, previousMonthComparison: $previousMonthComparison, expensesByCategory: $expensesByCategory, expensesByPaymentMethod: $expensesByPaymentMethod)';
}


}

/// @nodoc
abstract mixin class $ExpenseSummaryCopyWith<$Res>  {
  factory $ExpenseSummaryCopyWith(ExpenseSummary value, $Res Function(ExpenseSummary) _then) = _$ExpenseSummaryCopyWithImpl;
@useResult
$Res call({
 ExpenseActivityCount todayExpenses, ExpenseActivityCount thisMonthExpenses, ExpenseActivityCount totalExpenses, PreviousMonthComparison previousMonthComparison, List<ExpenseCategorySummaryRow> expensesByCategory, List<ExpenseMethodSummaryRow> expensesByPaymentMethod
});


$ExpenseActivityCountCopyWith<$Res> get todayExpenses;$ExpenseActivityCountCopyWith<$Res> get thisMonthExpenses;$ExpenseActivityCountCopyWith<$Res> get totalExpenses;$PreviousMonthComparisonCopyWith<$Res> get previousMonthComparison;

}
/// @nodoc
class _$ExpenseSummaryCopyWithImpl<$Res>
    implements $ExpenseSummaryCopyWith<$Res> {
  _$ExpenseSummaryCopyWithImpl(this._self, this._then);

  final ExpenseSummary _self;
  final $Res Function(ExpenseSummary) _then;

/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? todayExpenses = null,Object? thisMonthExpenses = null,Object? totalExpenses = null,Object? previousMonthComparison = null,Object? expensesByCategory = null,Object? expensesByPaymentMethod = null,}) {
  return _then(_self.copyWith(
todayExpenses: null == todayExpenses ? _self.todayExpenses : todayExpenses // ignore: cast_nullable_to_non_nullable
as ExpenseActivityCount,thisMonthExpenses: null == thisMonthExpenses ? _self.thisMonthExpenses : thisMonthExpenses // ignore: cast_nullable_to_non_nullable
as ExpenseActivityCount,totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as ExpenseActivityCount,previousMonthComparison: null == previousMonthComparison ? _self.previousMonthComparison : previousMonthComparison // ignore: cast_nullable_to_non_nullable
as PreviousMonthComparison,expensesByCategory: null == expensesByCategory ? _self.expensesByCategory : expensesByCategory // ignore: cast_nullable_to_non_nullable
as List<ExpenseCategorySummaryRow>,expensesByPaymentMethod: null == expensesByPaymentMethod ? _self.expensesByPaymentMethod : expensesByPaymentMethod // ignore: cast_nullable_to_non_nullable
as List<ExpenseMethodSummaryRow>,
  ));
}
/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseActivityCountCopyWith<$Res> get todayExpenses {
  
  return $ExpenseActivityCountCopyWith<$Res>(_self.todayExpenses, (value) {
    return _then(_self.copyWith(todayExpenses: value));
  });
}/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseActivityCountCopyWith<$Res> get thisMonthExpenses {
  
  return $ExpenseActivityCountCopyWith<$Res>(_self.thisMonthExpenses, (value) {
    return _then(_self.copyWith(thisMonthExpenses: value));
  });
}/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseActivityCountCopyWith<$Res> get totalExpenses {
  
  return $ExpenseActivityCountCopyWith<$Res>(_self.totalExpenses, (value) {
    return _then(_self.copyWith(totalExpenses: value));
  });
}/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PreviousMonthComparisonCopyWith<$Res> get previousMonthComparison {
  
  return $PreviousMonthComparisonCopyWith<$Res>(_self.previousMonthComparison, (value) {
    return _then(_self.copyWith(previousMonthComparison: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExpenseSummary].
extension ExpenseSummaryPatterns on ExpenseSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseSummary value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExpenseActivityCount todayExpenses,  ExpenseActivityCount thisMonthExpenses,  ExpenseActivityCount totalExpenses,  PreviousMonthComparison previousMonthComparison,  List<ExpenseCategorySummaryRow> expensesByCategory,  List<ExpenseMethodSummaryRow> expensesByPaymentMethod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
return $default(_that.todayExpenses,_that.thisMonthExpenses,_that.totalExpenses,_that.previousMonthComparison,_that.expensesByCategory,_that.expensesByPaymentMethod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExpenseActivityCount todayExpenses,  ExpenseActivityCount thisMonthExpenses,  ExpenseActivityCount totalExpenses,  PreviousMonthComparison previousMonthComparison,  List<ExpenseCategorySummaryRow> expensesByCategory,  List<ExpenseMethodSummaryRow> expensesByPaymentMethod)  $default,) {final _that = this;
switch (_that) {
case _ExpenseSummary():
return $default(_that.todayExpenses,_that.thisMonthExpenses,_that.totalExpenses,_that.previousMonthComparison,_that.expensesByCategory,_that.expensesByPaymentMethod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExpenseActivityCount todayExpenses,  ExpenseActivityCount thisMonthExpenses,  ExpenseActivityCount totalExpenses,  PreviousMonthComparison previousMonthComparison,  List<ExpenseCategorySummaryRow> expensesByCategory,  List<ExpenseMethodSummaryRow> expensesByPaymentMethod)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseSummary() when $default != null:
return $default(_that.todayExpenses,_that.thisMonthExpenses,_that.totalExpenses,_that.previousMonthComparison,_that.expensesByCategory,_that.expensesByPaymentMethod);case _:
  return null;

}
}

}

/// @nodoc


class _ExpenseSummary implements ExpenseSummary {
  const _ExpenseSummary({required this.todayExpenses, required this.thisMonthExpenses, required this.totalExpenses, required this.previousMonthComparison, required final  List<ExpenseCategorySummaryRow> expensesByCategory, required final  List<ExpenseMethodSummaryRow> expensesByPaymentMethod}): _expensesByCategory = expensesByCategory,_expensesByPaymentMethod = expensesByPaymentMethod;
  

@override final  ExpenseActivityCount todayExpenses;
@override final  ExpenseActivityCount thisMonthExpenses;
@override final  ExpenseActivityCount totalExpenses;
@override final  PreviousMonthComparison previousMonthComparison;
 final  List<ExpenseCategorySummaryRow> _expensesByCategory;
@override List<ExpenseCategorySummaryRow> get expensesByCategory {
  if (_expensesByCategory is EqualUnmodifiableListView) return _expensesByCategory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expensesByCategory);
}

 final  List<ExpenseMethodSummaryRow> _expensesByPaymentMethod;
@override List<ExpenseMethodSummaryRow> get expensesByPaymentMethod {
  if (_expensesByPaymentMethod is EqualUnmodifiableListView) return _expensesByPaymentMethod;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expensesByPaymentMethod);
}


/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseSummaryCopyWith<_ExpenseSummary> get copyWith => __$ExpenseSummaryCopyWithImpl<_ExpenseSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseSummary&&(identical(other.todayExpenses, todayExpenses) || other.todayExpenses == todayExpenses)&&(identical(other.thisMonthExpenses, thisMonthExpenses) || other.thisMonthExpenses == thisMonthExpenses)&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses)&&(identical(other.previousMonthComparison, previousMonthComparison) || other.previousMonthComparison == previousMonthComparison)&&const DeepCollectionEquality().equals(other._expensesByCategory, _expensesByCategory)&&const DeepCollectionEquality().equals(other._expensesByPaymentMethod, _expensesByPaymentMethod));
}


@override
int get hashCode => Object.hash(runtimeType,todayExpenses,thisMonthExpenses,totalExpenses,previousMonthComparison,const DeepCollectionEquality().hash(_expensesByCategory),const DeepCollectionEquality().hash(_expensesByPaymentMethod));

@override
String toString() {
  return 'ExpenseSummary(todayExpenses: $todayExpenses, thisMonthExpenses: $thisMonthExpenses, totalExpenses: $totalExpenses, previousMonthComparison: $previousMonthComparison, expensesByCategory: $expensesByCategory, expensesByPaymentMethod: $expensesByPaymentMethod)';
}


}

/// @nodoc
abstract mixin class _$ExpenseSummaryCopyWith<$Res> implements $ExpenseSummaryCopyWith<$Res> {
  factory _$ExpenseSummaryCopyWith(_ExpenseSummary value, $Res Function(_ExpenseSummary) _then) = __$ExpenseSummaryCopyWithImpl;
@override @useResult
$Res call({
 ExpenseActivityCount todayExpenses, ExpenseActivityCount thisMonthExpenses, ExpenseActivityCount totalExpenses, PreviousMonthComparison previousMonthComparison, List<ExpenseCategorySummaryRow> expensesByCategory, List<ExpenseMethodSummaryRow> expensesByPaymentMethod
});


@override $ExpenseActivityCountCopyWith<$Res> get todayExpenses;@override $ExpenseActivityCountCopyWith<$Res> get thisMonthExpenses;@override $ExpenseActivityCountCopyWith<$Res> get totalExpenses;@override $PreviousMonthComparisonCopyWith<$Res> get previousMonthComparison;

}
/// @nodoc
class __$ExpenseSummaryCopyWithImpl<$Res>
    implements _$ExpenseSummaryCopyWith<$Res> {
  __$ExpenseSummaryCopyWithImpl(this._self, this._then);

  final _ExpenseSummary _self;
  final $Res Function(_ExpenseSummary) _then;

/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? todayExpenses = null,Object? thisMonthExpenses = null,Object? totalExpenses = null,Object? previousMonthComparison = null,Object? expensesByCategory = null,Object? expensesByPaymentMethod = null,}) {
  return _then(_ExpenseSummary(
todayExpenses: null == todayExpenses ? _self.todayExpenses : todayExpenses // ignore: cast_nullable_to_non_nullable
as ExpenseActivityCount,thisMonthExpenses: null == thisMonthExpenses ? _self.thisMonthExpenses : thisMonthExpenses // ignore: cast_nullable_to_non_nullable
as ExpenseActivityCount,totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as ExpenseActivityCount,previousMonthComparison: null == previousMonthComparison ? _self.previousMonthComparison : previousMonthComparison // ignore: cast_nullable_to_non_nullable
as PreviousMonthComparison,expensesByCategory: null == expensesByCategory ? _self._expensesByCategory : expensesByCategory // ignore: cast_nullable_to_non_nullable
as List<ExpenseCategorySummaryRow>,expensesByPaymentMethod: null == expensesByPaymentMethod ? _self._expensesByPaymentMethod : expensesByPaymentMethod // ignore: cast_nullable_to_non_nullable
as List<ExpenseMethodSummaryRow>,
  ));
}

/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseActivityCountCopyWith<$Res> get todayExpenses {
  
  return $ExpenseActivityCountCopyWith<$Res>(_self.todayExpenses, (value) {
    return _then(_self.copyWith(todayExpenses: value));
  });
}/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseActivityCountCopyWith<$Res> get thisMonthExpenses {
  
  return $ExpenseActivityCountCopyWith<$Res>(_self.thisMonthExpenses, (value) {
    return _then(_self.copyWith(thisMonthExpenses: value));
  });
}/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseActivityCountCopyWith<$Res> get totalExpenses {
  
  return $ExpenseActivityCountCopyWith<$Res>(_self.totalExpenses, (value) {
    return _then(_self.copyWith(totalExpenses: value));
  });
}/// Create a copy of ExpenseSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PreviousMonthComparisonCopyWith<$Res> get previousMonthComparison {
  
  return $PreviousMonthComparisonCopyWith<$Res>(_self.previousMonthComparison, (value) {
    return _then(_self.copyWith(previousMonthComparison: value));
  });
}
}

// dart format on
