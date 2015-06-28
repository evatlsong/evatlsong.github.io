title: maven-in-action
date: 2015-06-17 15:01:48
tags:
---
使用Archetype生成项目骨架
mvn archetype:generate
mvn org.apache.maven.plugins:maven-archetype-plugin:2.0-alpha-5:generate
format:    groupId:artifactId:version:goal

Maven坐标的元素包括groupId,artifactId,version,packaging(可选 默认为jar),classifier(不能直接定义)

依赖范围   编译classpath 测试classpath 运行classpath sample
compile    Y             Y             Y             spring-core
test       -             Y             -             JUnit
provided   Y             Y             -             servlet-api
runtime    -             Y             Y             JDBC驱动实现
system     Y             Y             -             本地的 Maven仓库之外的类库文件
import

依赖范围影响传递性依赖
          compile    test    provided    runtime
compile   compile    -       -           runtime
test      test       -       -           test
provided  provided   -       provided    provided
runtime   runtime    -       -           runtime
最左边一列表示第一直接依赖范围 最上面一行表示第二直接依赖范围 中间的交叉单元格表示传递性依赖范围

优化依赖
mvn dependency:list
mvn dependency:tree
mvn dependency:analyze

Used undeclared dependencies
Unused declared dependencies

三套声明周期 
clean
  pre-clean clean post-clean
default
  validate initialize generate-sources process-sources generate-resources process-resources compile process-classes generate-test-sources
  process-test-sources generate-test-resources process-test-resources test-compile process-test-classes test prepare-package
  package pre-integration-test integration-test post-integration-test verify install deploy
site
  pre-site site post-site site-deploy

各个声明周期是独立的 而一个声明周期的阶段是有前后依赖关系的



插件配置
命令行插件配置
mvn install -Dmaven.test.skip=true
参数-D是Java自带的 其功能是通过命令行设置一个Java系统属性 Maven简单地重用了该参数 在准备插件的时候检查系统属性 便实现了插件参数的配置
POM中插件全局配置
<plugin>
<configration></configration>
</plugin>
POM中插件任务配置

命令行参数是由该插件参数的表达式(Expression)决定的

mvn help:describe -Dplugin=org.apache.maven.plugins:maven-compiler-plugin
mvn help:describe -Dplugin=compiler
mvn help:describe -Dplugin=compiler -Dgoal=compile
mvn help:describe -Dplugin=compiler -Ddetail
使用目标前缀(Goal Prefix) 简化groupId artifactId

通过mvn命令激活生命周期阶段 从而执行那些绑定在生命周期阶段上的插件目标
example: mvn compile
但Maven还支持直接从命令行调用插件目标 从而执行不适合绑定在生命周期上的任务 
example: mvn help:describe -Dplugin=compiler
