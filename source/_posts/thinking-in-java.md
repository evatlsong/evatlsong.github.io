---
title: thinking-in-java
date: 2015-08-16 17:51:25
tags:
---
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
