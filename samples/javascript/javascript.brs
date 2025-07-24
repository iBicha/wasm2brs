Function Start()
    _javascript_wasmInit__()
    wasi_init(m._javascript_wasm_memory, "javascript.wasm", {})
    _javascript_wasm__start()
    wasi_shutdown()
End Function

Function GetSettings()
    Return { RestartOnFailure: True }
End Function
