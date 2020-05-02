# Do not edit. bazel-deps autogenerates this file from.
_JAVA_LIBRARY_TEMPLATE = """
java_library(
  name = "{name}",
  exports = [
      {exports}
  ],
  runtime_deps = [
    {runtime_deps}
  ],
  visibility = [
      "{visibility}"
  ]
)\n"""

_SCALA_IMPORT_TEMPLATE = """
scala_import(
    name = "{name}",
    exports = [
        {exports}
    ],
    jars = [
        {jars}
    ],
    runtime_deps = [
        {runtime_deps}
    ],
    visibility = [
        "{visibility}"
    ]
)
"""

_SCALA_LIBRARY_TEMPLATE = """
scala_library(
    name = "{name}",
    exports = [
        {exports}
    ],
    runtime_deps = [
        {runtime_deps}
    ],
    visibility = [
        "{visibility}"
    ]
)
"""


def _build_external_workspace_from_opts_impl(ctx):
    build_header = ctx.attr.build_header
    separator = ctx.attr.separator
    target_configs = ctx.attr.target_configs

    result_dict = {}
    for key, cfg in target_configs.items():
      build_file_to_target_name = key.split(":")
      build_file = build_file_to_target_name[0]
      target_name = build_file_to_target_name[1]
      if build_file not in result_dict:
        result_dict[build_file] = []
      result_dict[build_file].append(cfg)

    for key, file_entries in result_dict.items():
      build_file_contents = build_header + '\n\n'
      for build_target in file_entries:
        entry_map = {}
        for entry in build_target:
          elements = entry.split(separator)
          build_entry_key = elements[0]
          if elements[1] == "L":
            entry_map[build_entry_key] = [e for e in elements[2::] if len(e) > 0]
          elif elements[1] == "B":
            entry_map[build_entry_key] = (elements[2] == "true" or elements[2] == "True")
          else:
            entry_map[build_entry_key] = elements[2]

        exports_str = ""
        for e in entry_map.get("exports", []):
          exports_str += "\"" + e + "\",\n"

        jars_str = ""
        for e in entry_map.get("jars", []):
          jars_str += "\"" + e + "\",\n"

        runtime_deps_str = ""
        for e in entry_map.get("runtimeDeps", []):
          runtime_deps_str += "\"" + e + "\",\n"

        name = entry_map["name"].split(":")[1]
        if entry_map["lang"] == "java":
            build_file_contents += _JAVA_LIBRARY_TEMPLATE.format(name = name, exports=exports_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        elif entry_map["lang"].startswith("scala") and entry_map["kind"] == "import":
            build_file_contents += _SCALA_IMPORT_TEMPLATE.format(name = name, exports=exports_str, jars=jars_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        elif entry_map["lang"].startswith("scala") and entry_map["kind"] == "library":
            build_file_contents += _SCALA_LIBRARY_TEMPLATE.format(name = name, exports=exports_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        else:
            print(entry_map)

      ctx.file(ctx.path(key + "/BUILD"), build_file_contents, False)
    return None

build_external_workspace_from_opts = repository_rule(
    attrs = {
        "target_configs": attr.string_list_dict(mandatory = True),
        "separator": attr.string(mandatory = True),
        "build_header": attr.string(mandatory = True),
    },
    implementation = _build_external_workspace_from_opts_impl
)




def build_header():
 return """"""

def list_target_data_separator():
 return "|||"

def list_target_data():
    return {
"3rdparty/jvm/com/fasterxml/jackson/core:jackson_annotations": ["lang||||||java","name||||||//3rdparty/jvm/com/fasterxml/jackson/core:jackson_annotations","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/com/fasterxml/jackson/core/jackson_annotations","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/com/fasterxml/jackson/core:jackson_core": ["lang||||||java","name||||||//3rdparty/jvm/com/fasterxml/jackson/core:jackson_core","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/com/fasterxml/jackson/core/jackson_core","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/com/fasterxml/jackson/core:jackson_databind": ["lang||||||java","name||||||//3rdparty/jvm/com/fasterxml/jackson/core:jackson_databind","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/com/fasterxml/jackson/core:jackson_annotations|||//3rdparty/jvm/com/fasterxml/jackson/core:jackson_core|||//external:jar/com/fasterxml/jackson/core/jackson_databind","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_buffer": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_buffer","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_common|||//external:jar/io/netty/netty_buffer","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_codec": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_codec","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_common|||//3rdparty/jvm/io/netty:netty_transport|||//3rdparty/jvm/io/netty:netty_buffer|||//external:jar/io/netty/netty_codec","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_codec_dns": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_codec_dns","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_buffer|||//3rdparty/jvm/io/netty:netty_common|||//external:jar/io/netty/netty_codec_dns|||//3rdparty/jvm/io/netty:netty_codec|||//3rdparty/jvm/io/netty:netty_transport","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_codec_http": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_codec_http","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_buffer|||//3rdparty/jvm/io/netty:netty_handler|||//3rdparty/jvm/io/netty:netty_common|||//external:jar/io/netty/netty_codec_http|||//3rdparty/jvm/io/netty:netty_codec|||//3rdparty/jvm/io/netty:netty_transport","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_codec_http2": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_codec_http2","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_buffer|||//3rdparty/jvm/io/netty:netty_handler|||//3rdparty/jvm/io/netty:netty_common|||//3rdparty/jvm/io/netty:netty_codec_http|||//3rdparty/jvm/io/netty:netty_codec|||//external:jar/io/netty/netty_codec_http2|||//3rdparty/jvm/io/netty:netty_transport","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_codec_socks": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_codec_socks","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_buffer|||//3rdparty/jvm/io/netty:netty_common|||//external:jar/io/netty/netty_codec_socks|||//3rdparty/jvm/io/netty:netty_codec|||//3rdparty/jvm/io/netty:netty_transport","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_common": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_common","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/io/netty/netty_common","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_handler": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_handler","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_buffer|||//3rdparty/jvm/io/netty:netty_common|||//3rdparty/jvm/io/netty:netty_codec|||//3rdparty/jvm/io/netty:netty_transport|||//external:jar/io/netty/netty_handler","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_handler_proxy": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_handler_proxy","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_buffer|||//3rdparty/jvm/io/netty:netty_codec_socks|||//3rdparty/jvm/io/netty:netty_common|||//external:jar/io/netty/netty_handler_proxy|||//3rdparty/jvm/io/netty:netty_codec_http|||//3rdparty/jvm/io/netty:netty_codec|||//3rdparty/jvm/io/netty:netty_transport","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_resolver": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_resolver","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_common|||//external:jar/io/netty/netty_resolver","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_resolver_dns": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_resolver_dns","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_buffer|||//3rdparty/jvm/io/netty:netty_common|||//external:jar/io/netty/netty_resolver_dns|||//3rdparty/jvm/io/netty:netty_codec_dns|||//3rdparty/jvm/io/netty:netty_codec|||//3rdparty/jvm/io/netty:netty_transport|||//3rdparty/jvm/io/netty:netty_resolver","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/netty:netty_transport": ["lang||||||java","name||||||//3rdparty/jvm/io/netty:netty_transport","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_resolver|||//3rdparty/jvm/io/netty:netty_common|||//3rdparty/jvm/io/netty:netty_buffer|||//external:jar/io/netty/netty_transport","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/reactivex/rxjava2:rxjava": ["lang||||||java","name||||||//3rdparty/jvm/io/reactivex/rxjava2:rxjava","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/reactivestreams:reactive_streams|||//external:jar/io/reactivex/rxjava2/rxjava","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/vertx:vertx_auth_common": ["lang||||||java","name||||||//3rdparty/jvm/io/vertx:vertx_auth_common","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/vertx:vertx_core|||//external:jar/io/vertx/vertx_auth_common","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/vertx:vertx_bridge_common": ["lang||||||java","name||||||//3rdparty/jvm/io/vertx:vertx_bridge_common","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/io/vertx/vertx_bridge_common","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/vertx:vertx_codegen": ["lang||||||java","name||||||//3rdparty/jvm/io/vertx:vertx_codegen","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/com/fasterxml/jackson/core:jackson_core|||//3rdparty/jvm/com/fasterxml/jackson/core:jackson_databind|||//3rdparty/jvm/org/mvel:mvel2|||//external:jar/io/vertx/vertx_codegen","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/vertx:vertx_core": ["lang||||||java","name||||||//3rdparty/jvm/io/vertx:vertx_core","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/netty:netty_buffer|||//3rdparty/jvm/io/netty:netty_handler|||//3rdparty/jvm/io/netty:netty_common|||//3rdparty/jvm/com/fasterxml/jackson/core:jackson_core|||//3rdparty/jvm/io/netty:netty_handler_proxy|||//3rdparty/jvm/io/netty:netty_codec_http2|||//3rdparty/jvm/io/netty:netty_codec_http|||//3rdparty/jvm/com/fasterxml/jackson/core:jackson_databind|||//external:jar/io/vertx/vertx_core|||//3rdparty/jvm/io/netty:netty_transport|||//3rdparty/jvm/io/netty:netty_resolver|||//3rdparty/jvm/io/netty:netty_resolver_dns","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/vertx:vertx_rx_gen": ["lang||||||java","name||||||//3rdparty/jvm/io/vertx:vertx_rx_gen","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/vertx:vertx_codegen|||//3rdparty/jvm/io/vertx:vertx_core|||//external:jar/io/vertx/vertx_rx_gen","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/vertx:vertx_rx_java2": ["lang||||||java","name||||||//3rdparty/jvm/io/vertx:vertx_rx_java2","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/vertx:vertx_core|||//3rdparty/jvm/org/reactivestreams:reactive_streams|||//3rdparty/jvm/io/reactivex/rxjava2:rxjava|||//3rdparty/jvm/io/vertx:vertx_rx_gen|||//external:jar/io/vertx/vertx_rx_java2","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/vertx:vertx_web": ["lang||||||java","name||||||//3rdparty/jvm/io/vertx:vertx_web","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/vertx:vertx_core|||//external:jar/io/vertx/vertx_web|||//3rdparty/jvm/io/vertx:vertx_bridge_common|||//3rdparty/jvm/io/vertx:vertx_auth_common|||//3rdparty/jvm/io/vertx:vertx_web_common","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/io/vertx:vertx_web_common": ["lang||||||java","name||||||//3rdparty/jvm/io/vertx:vertx_web_common","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/io/vertx:vertx_core|||//external:jar/io/vertx/vertx_web_common","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/mvel:mvel2": ["lang||||||java","name||||||//3rdparty/jvm/org/mvel:mvel2","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/mvel/mvel2","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/reactivestreams:reactive_streams": ["lang||||||java","name||||||//3rdparty/jvm/org/reactivestreams:reactive_streams","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/reactivestreams/reactive_streams","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"]
 }


def build_external_workspace(name):
  return build_external_workspace_from_opts(name = name, target_configs = list_target_data(), separator = list_target_data_separator(), build_header = build_header())

