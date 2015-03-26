# J2ObjC: Java to Objective-C Translator and Runtime #

[![Build Status](https://travis-ci.org/google/j2objc.svg)](https://travis-ci.org/google/j2objc)

**Project site:** <http://j2objc.org><br>
**J2ObjC blog:** <http://j2objc.blogspot.com><br>
**Questions and discussion:** <http://groups.google.com/group/j2objc-discuss>

### Enhancements - 25/03/15 ###
This copy of J2ObjC includes jode-time (commit b9fe534c7f) and joda-convert (v1.7).
In order to use this on the command line or via gradle to compile ObjC translated classes
please see the example gradle below.Additionally joda-time has some resources that are
not packaged up within the .a library, so these will need to be copied to the distination
directory of the compile. These can be found in <j2objc_clone_path>dist/resources.

task compileTestObjC(type:Exec) {

        inputs.files fileTree(dir: buildDir, includes: ['**/*.h', '**/*.m']) +
                fileTree(dir: file('src/gen/objc'), includes: ['**/*.h', '**/*.m']) +
                fileTree(dir: file('src/gen/test'), includes: ['**/*.h', '**/*.m']) +
                fileTree(dir: projectDir.path + '/../hambroperks-sdk/core/src/gen/objc', includes: ['**/*.h', '**/*.m'])

        outputs.files file("$buildDir/testrunner")
        executable "${J2OBJC_HOME}/j2objcc"
        workingDir buildDir
        args "-I$buildDir"
        args "-I${file('src/gen/objc').path}"
        args "-I${file('src/gen/test').path}"
        args "-I${file(projectDir.path + '/../hambroperks-sdk/core/src/gen/objc').path}"
        args "-ObjC", "-ljunit", "-ljoda_time", "-lguava", "-ljoda_convert", "-ljsr305"
        args "-o", "testrunner"
        def srcFiles = fileTree(dir: file('src/gen/objc'), includes: ['**/*.h', '**/*.m']) +
                fileTree(dir: file('src/gen/test'), includes: ['**/*.h', '**/*.m']) +
                fileTree(dir: file(projectDir.path + '/../hambroperks-sdk/core/src/gen/objc'), includes: ['**/*.h', '**/*.m'])

        srcFiles.each { file ->
            args file.path
        }
}

The example above shows how to compile the test classes that have been translated.


### What J2ObjC Is ###
J2ObjC is an open-source command-line tool from Google that translates
Java source code to Objective-C for the iOS (iPhone/iPad) platform. This tool
enables Java source to be part of an iOS application's build, as no editing
of the generated files is necessary. The goal is to write an app's non-UI
code (such as application logic and data models) in Java, which is then
shared by web apps (using [GWT](http://www.gwtproject.org/)), Android apps,
and iOS apps.

J2ObjC supports most Java language and runtime features required by
client-side application developers, including exceptions, inner and
anonymous classes, generic types, threads and reflection. JUnit test
translation and execution is also supported.

J2ObjC is currently beta quality. Several Google projects rely on it, but
when new projects first start working with it, they usually find new bugs
to be fixed. If you run into issues with your project, please report them!

### What J2ObjC isn't ###
J2ObjC does not provide any sort of platform-independent UI toolkit, nor are
there any plans to do so in the future. We believe that iOS UI code needs to
be written in Objective-C, Objective-C++ or Swift using Apple's iOS SDK (Android
UIs using Android's API, web app UIs using GWT, etc.).

J2ObjC cannot convert Android binary applications. Developers must have source
code for their Android app, which they either own or are licensed to use.

## Requirements ##

* JDK 1.7 or higher
* Mac workstation or laptop
* Mac OS X 10.9 or higher
* Xcode 5 or higher

## License ##

This library is distributed under the Apache 2.0 license found in the
[LICENSE](./LICENSE) file.
