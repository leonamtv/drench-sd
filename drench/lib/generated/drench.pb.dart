///
//  Generated code. Do not modify.
//  source: drench.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class voidNoParam extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'voidNoParam', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'drenchPackage'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  voidNoParam._() : super();
  factory voidNoParam() => create();
  factory voidNoParam.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory voidNoParam.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  voidNoParam clone() => voidNoParam()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  voidNoParam copyWith(void Function(voidNoParam) updates) => super.copyWith((message) => updates(message as voidNoParam)) as voidNoParam; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static voidNoParam create() => voidNoParam._();
  voidNoParam createEmptyInstance() => create();
  static $pb.PbList<voidNoParam> createRepeated() => $pb.PbList<voidNoParam>();
  @$core.pragma('dart2js:noInline')
  static voidNoParam getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<voidNoParam>(create);
  static voidNoParam _defaultInstance;
}

class SyncBoardData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SyncBoardData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'drenchPackage'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'board')
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reset')
    ..hasRequiredFields = false
  ;

  SyncBoardData._() : super();
  factory SyncBoardData({
    $core.String board,
    $core.bool reset,
  }) {
    final _result = create();
    if (board != null) {
      _result.board = board;
    }
    if (reset != null) {
      _result.reset = reset;
    }
    return _result;
  }
  factory SyncBoardData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncBoardData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncBoardData clone() => SyncBoardData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncBoardData copyWith(void Function(SyncBoardData) updates) => super.copyWith((message) => updates(message as SyncBoardData)) as SyncBoardData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SyncBoardData create() => SyncBoardData._();
  SyncBoardData createEmptyInstance() => create();
  static $pb.PbList<SyncBoardData> createRepeated() => $pb.PbList<SyncBoardData>();
  @$core.pragma('dart2js:noInline')
  static SyncBoardData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncBoardData>(create);
  static SyncBoardData _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get board => $_getSZ(0);
  @$pb.TagNumber(1)
  set board($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBoard() => $_has(0);
  @$pb.TagNumber(1)
  void clearBoard() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get reset => $_getBF(1);
  @$pb.TagNumber(2)
  set reset($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReset() => $_has(1);
  @$pb.TagNumber(2)
  void clearReset() => clearField(2);
}

class UpdateBoardData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateBoardData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'drenchPackage'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'colorIndex', $pb.PbFieldType.O3, protoName: 'colorIndex')
    ..hasRequiredFields = false
  ;

  UpdateBoardData._() : super();
  factory UpdateBoardData({
    $core.int colorIndex,
  }) {
    final _result = create();
    if (colorIndex != null) {
      _result.colorIndex = colorIndex;
    }
    return _result;
  }
  factory UpdateBoardData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateBoardData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateBoardData clone() => UpdateBoardData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateBoardData copyWith(void Function(UpdateBoardData) updates) => super.copyWith((message) => updates(message as UpdateBoardData)) as UpdateBoardData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateBoardData create() => UpdateBoardData._();
  UpdateBoardData createEmptyInstance() => create();
  static $pb.PbList<UpdateBoardData> createRepeated() => $pb.PbList<UpdateBoardData>();
  @$core.pragma('dart2js:noInline')
  static UpdateBoardData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateBoardData>(create);
  static UpdateBoardData _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get colorIndex => $_getIZ(0);
  @$pb.TagNumber(1)
  set colorIndex($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasColorIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearColorIndex() => clearField(1);
}

