# CDT (Contract Development Toolkit) custom tools
# This file adds CDT-specific WASM post-processing tools on top of
# the upstream wabt build. It is included at the end of the root
# CMakeLists.txt and uses the upstream wabt_executable() function.
#
# To update upstream wabt: merge/rebase from WebAssembly/wabt.
# This file and src/tools/postpass.cc are the only CDT additions.

wabt_executable(
  NAME core-net-pp
  SOURCES src/tools/postpass.cc
)

# Copy to CDT bin directory if building as part of CDT
if(CMAKE_BINARY_DIR)
  add_custom_command(TARGET core-net-pp POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/bin
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:core-net-pp> ${CMAKE_BINARY_DIR}/bin/
  )
endif()
