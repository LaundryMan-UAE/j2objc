licenses(["notice"])

package(
    default_visibility = ["//visibility:public"],
)

package_group(
    name = "j2objc_joda_time_users",
    packages = [
        "//java/com/google/api/client/util/...",
        "//java/com/google/apps/docs/docos/client/mobile/...",
        "//java/com/google/apps/docs/gwt/math/...",
    ],
)

filegroup(
    name = "joda_time_src_files",
    srcs = glob(["**/*.java"]),
)

filegroup(
    name = "joda_time_files",
    srcs = glob(["**/*"]),
)

# Please ask j2objc-users@ if you want to use this library.
java_library(
    name = "joda_time",
    srcs = [":joda_time_src_files"],
    javacopts = ["-extra_checks:off"],
    visibility = [":j2objc_joda_time_users"],
    deps = [
        "//third_party/java/jsr305_annotations",
        "//third_party/java_src/j2objc:annotations",
    ],
)
