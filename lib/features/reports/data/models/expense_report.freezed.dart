// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExpenseReportSummary {

 int get totalExpenses; double get totalAmount;
/// Create a copy of ExpenseReportSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseReportSummaryCopyWith<ExpenseReportSummary> get copyWith => _$ExpenseReportSummaryCopyWithImpl<ExpenseReportSummary>(this as ExpenseReportSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseReportSummary&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}


@override
int get hashCode => Object.hash(runtimeType,totalExpenses,totalAmount);

@override
String toString() {
  return 'ExpenseReportSummary(totalExpenses: $totalExpenses, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class $ExpenseReportSummaryCopyWith<$Res>  {
  factory $ExpenseReportSummaryCopyWith(ExpenseReportSummary value, $Res Function(ExpenseReportSummary) _then) = _$ExpenseReportSummaryCopyWithImpl;
@useResult
$Res call({
 int totalExpenses, double totalAmount
});




}
/// @nodoc
class _$ExpenseReportSummaryCopyWithImpl<$Res>
    implements $ExpenseReportSummaryCopyWith<$Res> {
  _$ExpenseReportSummaryCopyWithImpl(this._self, this._then);

  final ExpenseReportSummary _self;
  final $Res Function(ExpenseReportSummary) _then;

/// Create a copy of ExpenseReportSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalExpenses = null,Object? totalAmount = null,}) {
  return _then(_self.copyWith(
totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseReportSummary].
extension ExpenseReportSummaryPatterns on ExpenseReportSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseReportSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseReportSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseReportSummary value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseReportSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseReportSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseReportSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalExpenses,  double totalAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseReportSummary() when $default != null:
return $default(_that.totalExpenses,_that.totalAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalExpenses,  double totalAmount)  $default,) {final _that = this;
switch (_that) {
case _ExpenseReportSummary():
return $default(_that.totalExpenses,_that.totalAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalExpenses,  double totalAmount)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseReportSummary() when $default != null:
return $default(_that.totalExpenses,_that.totalAmount);case _:
  return null;

}
}

}

/// @nodoc


class _ExpenseReportSummary implements ExpenseReportSummary {
  const _ExpenseReportSummary({required this.totalExpenses, required this.totalAmount});
  

@override final  int totalExpenses;
@override final  double totalAmount;

/// Create a copy of ExpenseReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseReportSummaryCopyWith<_ExpenseReportSummary> get copyWith => __$ExpenseReportSummaryCopyWithImpl<_ExpenseReportSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseReportSummary&&(identical(other.totalExpenses, totalExpenses) || other.totalExpenses == totalExpenses)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount));
}


@override
int get hashCode => Object.hash(runtimeType,totalExpenses,totalAmount);

@override
String toString() {
  return 'ExpenseReportSummary(totalExpenses: $totalExpenses, totalAmount: $totalAmount)';
}


}

