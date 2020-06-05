Pod::Spec.new do |s|
  s.name         = "J2ObjC"
  s.version      = "2.6"
  s.license      = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.summary      = "J2ObjC's JRE emulation library, emulates a subset of the Java runtime library."
  s.homepage     = "https://github.com/google/j2objc"
  s.author       = "Google Inc."
  s.source       = { :git => "git@github.com:LAundryMan-UAE/j2objc.git", :tag => "v#{s.version}-lib" }

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.requires_arc = false
  s.default_subspec = 'lib/jre'
  s.compiler_flags = '-Wno-nullability-completeness'

  # Top level attributes can't be specified by subspecs.
  s.header_mappings_dir = 'dist/include'
  s.prepare_command = <<-CMD
    scripts/download_distribution.sh
  CMD

  s.subspec 'lib' do |lib|
    lib.frameworks = 'Security'
    lib.osx.frameworks = 'ExceptionHandling'
    lib.xcconfig = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/J2ObjC/dist/lib"', \
      'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/J2ObjC/dist/include"' }

    lib.compiler_flags = '-Wno-nullability-completeness'
    lib.subspec 'jre' do |jre|
      jre.preserve_paths = 'dist'
      jre.libraries = 'jre_emul', 'icucore', 'z'
      #jre.xcconfig = { 'OTHER_LDFLAGS' => '-force_load ${PODS_ROOT}/J2ObjC/dist/lib/libjre_emul.a' }
    end

    lib.subspec 'jsr305' do |jsr305|
      jsr305.dependency 'J2ObjC/lib/jre'
      jsr305.libraries = 'jsr305'
      jsr305.compiler_flags = '-Wno-nullability-completeness'
    end

    lib.subspec 'junit' do |junit|
      junit.dependency 'J2ObjC/lib/jre'
      junit.libraries = 'j2objc_main', 'junit', 'mockito'
      junit.compiler_flags = '-Wno-nullability-completeness'
    end

    lib.subspec 'guava' do |guava|
      guava.dependency 'J2ObjC/lib/jre'
      guava.libraries = 'guava'
      guava.compiler_flags = '-Wno-nullability-completeness'
    end

  end
end
