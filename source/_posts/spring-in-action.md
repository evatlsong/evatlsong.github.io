---
title: spring-in-action
date: 2015-11-04 16:14:54
tags:
---
# java based
## AbstractAnnotationConfigDispatcherServletInitializer exposed

In a Servlet 3.0 environment, the container looks for any classes in the classpath that
implement the `javax.servlet.ServletContainerInitializer` interface; if any are found, 
they're used to configure the servlet container.

Spring supplies an implementation of that interface called `SpringServletContainerInitializer`
that, in turn, seeks out any classes that implement `WebApplicationInitializer` and delegates
to them for configuration. Spring 3.2 introduced a convenient base implementation of
`WebApplicationInitializer` called `AbstractAnnotationConfigDispatcherServletInitializer`.

## Adding additional servlets and filters

    public class MyServletInitializer implements WebApplicationInitializer throws ServletException {
        @Override
        public void onStartup(ServletContext servletContext) {
            Dynamic myServlet = servletContext.addServlet("myServlet", MyServlet.class);
            myServlet.addMapping("/custom/**");
        }
    }

    @Override
    public void onStartup(ServletContext servletContext)
            throws ServletException {
        javax.servlet.FilterRegistration.Dynamic filter = 
            servletContext.addFilter("myFilger", MyFilger.class);
        filter.addMappingForUrlPatterns(null, false, "/custom/*");
    }

to register one or more filters and map them to DispatcherServlet, all you need to do is override
the `getServletFilters()` method of `AbstractAnnotationConfigDispatcherServletInitializer`

    @Override
    protected Filter[] getServletFilters() {
        return new Filter[] { new MyFilter() };
    }

A controller advice is any class that's annotated with `@ControllerAdvice` and has one or more of 
the following kind of methods:
@ExceptionHandler
@InitBinder
@ModelAttribute
Those methods in an `@ControllerAdvice`-annotated class are applied globally across all 
`@RequestMapping`-annotated methods on all controllers in an application.
