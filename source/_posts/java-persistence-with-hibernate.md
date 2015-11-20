---
title: java-persistence-with-hibernate
date: 2015-11-06 11:49:34
tags: [hibernate]
---
### the problem of granularity
粒度问题 4.4节描述了这个问题的解决方案
### the problem of subtypes
5.1节将讨论ORM解决方案如何解决把一个类层次结构持久化到一个或者多个数据库表的问题
第5章介绍的继承映射解决方案中，有3种被设计为适应多态关联的表示法和多态查询的有效执行
### What is ORM?
An ORM solution consists of the following four pieces:
* An API for performing basic CRUD operations on objects of persistent classes
* A language or API for specifying queries that refer to classes and properties of classes
* A facility for specifying mapping metadata
* A technique for the ORM implementation to interact with transactional objects to perform
  dirty checking,lazy association fetching, and other optimization functions

### Generic ORM problems
* What do persistent classes look like
* How is mapping metadata defined
* How do object identity and equality relate to database (primary key) identity
* How should we map class inheritance hierarhies
* How does the persistence logic interact at runtime with the objects of the business domain
* What is the lifecycle of a persistent object
* What facilities are provided for sorting,searching,and aggregating
* How do we efficiently retrieve data with associations

### Hibernate configuration and startup
`hibernate.generate_statistics` 启用统计集合
