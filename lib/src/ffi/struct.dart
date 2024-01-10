import 'dart:typed_data';
import 'package:meta/meta.dart';

import '../modules/module.dart';
import '../modules/memory.dart';
import '../modules/null_memory.dart';
import '../modules/table.dart';

import '../internal/type_utils.dart';

import '../../wasm_ffi_meta.dart';

export 'package:wasm_ffi/wasm_ffi.dart';
import 'dart:js';
import 'dart:typed_data';
import 'types.dart';
import 'utf8.dart';

import 'package:collection/collection.dart';
import 'package:wasm_ffi/wasm_ffi_modules.dart';
import 'package:wasm_interop/wasm_interop.dart' as interop;
import 'package:wasm_ffi/src/internal/marshaller.dart';
import 'package:wasm_ffi/src/internal/type_utils.dart';

/// The supertype of all FFI compound types.
///
/// FFI struct types should extend [Struct]. For more information see the
/// documentation on this class.
@pragma("wasm:entry-point")
abstract final class _Compound extends NativeType {
  @pragma("vm:entry-point")
  final Object _typedDataBase;

  _Compound._() : _typedDataBase = nullptr;

  _Compound._fromTypedDataBase(this._typedDataBase);
}

/// The supertype of all FFI struct types.
///
/// FFI struct types should extend this class and declare fields corresponding
/// to the underlying native structure.
///
/// Field declarations in a [Struct] subclass declaration are automatically
/// given a setter and getter implementation which accesses the native struct's
/// field in memory.
///
/// All field declarations in a [Struct] subclass declaration must either have
/// type [int] or [double] and be annotated with a [NativeType] representing the
/// native type, or must be of type [Pointer]. For example:
///
/// ```c
/// typedef struct {
///  int a;
///  float b;
///  void* c;
/// } my_struct;
/// ```
///
/// ```dart
/// final class MyStruct extends Struct {
///   @Int32()
///   external int a;
///
///   @Float()
///   external double b;
///
///   external Pointer<Void> c;
/// }
/// ```
///
/// All field declarations in a [Struct] subclass declaration must be marked
/// `external`. You cannot create instances of the class, only have it point to
/// existing native memory, so there is no memory in which to store non-native
/// fields. External fields also cannot be initialized by constructors since no
/// Dart object is being created.
///
/// Instances of a subclass of [Struct] have reference semantics and are backed
/// by native memory or typed data. They may allocated via allocation or loaded
/// from a [Pointer] or created by ffi calls or callbacks. They cannot be
/// created by a generative constructor.
abstract base class Struct extends _Compound {
  /// Construct a reference to the [nullptr].
  ///
  /// Use [StructPointer]'s `.ref` to gain references to native memory backed
  /// structs.
  Struct() : super._();

  Struct._fromTypedDataBase(Object typedDataBase)
      : super._fromTypedDataBase(typedDataBase);
}

/// Annotation to specify on `Struct` subtypes to indicate that its members
/// need to be packed.
///
/// Valid values for [memberAlignment] are 1, 2, 4, 8, and 16.
final class Packed {
  final int memberAlignment;

  const Packed(this.memberAlignment);
}
