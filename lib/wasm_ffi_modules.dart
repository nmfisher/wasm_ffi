/// Provides additional classes that are needed for wasm_ffi,
/// but are not present in [dart:ffi](https://api.dart.dev/stable/2.12.0/dart-ffi/dart-ffi-library.html).
library wasm_ffi_modules;

export 'src/modules/exceptions.dart';
export 'src/modules/module.dart';
export 'src/modules/table.dart';
export 'src/modules/memory.dart'
    show registerOpaqueType, Memory, MemoryRegisterMode;

export 'src/modules/emscripten/emscripten_module_stub.dart'
    if (dart.library.js) 'src/modules/emscripten/emscripten_module.dart'
    show EmscriptenModule;
