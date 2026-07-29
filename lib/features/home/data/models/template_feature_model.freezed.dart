// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'template_feature_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TemplateFeatureModel {

 String get title; String get description; TemplateFeatureIcon get icon;
/// Create a copy of TemplateFeatureModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TemplateFeatureModelCopyWith<TemplateFeatureModel> get copyWith => _$TemplateFeatureModelCopyWithImpl<TemplateFeatureModel>(this as TemplateFeatureModel, _$identity);

  /// Serializes this TemplateFeatureModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TemplateFeatureModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,icon);

@override
String toString() {
  return 'TemplateFeatureModel(title: $title, description: $description, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $TemplateFeatureModelCopyWith<$Res>  {
  factory $TemplateFeatureModelCopyWith(TemplateFeatureModel value, $Res Function(TemplateFeatureModel) _then) = _$TemplateFeatureModelCopyWithImpl;
@useResult
$Res call({
 String title, String description, TemplateFeatureIcon icon
});




}
/// @nodoc
class _$TemplateFeatureModelCopyWithImpl<$Res>
    implements $TemplateFeatureModelCopyWith<$Res> {
  _$TemplateFeatureModelCopyWithImpl(this._self, this._then);

  final TemplateFeatureModel _self;
  final $Res Function(TemplateFeatureModel) _then;

/// Create a copy of TemplateFeatureModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? icon = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as TemplateFeatureIcon,
  ));
}

}


/// Adds pattern-matching-related methods to [TemplateFeatureModel].
extension TemplateFeatureModelPatterns on TemplateFeatureModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TemplateFeatureModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TemplateFeatureModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TemplateFeatureModel value)  $default,){
final _that = this;
switch (_that) {
case _TemplateFeatureModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TemplateFeatureModel value)?  $default,){
final _that = this;
switch (_that) {
case _TemplateFeatureModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  TemplateFeatureIcon icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TemplateFeatureModel() when $default != null:
return $default(_that.title,_that.description,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  TemplateFeatureIcon icon)  $default,) {final _that = this;
switch (_that) {
case _TemplateFeatureModel():
return $default(_that.title,_that.description,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  TemplateFeatureIcon icon)?  $default,) {final _that = this;
switch (_that) {
case _TemplateFeatureModel() when $default != null:
return $default(_that.title,_that.description,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TemplateFeatureModel extends TemplateFeatureModel {
  const _TemplateFeatureModel({required this.title, required this.description, required this.icon}): super._();
  factory _TemplateFeatureModel.fromJson(Map<String, dynamic> json) => _$TemplateFeatureModelFromJson(json);

@override final  String title;
@override final  String description;
@override final  TemplateFeatureIcon icon;

/// Create a copy of TemplateFeatureModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TemplateFeatureModelCopyWith<_TemplateFeatureModel> get copyWith => __$TemplateFeatureModelCopyWithImpl<_TemplateFeatureModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TemplateFeatureModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TemplateFeatureModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,icon);

@override
String toString() {
  return 'TemplateFeatureModel(title: $title, description: $description, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$TemplateFeatureModelCopyWith<$Res> implements $TemplateFeatureModelCopyWith<$Res> {
  factory _$TemplateFeatureModelCopyWith(_TemplateFeatureModel value, $Res Function(_TemplateFeatureModel) _then) = __$TemplateFeatureModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, TemplateFeatureIcon icon
});




}
/// @nodoc
class __$TemplateFeatureModelCopyWithImpl<$Res>
    implements _$TemplateFeatureModelCopyWith<$Res> {
  __$TemplateFeatureModelCopyWithImpl(this._self, this._then);

  final _TemplateFeatureModel _self;
  final $Res Function(_TemplateFeatureModel) _then;

/// Create a copy of TemplateFeatureModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? icon = null,}) {
  return _then(_TemplateFeatureModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as TemplateFeatureIcon,
  ));
}


}

// dart format on
