---
title: thinking-in-java
date: 2015-08-16 17:51:25
tags: [java]
---
# 初始化与清理
## this关键字
对当前对象的引用
`this(args)`
可以用this调用一个构造器，但却不能调用两个。此外，必须将构造器调用置于最起始处
`static`方法就是没有`this`的方法
`static`方法内部不能调用非静态方法
## 清理：终结处理和垃圾回收
`protected void finalize()`
## 成员初始化
所有变量在使用前都能得到恰当的初始化
方法的局部变量，Java以编译时错误的形式来贯彻这种保证
类的字段会有初始值
## 构造器初始化
对象的创建过程
1. 即使没有显式地使用`static`关键字，构造器实际上也是静态方法。因此，当首次创建类型为Dog
   的对象时（构造器可以看成静态方法）,或者Dog类的静态方法/静态域首次被访问时，Java解释器必须
   查找类路径，以定位`Dog.class`文件。
2. 然后载入`Dog.class`（后面会学到，这将创建一个Class对象），有关静态初始化的所有动作都会执行，
   因此，静态初始化只在Class对象首次加载的时候进行一次。
3. 当用`new Dog()`创建对象的时候，首先将在堆上为`Dog`对象分配足够的存储空间。
4. 这块存储空间会被清零，这就自动地将`Dog`对象中的所有基本类型数据都设置成了默认值
   （对数字来说就是0，对布尔型和字符型也相同）,而引用则被设置成了`null`.
5. 执行所有出现于字段定义处的初始化动作。
6. 执行构造器。
### 显示的静态初始化
Java允许将多个静态初始化动作组织成一个特殊的静态字句（有时也叫做静态块）

    public class Cups {
        static Cup cup1;
        static Cup cup2;
        static {
            cup1 = new Cup(1);
            cup2 = new Cup(2);
        }
    }

### 非静态实例初始化
可以保证无论调用了哪个显式构造器，某些操作都会发生。

    public class Cups {
        Cup cup1;
        Cup cup2;
        {
            cup1 = new Cup(1);
            cup2 = new Cup(2);
        }
    }

## 数组初始化
`int[] a1 = { 1, 2, 3};`
`int[] a1 = new int[3];`
`Integer[] a1 = {new Integer(1), new Integer(2), new Integer(3)};`
`Integer[] a1 = new Integer[3];`

### 可变参数列表
应该总是只在重载方法的一个版本上使用可变参数列表，或者压根就不使用它

public class OverloadingVarargs3 {
    static void f(float i, Character... args) {
        System.out.println("first");
    }

    static void f(char c, Character... args) {
        System.out.println("second");
    }

    public static void main(String[] args) {
        f(1, 'a');
        f('a', 'b');
    }
}

// {CompileTimeError} (Won't compile)
public class OverloadingVarargs2 {
    static void f(float i, Character... args) {
        System.out.println("first");
    }

    static void f(Character... args) {
        System.out.print("second");
    }

    public static void main(String[] args) {
        f(1, 'a');
        // f('a', 'b');
    }
}

# 访问权限控制
## 包：库单元
Java解释器的运行过程如下：首先，找出环境变量CLASSPATH。CLASSPATH包含一个或多个目录，用作查找.class文件的根目录。
从根目录开始，解释器获取包的名称并将每个句点替换成反斜杠，以从CLASSPATH根中产生一个路径名称。得到的路径会与
CLASSPATH中的各个不同的项相连接，解释器就在这些目录中查找与你所要创建的类名称相关的.class文件。（解释器还会
去查找某些设计Java解释器所在位置的标准目录。）
## Java访问权限修饰词
1. public
2. protected(也提供包访问权限)
3. 默认的包访问权限
4. private
## 类的访问权限
1. public
2. 包访问权限

# 复用类
## final 关键字
### final数据
1. 一个永不改变的编译时常量。
2. 一个在运行时被初始化的值，而你不希望它被改变
final参数
你无法在方法中更改参数引用所指向的对象
### final方法
只有在想要明确禁止覆盖时，才将方法设置为final的。
### final类
不能被继承

# 多态
多态也称动态绑定、后期绑定或运行时绑定
## 转机
### 方法调用绑定
Java中除了static方法和final方法（private方法属于final方法）之外，其他所有的方法都是后期绑定。
## 构造器和多态
当覆盖被继承类的`dispose()`方法时，务必记住调用基类版本`dispose()`方法；否则，基类的清理动作就不会发生。
要调用构造器内部的一个动态绑定方法，就要用到那个方法的被覆盖后的定义
## 协变返回类型
导出类中的被覆盖方法可以返回基类方法的返回类型的某种导出类型

# 泛型
## 简单泛型

    public class Holder3<T> {
        private T a;

        public Holder3(T a) {
            this.a = a;
        }

        public void set(T a) {
            this.a = a;
        }

        public T get() {
            return a;
        }

        public static void main(String[] args) {
            Holder3<Automobile> h3 = new Holder3<Automobile>(new Automobile());
            Automobile a = h3.get(); // No cast needed
            // h3.set("Not an Automobile"); // Error
            // h3.set(1); // Error
        }
    } // /:~

# annotation
## Basic syntax
three built-in annotations
* @Override
* @Deprecated
* @SuppressWarnings

### Defining annotations

    import java.lang.annotation.*;

    @Target(ElementType.METHOD)
    @Retection(RetentionPolicy.RUNTIME)
    public @interface UseCase {
        public int id();
        public String description() default "no description";
    }

    import java.util.*;
    public class PasswordUtils {
        @UseCase(id = 48, description = "encrypt password")
        public String encryptPassword(String password) {
            return new StringBuilder(password).reverse().toString();
        }
    }

### Meta-annotations
* @Target     Where this annotation can be applied. The possible `ElementType` arguments are:
            CONSTRUCTOR:
            FIELD:
            LOCAL_VARIABLE:
            METHOD:
            PACKAGE:
            PARAMETER:
            TYPE:
* @Retention  How long the annotation information is kept. The possible `RetentionPolicy` arguments are:
            SOURCE:
            CLASS:
            RUNTIME:
* @Documented Include this annotation int the Javadocs.
* @Inherited  Allow subclasses to inherit parent annotations.

## Writing annotation processors

**Class**, **Method** and **Field** all implement the AnnotatedElement interface

a list of the allowed types for annotation elements:
(you are not allowed to use any of the wrapper classes)
* All primitives(int, float, boolean etc.)
* String
* Class
* Enums
* Annotations
* Arrays of any of the above
### Default value constraints
elements must either have default values or values provided by the class that uses the annotation.
none of the non-primitive type elements are allowed to take `null` as a value
you can provide specific values, like empty strings or negative values
This is a typical idiom in annotation definitions.

# Java I/O 系统
## 对象序列化

    public static void serializeStaticState(ObjectOutputStream os)
            throws IOException {
        os.writeInt(color);
    }

    public static void deserializeStaticState(ObjectInputStream os)
            throws IOException {
        color = os.readInt();
    }

    private void writeObject(ObjectOutputStream stream) throws IOException {
        stream.defaultWriteObject();
        serializeStaticState(stream);
    }
    private void readObject(ObjectInputStream stream) throws IOException, ClassNotFoundException {
        stream.defaultReadObject();
        deserializeStaticState(stream);
    }
