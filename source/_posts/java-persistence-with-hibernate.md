---
title: java-persistence-with-hibernate
date: 2015-11-06 11:49:34
tags: [hibernate, jpa]
---
# Understand object/relational persistence
the problem of granularity
粒度问题 4.4节描述了这个问题的解决方案
the problem of subtypes
5.1节将讨论ORM解决方案如何解决把一个类层次结构持久化到一个或者多个数据库表的问题
第5章介绍的继承映射解决方案中，有3种被设计为适应多态关联的表示法和多态查询的有效执行
## ORM
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

# Mapping persistent classes
Whether field or perperty access is enabled for an entity depends on the position of mandatory `@Id` annotation.
If it's present on a field, so all attributes of the class are accessed by Hibernate through fields.
## Fine-grained models and mappings
### Mapping basic properties
Using derived properties

    @org.hibernate.annotations.Formula("TOTAL + TAX_RATE * TOTAL")
    public BigDecimal getTotalIncludingTax() {
        return totalIncludingTax;
    }
The given SQL formula is evaluated every time the entity is retrieved from the database 
(and not at any other time, so the result may be outdated if other properties are modified).

Generated and default property values
Properties marked as database-generated must additionally be nininsertable and nonupdateable,
which you control with the insert and update attributes. If both are set to false, the property's
columns never appear in the INSERT or UPDATE statements-- the property value is read-only. Alse, 
you usually don't add a public setter method in your class for immutable property(and switch to field access).

    @Column(updatable = false, insertable = false)
    @org.hibernate.annotations.Generated(
        org.hibernate.annotations.GenerationTime.ALWAYS
    )
    private Date lastModified;

A special case of database-generated property values are default values.
you have to enable dynamic insertion and update statement generation, so that the column with the default
value isn't included in every statement if its value is null (otherwise a NULL would be inserted instead
of the default value). Furthermore, an instance of Item that has been made persistent but not yet flushed
to the database and not refreshed again won't have the default value set on the object property. In other
words, you need to execute an explicit flush;

    Item newItem = new Item(...);
    session.save(newItem);

    newItem.getInitialPrice();   // is null

    session.flush();             // Trigger an INSERT
    // Hibernate does a SELECT automatically

    newItem.getInitialPrice();   // is $1

    @Column(name = "INITIAL_PRICE",
            columnDefinition = "number(10, 2) default '1'")
    @org.hibernate.annotations.Generated(
        org.hibernate.annotations.GenerationTime.INSERT
    )
    @org.hibernate.annotations.DynamicInsert
    @org.hibernate.annotations.DynamicUpdate
    private BigDecimal initalPrice;

