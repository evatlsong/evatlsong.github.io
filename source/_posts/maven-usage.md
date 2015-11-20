---
title: maven-usage
date: 2015-11-06 16:20:03
tags: [maven]
---
## resources
解决hibernate mybatis 找不到xml文件的错误

    <build>
        <resources>
            <resource>
                <directory>src/main/java</directory>
                <includes>
                    <include>**/*.xml</include>
                </includes>
                <filtering>true</filtering>
            </resource>
        </resources>
    </build>