/// @nodoc
abstract mixin class _$ExpenseReportSummaryCopyWith<$Res> implements $ExpenseReportSummaryCopyWith<$Res> {
  factory _$ExpenseReportSummaryCopyWith(_ExpenseReportSummary value, $Res Function(_ExpenseReportSummary) _then) = __$ExpenseReportSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalExpenses, double totalAmount
});




}
/// @nodoc
class __$ExpenseReportSummaryCopyWithImpl<$Res>
    implements _$ExpenseReportSummaryCopyWith<$Res> {
  __$ExpenseReportSummaryCopyWithImpl(this._self, this._then);

  final _ExpenseReportSummary _self;
  final $Res Function(_ExpenseReportSummary) _then;

/// Create a copy of ExpenseReportSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalExpenses = null,Object? totalAmount = null,}) {
  return _then(_ExpenseReportSummary(
totalExpenses: null == totalExpenses ? _self.totalExpenses : totalExpenses // ignore: cast_nullable_to_non_nullable
as int,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$ExpenseCategoryBreakdown {

 String get categoryId; String get categoryName; double get amount; int get count;
/// Create a copy of ExpenseCategoryBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseCategoryBreakdownCopyWith<ExpenseCategoryBreakdown> get copyWith => _$ExpenseCategoryBreakdownCopyWithImpl<ExpenseCategoryBreakdown>(this as ExpenseCategoryBreakdown, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseCategoryBreakdown&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,categoryName,amount,count);

@override
String toString() {
  return 'ExpenseCategoryBreakdown(categoryId: $categoryId, categoryName: $categoryName, amount: $amount, count: $count)';
}


}

/// @nodoc
abstract mixin class $ExpenseCategoryBreakdownCopyWith<$Res>  {
  factory $ExpenseCategoryBreakdownCopyWith(ExpenseCategoryBreakdown value, $Res Function(ExpenseCategoryBreakdown) _then) = _$ExpenseCategoryBreakdownCopyWithImpl;
@useResult
$Res call({
 String categoryId, String categoryName, double amount, int count
});




}
/// @nodoc
class _$ExpenseCategoryBreakdownCopyWithImpl<$Res>
    implements $ExpenseCategoryBreakdownCopyWith<$Res> {
  _$ExpenseCategoryBreakdownCopyWithImpl(this._self, this._then);

  final ExpenseCategoryBreakdown _self;
  final $Res Function(ExpenseCategoryBreakdown) _then;

/// Create a copy of ExpenseCategoryBreakdown
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


/// Adds pattern-matching-related methods to [ExpenseCategoryBreakdown].
extension ExpenseCategoryBreakdownPatterns on ExpenseCategoryBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseCategoryBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseCategoryBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseCategoryBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseCategoryBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseCategoryBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseCategoryBreakdown() when $default != null:
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
case _ExpenseCategoryBreakdown() when $default != null:
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
case _ExpenseCategoryBreakdown():
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
case _ExpenseCategoryBreakdown() when $default != null:
return $default(_that.categoryId,_that.categoryName,_that.amount,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _ExpenseCategoryBreakdown implements ExpenseCategoryBreakdown {
  const _ExpenseCategoryBreakdown({required this.categoryId, required this.categoryName, required this.amount, required this.count});
  

@override final  String categoryId;
@override final  String categoryName;
@override final  double amount;
@override final  int count;

/// Create a copy of ExpenseCategoryBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseCategoryBreakdownCopyWith<_ExpenseCategoryBreakdown> get copyWith => __$ExpenseCategoryBreakdownCopyWithImpl<_ExpenseCategoryBreakdown>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseCategoryBreakdown&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,categoryName,amount,count);

@override
String toString() {
  return 'ExpenseCategoryBreakdown(categoryId: $categoryId, categoryName: $categoryName, amount: $amount, count: $count)';
}


}

/// @nodoc
abstract mixin class _$ExpenseCategoryBreakdownCopyWith<$Res> implements $ExpenseCategoryBreakdownCopyWith<$Res> {
  factory _$ExpenseCategoryBreakdownCopyWith(_ExpenseCategoryBreakdown value, $Res Function(_ExpenseCategoryBreakdown) _then) = __$ExpenseCategoryBreakdownCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, String categoryName, double amount, int count
});




}
/// @nodoc
class __$ExpenseCategoryBreakdownCopyWithImpl<$Res>
    implements _$ExpenseCategoryBreakdownCopyWith<$Res> {
  __$ExpenseCategoryBreakdownCopyWithImpl(this._self, this._then);

  final _ExpenseCategoryBreakdown _self;
  final $Res Function(_ExpenseCategoryBreakdown) _then;

/// Create a copy of ExpenseCategoryBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? categoryName = null,Object? amount = null,Object? count = null,}) {
  return _then(_ExpenseCategoryBreakdown(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ExpenseReportRow {

 String get id; String get title; String get categoryName; double get amount; DateTime get expenseDate; String get paymentMethod; String? get createdByName;
/// Create a copy of ExpenseReportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseReportRowCopyWith<ExpenseReportRow> get copyWith => _$ExpenseReportRowCopyWithImpl<ExpenseReportRow>(this as ExpenseReportRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseReportRow&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,categoryName,amount,expenseDate,paymentMethod,createdByName);

@override
String toString() {
  return 'ExpenseReportRow(id: $id, title: $title, categoryName: $categoryName, amount: $amount, expenseDate: $expenseDate, paymentMethod: $paymentMethod, createdByName: $createdByName)';
}


}

/// @nodoc
abstract mixin class $ExpenseReportRowCopyWith<$Res>  {
  factory $ExpenseReportRowCopyWith(ExpenseReportRow value, $Res Function(ExpenseReportRow) _then) = _$ExpenseReportRowCopyWithImpl;
@useResult
$Res call({
 String id, String title, String categoryName, double amount, DateTime expenseDate, String paymentMethod, String? createdByName
});




}
/// @nodoc
class _$ExpenseReportRowCopyWithImpl<$Res>
    implements $ExpenseReportRowCopyWith<$Res> {
  _$ExpenseReportRowCopyWithImpl(this._self, this._then);

  final ExpenseReportRow _self;
  final $Res Function(ExpenseReportRow) _then;

/// Create a copy of ExpenseReportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? categoryName = null,Object? amount = null,Object? expenseDate = null,Object? paymentMethod = null,Object? createdByName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,expenseDate: null == expenseDate ? _self.expenseDate : expenseDate // ignore: cast_nullable_to_non_nullable
as DateTime,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseReportRow].
extension ExpenseReportRowPatterns on ExpenseReportRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseReportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseReportRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseReportRow value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseReportRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseReportRow value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseReportRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String categoryName,  double amount,  DateTime expenseDate,  String paymentMethod,  String? createdByName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseReportRow() when $default != null:
return $default(_that.id,_that.title,_that.categoryName,_that.amount,_that.expenseDate,_that.paymentMethod,_that.createdByName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String categoryName,  double amount,  DateTime expenseDate,  String paymentMethod,  String? createdByName)  $default,) {final _that = this;
switch (_that) {
case _ExpenseReportRow():
return $default(_that.id,_that.title,_that.categoryName,_that.amount,_that.expenseDate,_that.paymentMethod,_that.createdByName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String categoryName,  double amount,  DateTime expenseDate,  String paymentMethod,  String? createdByName)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseReportRow() when $default != null:
return $default(_that.id,_that.title,_that.categoryName,_that.amount,_that.expenseDate,_that.paymentMethod,_that.createdByName);case _:
  return null;

}
}

}

/// @nodoc


class _ExpenseReportRow implements ExpenseReportRow {
  const _ExpenseReportRow({required this.id, required this.title, required this.categoryName, required this.amount, required this.expenseDate, required this.paymentMethod, this.createdByName});
  

@override final  String id;
@override final  String title;
@override final  String categoryName;
@override final  double amount;
@override final  DateTime expenseDate;
@override final  String paymentMethod;
@override final  String? createdByName;

/// Create a copy of ExpenseReportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseReportRowCopyWith<_ExpenseReportRow> get copyWith => __$ExpenseReportRowCopyWithImpl<_ExpenseReportRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseReportRow&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.createdByName, createdByName) || other.createdByName == createdByName));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,categoryName,amount,expenseDate,paymentMethod,createdByName);

@override
String toString() {
  return 'ExpenseReportRow(id: $id, title: $title, categoryName: $categoryName, amount: $amount, expenseDate: $expenseDate, paymentMethod: $paymentMethod, createdByName: $createdByName)';
}


}

/// @nodoc
abstract mixin class _$ExpenseReportRowCopyWith<$Res> implements $ExpenseReportRowCopyWith<$Res> {
  factory _$ExpenseReportRowCopyWith(_ExpenseReportRow value, $Res Function(_ExpenseReportRow) _then) = __$ExpenseReportRowCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String categoryName, double amount, DateTime expenseDate, String paymentMethod, String? createdByName
});




}
/// @nodoc
class __$ExpenseReportRowCopyWithImpl<$Res>
    implements _$ExpenseReportRowCopyWith<$Res> {
  __$ExpenseReportRowCopyWithImpl(this._self, this._then);

  final _ExpenseReportRow _self;
  final $Res Function(_ExpenseReportRow) _then;

/// Create a copy of ExpenseReportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? categoryName = null,Object? amount = null,Object? expenseDate = null,Object? paymentMethod = null,Object? createdByName = freezed,}) {
  return _then(_ExpenseReportRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,expenseDate: null == expenseDate ? _self.expenseDate : expenseDate // ignore: cast_nullable_to_non_nullable
as DateTime,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,createdByName: freezed == createdByName ? _self.createdByName : createdByName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