### Mapping components

    <<Table>> 
    USERS
    ---------------
    FIRSTNAME
    LASTNAME
    USERNAME
    PASSWORD
    EMAIL
    ---------------
    HOME_STREET
    HOME_ZIPCODE
    HOME_CITY
    ---------------
    BILLING_STREET
    BILLING_ZIPCODE
    BILLING_CITY

    @Entity
    @Table(name = "USERS")
    public class User {
        @Embedded
        private Address homeAddress;
    }

    @Embeddable
    public class Address {
        @Column(name = "ADDRESS_STREET", nullable = false)
        private String street;

        @Column(name = "ADDRESS_ZIPCODE", nullable = false)
        private String zipcode;

        @Column(name = "ADDRESS_CITY", nullable = false)
        private String city;
    }

    //=================================================================

    @Entity
    @Table(name = "USERS")
    public class User {
        @Embedded
        @AttributeOverrides({
            @AttributeOverride(name = "street",
                                column = @Column(name = "HOME_STREET")),
        @AttributeOverrides({
            @AttributeOverride(name = "zipcode",
                                column = @Column(name = "HOME_ZIPCODE")),
        @AttributeOverrides({
            @AttributeOverride(name = "city",
                                column = @Column(name = "HOME_CITY"))
        })
        private Address homeAddress;
    }

# Inheritance and custom types
## Mapping class inheritance
1. Table per concrete class with implicit polymorphism
2. Table per concrete class with unions(与1 表结构相同)
3. Table per class hierarchy
4. Table per subclass
5. Mixing inheritance strategies

### Table per concrete class with implicit polymorphism

    <<Table>>                   <<Table>>             
    CREDIT_CARD                 BANK_ACCOUNT
    ---------------             -----------------
    CREDIT_CARD_ID              BANK_ACCOUNT_ID
    OWNER                       OWNER
    NUMBER                      ACCOUNT
    EXP_MONTH                   BANKNAME
    EXP_YEAR                    SWIFT

    @MappedSuperclass
    public abstract class BillingDetails {
        @Column(name = "OWNER", nullable = false)
        private String owner;
    }
    
    @Entity
    @AttributeOverride(name = "owner", column =
        @Column(name = "CC_OWNER", nullable = false)
    )
    public class CreditCard extends BillingDetails {
        @Id
        @GeneratedValue
        @Column(name = "CREDIT_CARD_ID")
        private Long id = null;

        @Column(name = "NUMBER", nullable = false)
        private String number;
    }

### Table per concrete class with unions(与1 表结构相同)

    @Entity
    @Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
    public abstract class BillingDetails {
        @Id
        @GeneratedValue
        @Column(name = "BILLING_DETAILS_ID")
        private Long id = null;

        @column(name = "OWNER", nullable = false)
        private String owner;
    }

    @Entity
    @Table(name = "CREDIT_CARD")
    public class CreditCard extends BillingDetails {
        @Column(name = "NUMBER", nullable = false)
        private String number;
    }

### Table per class hierarchy

    <<Table>>
    BILLING_DETAILS
    -----------------------
    BILLING_DETAILS_ID
    BILLING_DETAILS_TYPE<<Discriminator>>
    OWNER
    CC_NUMBER
    CC_EXP_MONTH
    CC_EXP_YEAR
    BA_ACCOUNT
    BA_BANKNAME
    BA_SWIFT

    @Entity
    @Inheritance(strategy = InheritanceType.SINGLE_TABLE)
    @DiscriminatorColumn(
        name = "BILLING_DETAILS_TYPE",
        discriminatorType = DiscriminatorType.STRING
    )
    public abstract class BillingDetails {
        @Id
        @GeneratedValue
        @Column(name = "BILLING_DETAILS_ID")
        private Long id = null;

        @Column(name = "OWNER", nullable = false)
        private String owner;
    }

    @Entity
    @DiscriminatorValue("CC")
    public class CreditCard extends BillingDetails {
        @Column(name = "CC_NUMBER")
        private String number;
    }

### Table per subclass

    <<Table>>
    BILLING_DETAILS
    ------------------
    OWNER

    <<Table>>
    CREDIT_CARD
    -----------------
    CREDIT_CARD_ID<<PK>><<FK>>
    NUMBER
    EXP_MONTH
    EXP_YEAR

    <<Table>>
    BANK_ACCOUNT
    ----------------
    BANK_ACCOUNT_ID<<PK>><<FK>>
    ACCOUNT
    BANKNAME
    SWIFT

    @Entity
    @Inheritance(strategy = InheritanceType.JOINED)
    public abstract class BillingDetails {
        @Id
        @GeneratedValue
        @Column(name = "BILLING_DETAILS_ID")
        private Long id = nulll;
    }

    @Entity
    @PrimaryKeyJoinColumn(name = "CREDIT_CARD_ID")
    public class CreditCard extends BillingDetails {
    }

### Mixing inheritance strategies
    
    <<Table>>
    BILLING_DETAILS
    -------------------
    BILLING_DETAILS_ID
    BILLING_DETAILS_TYPE<<Discriminator>>
    OWNER
    BA_ACCOUNT
    BA_BANKNAME
    BA_SWIFT

    <<Table>>
    CREDIT_CARD
    -------------------
    CREDIT_CARD_ID<<PK>>
    CC_NUMBER
    CC_EXP_MONTH
    CC_EXP_YEAR

    @Entity
    @Inheritance(strategy = InheritanceType.SINGLE_TABLE)
    @DiscriminatorColumn(
        name = "BILLING_DETAILS_TYPE",
        discriminatorType = DiscriminatorType.STRING
    )
    public abstract class BillingDetails {
        @Id
        @GeneratedValue
        @Column(name = "BILLING_DETAILS_ID")
        private Long id = null;

        @Column(name = "OWNER", nullable = false)
        private String owner;
    }

    @Entity
    @DiscriminatorValue("CC")
    @SecondaryTable(
        name = "CREDIT_CARD"
        pkJoinColumns = @PrimaryKeyJoinColumn(name = "CREDIT_CARD_ID")
    )
    public class CreditCard extends BillingDetails {
        @Column(table = "credit_card",
                name = "CC_NUMBER",
                nullable = false)
        private String number;
    }

# Mapping collections and entity associations
## Mapping collections with annotations

    @ElementCollection
    @JoinTable(
        name = "ITEM_IMAGE"
        joinColumns = @JoinColumn(name = "ITEM_ID")
    )
    @Column(name = "FILENAME", nullable = false)
    private Set<String> images = new HashSet<String>();


    @ElementCollection
    @JoinTable(
        name = "ITEM_IMAGE"
        joinColumns = @JoinColumn(name = "ITEM_ID")
    )
    @OrderColumn(name = "POSITION")
    @org.hibernate.annotations.ListIndexBase(1)
    @Column(name = "FILENAME")
    private List<String> images = new ArrayList<String>();


    @ElementCollection
    @JoinTable(
        name = "ITEM_IMAGE"
        joinColumns = @JoinColumn(name = "ITEM_ID")
    )
    @org.hibernate.annotations.MapKey(
        columns = @Column(name = "IMAGENAME")
    )
    @Column(name = "FILENAME", nullable = false)
    private Map<String, String> images = new HashMap<String, String>();


    @ElementCollection
    @JoinTable(
        name = "ITEM_IMAGE"
        joinColumns = @JoinColumn(name = "ITEM_ID")
    )
    @Column(name = "FILENAME", nullable = false)
    @org.hibernate.annotations.Sortnatural
    private SortedSet<String> images = new TreeSet<String>();


    @ElementCollection
    @JoinTable(
        name = "ITEM_IMAGE"
        joinColumns = @JoinColumn(name = "ITEM_ID")
    )
    @Column(name = "FILENAME", nullable = false)
    @org.hibernate.annotations.OrderBy(
        clause = "FILENAME asc"
    )
    private SortedSet<String> images = new TreeSet<String>();


### Mapping a collection of embedded objects

    @Embeddable
    public class Image {
        @org.hibernate.annotations.Parent
        Item item;

        @Column(length = 255, nullable = false)
        private String name;
        @Column(length = 255, nullable = false)
        private String filename;

        @Column(nullable = false)
        private int sizeX;

        @Column(nullable = false)
        private int sizeY;
    }


    @ElementCollection
    @JoinTable(
        name = "ITEM_IMAGE"
        joinColumns = @JoinColumn(name = "ITEM_ID")
    )
    @AttributeOverride(
        name = "element.name",
        column = @Column(name = "IMAGENAME",
                        length = 255,
                        nullable = false)
    )
    private Set<Image> images = new HashSet<Image>();


    @ElementCollection
    @JoinTable(
        name = "ITEM_IMAGE"
        joinColumns = @JoinColumn(name = "ITEM_ID")
    )
    @org.hibernate.annotations.CollectionId(
        columns = @Column(name = "ITEM_IMAGE_ID"),
        type = @org.hibernate.annotations.Type(type = "long"),
        generator = "sequence"
    )
    private Collection<Image> images = new ArrayList<Image>();


## Mapping a parent/children relationship
在操作两个实例之间的链接时，如果没有inverse属性，Hibernate会试图执行两个不同的SQL语句，这两者更新同一个
外键列。通过指定inverse="true"，显式地告诉Hibernate链接的哪一端不应该与数据库同步。
JPA注解的mappedBy属性相当于XML映射中的inverse属性

cascade和inverse都不出现在值类型的集合或者任何其他值类型映射中。这些规则隐含在值类型的特性中。

    public class Bid {
        @ManyToOne
        @JoinColumn(name = "ITEM_ID", nullable = false)
        private Item item;
    }

    public class Item {
        @OneToMany(cascade = { CascadeType.PERSIST,
                               CascadeType.MERGE,
                               CascadeType.REMOVE },
                   orphanRemoval = true,
                   mappedBy = "item")
        private Set<Bid> bids = new HashSet<Bid>();
    }

# Advanced entity association mappings
## single-valued entity associations
### Shared primary key associations

    @OneToOne
    @PrimaryKeyJoinColumn
    private Address shippingAddress;


    @Entity
    @Table(name = "ADDRESS")
    public class Address {
        @Id
        @GeneratedValue(generator = "myForeignGenerator")
        @org.hibernate.annotations.GenericGenerator(
            name = "myForeignGenerator",
            strategy = "foreign",
            parameters = @Parameter(name = "property", value = "user")
        )
        @Column(name = "ADDRESS_ID")
        private Long id;

        private User user;
    }

### One-to-one foreign key asociations

    public class User {
        @OneToOne
        @JoinColumn(name = "SHIPPING_ADDRESS_ID")
        private Address shippingAddress;
    }


    public class Address {
        @OneToOne(mappedBy = "shippingAddress")
        private User user;
    }

### Mapping with a join table

    public class Shipment {
        @OneToOne
        @JoinTable(
            name = "ITEM_SHIPMENT",
            joinColumns = @JoinColumn(name = "SHIPMENT_ID"),
            inverseJoinColumns = @JoinColumn(name = "ITEM_ID")
        )
        private Item auction;
    }


    @Entity
    @Table(name = "SHIPMENT")
    @SecondaryTable(name = "ITEM_SHIPMENT")
    public class Shipment {
        @Id
        @GeneratedValue
        @Column(name = "SHIPMENT_ID")
        private Long id;
    }
