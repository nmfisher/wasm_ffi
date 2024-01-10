import 'dart:typed_data';
import 'memory.dart';
import '../ffi/types.dart';

class NullMemory implements Memory {
  @override
  Pointer<T> allocate<T extends NativeType>(int byteCount, {int? alignment}) {
    throw UnsupportedError('Can not use the null memory to allocate space!');
  }

  @override
  ByteBuffer get buffer =>
      throw UnsupportedError('The null memory has no buffer!');

  @override
  void free(Pointer<NativeType> pointer) {
    throw UnsupportedError('Can not use the null memory to free pointers!');
  }

  void setSymbolByAddress(int address, WasmSymbol symbol) {
    throw UnsupportedError('Can not use the null memory to free pointers!');
  }
}
