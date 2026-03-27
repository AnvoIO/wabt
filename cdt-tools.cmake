# CDT (Contract Development Toolkit) custom tools
# This file adds CDT-specific WASM post-processing tools on top of
# the upstream wabt build. It is included at the end of the root
# CMakeLists.txt and uses the upstream wabt_executable() function.
#
# To update upstream wabt: merge/rebase from WebAssembly/wabt.
# This file and src/tools/postpass.cc are the only CDT additions.

# CDT postpass optimizer — strips BSS, coalesces segments, fixes heap pointer
wabt_executable(
  NAME core-net-pp
  SOURCES src/tools/postpass.cc
)

# CDT-branded copies of upstream wat2wasm and wasm2wat
wabt_executable(
  NAME core-net-wast2wasm
  SOURCES src/tools/wat2wasm.cc
)

wabt_executable(
  NAME core-net-wasm2wast
  SOURCES src/tools/wasm2wat.cc
)

# Copy CDT tools to bin directory when building as part of CDT
foreach(_tool core-net-pp core-net-wast2wasm core-net-wasm2wast)
  add_custom_command(TARGET ${_tool} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/bin
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${_tool}> ${CMAKE_BINARY_DIR}/bin/
  )
endforeach()
