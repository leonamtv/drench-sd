///
//  Generated code. Do not modify.
//  source: drench.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'drench.pb.dart' as $0;
export 'drench.pb.dart';

class DrenchClient extends $grpc.Client {
  static final _$syncBoard =
      $grpc.ClientMethod<$0.SyncBoardData, $0.voidNoParam>(
          '/drenchPackage.Drench/syncBoard',
          ($0.SyncBoardData value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.voidNoParam.fromBuffer(value));
  static final _$updateBoard =
      $grpc.ClientMethod<$0.UpdateBoardData, $0.voidNoParam>(
          '/drenchPackage.Drench/updateBoard',
          ($0.UpdateBoardData value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.voidNoParam.fromBuffer(value));
  static final _$subscribeSyncBoard =
      $grpc.ClientMethod<$0.voidNoParam, $0.SyncBoardData>(
          '/drenchPackage.Drench/subscribeSyncBoard',
          ($0.voidNoParam value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.SyncBoardData.fromBuffer(value));
  static final _$subscribeUpdateBoard =
      $grpc.ClientMethod<$0.voidNoParam, $0.UpdateBoardData>(
          '/drenchPackage.Drench/subscribeUpdateBoard',
          ($0.voidNoParam value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UpdateBoardData.fromBuffer(value));

  DrenchClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.voidNoParam> syncBoard($0.SyncBoardData request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$syncBoard, request, options: options);
  }

  $grpc.ResponseFuture<$0.voidNoParam> updateBoard($0.UpdateBoardData request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$updateBoard, request, options: options);
  }

  $grpc.ResponseStream<$0.SyncBoardData> subscribeSyncBoard(
      $0.voidNoParam request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(
        _$subscribeSyncBoard, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.UpdateBoardData> subscribeUpdateBoard(
      $0.voidNoParam request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(
        _$subscribeUpdateBoard, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class DrenchServiceBase extends $grpc.Service {
  $core.String get $name => 'drenchPackage.Drench';

  DrenchServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SyncBoardData, $0.voidNoParam>(
        'syncBoard',
        syncBoard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SyncBoardData.fromBuffer(value),
        ($0.voidNoParam value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateBoardData, $0.voidNoParam>(
        'updateBoard',
        updateBoard_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateBoardData.fromBuffer(value),
        ($0.voidNoParam value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.voidNoParam, $0.SyncBoardData>(
        'subscribeSyncBoard',
        subscribeSyncBoard_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.voidNoParam.fromBuffer(value),
        ($0.SyncBoardData value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.voidNoParam, $0.UpdateBoardData>(
        'subscribeUpdateBoard',
        subscribeUpdateBoard_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.voidNoParam.fromBuffer(value),
        ($0.UpdateBoardData value) => value.writeToBuffer()));
  }

  $async.Future<$0.voidNoParam> syncBoard_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SyncBoardData> request) async {
    return syncBoard(call, await request);
  }

  $async.Future<$0.voidNoParam> updateBoard_Pre(
      $grpc.ServiceCall call, $async.Future<$0.UpdateBoardData> request) async {
    return updateBoard(call, await request);
  }

  $async.Stream<$0.SyncBoardData> subscribeSyncBoard_Pre(
      $grpc.ServiceCall call, $async.Future<$0.voidNoParam> request) async* {
    yield* subscribeSyncBoard(call, await request);
  }

  $async.Stream<$0.UpdateBoardData> subscribeUpdateBoard_Pre(
      $grpc.ServiceCall call, $async.Future<$0.voidNoParam> request) async* {
    yield* subscribeUpdateBoard(call, await request);
  }

  $async.Future<$0.voidNoParam> syncBoard(
      $grpc.ServiceCall call, $0.SyncBoardData request);
  $async.Future<$0.voidNoParam> updateBoard(
      $grpc.ServiceCall call, $0.UpdateBoardData request);
  $async.Stream<$0.SyncBoardData> subscribeSyncBoard(
      $grpc.ServiceCall call, $0.voidNoParam request);
  $async.Stream<$0.UpdateBoardData> subscribeUpdateBoard(
      $grpc.ServiceCall call, $0.voidNoParam request);
}
