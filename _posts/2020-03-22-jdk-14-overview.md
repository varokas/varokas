---
layout: post
title: JDK 14 Feature Overview
date: '2020-03-22 21:34:00 +0000'
slug: jdk-14-overview
permalink: "/jdk-14-overview/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/photo-1497515114629-f71d768fd07c?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=2000&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ
ghost_id: 5e929aca9c3d50000174a348
visibility: public
---

<p>JDK 14 was officially <a href="https://openjdk.java.net/projects/jdk/14/">GA released</a> on 17 March 2020. </p><p>These major releases are much more frequent in past years. However, I still find the release notes not an ideal source in providing a quick overview of what is new in the release. Hopefully this blog helps highlight what those exciting new features are.</p><h2></h2><h3 id="358-helpful-nullpointerexceptions">358:  Helpful NullPointerExceptions</h3><p>Finally, a helpful messages to pinpoint where <code>null</code> value actually is in the line. Make sure <code>-XX:+ShowCodeDetailsInExceptionMessages</code> flag is passed to java runtime.</p><pre><code class="language-java">class Address { String street; String zipCode; }
class Profile { String name; Address address; }

String zip = p.address.zipCode; </code></pre><p>Yield an exception that exactly describe what is being wrong. </p><pre><code>java.lang.NullPointerException: 
Cannot read field "zipCode" because "p.address" is null</code></pre><h3 id="361-switch-expressions-standard-">361: Switch Expressions (Standard)</h3><p>Becomes a standard feature after preview in Java 12. Switch is now an expression which can return value using <code>-&gt;</code> syntax.</p><pre><code class="language-java">var text = switch (number) {
    case  1 -&gt; "one";
    case  2 -&gt; "two";
    default -&gt; "many";
};</code></pre><h2 id="preview-features">Preview Features</h2><p>To use these features,  The flag <code>--enable-preview</code> needed to be passed to <code>javac</code> during compile time.</p><h3 id="368-text-blocks-second-preview-">368:  Text Blocks (Second Preview) </h3><p>Supports Multiline text and intelligently trim the leading spaces. </p><p>The compiler will look at the minimum number of  spaces from all text lines. Then it take that value as the exact amount of  spaces to remove from every line. An obvious caveat is that there has to be a newline before and after <code>"""</code> (unlike in Python)</p><pre><code class="language-java">var text = """
           Multiline
           Text
           """;
           
// Automatically trim leading whitespace
assertEquals("Multiline\nText\n", text);</code></pre><h3 id="305-pattern-matching-for-instanceof-preview-">305:  Pattern Matching for instanceof (Preview)</h3><p>No longer needed to cast an instance of object after it is checked. </p><pre><code class="language-java">Object obj = 1;
if (obj instanceof Integer i) {
    //Compiler recognize `i` as Integer. No need for casting
    var longVal = i.longValue();
    assertEquals(1L, longVal);
}</code></pre><h3 id="359-records-preview-">359:  Records (Preview)</h3><p>This feature is very similar to <a href="https://kotlinlang.org/docs/reference/data-classes.html">Kotlin Data Classes</a> and <a href="https://docs.scala-lang.org/tour/case-classes.html">Scala Case Classes</a>. </p><p>Now we can define a type that has a constructor, toString, hashCode and equals automatically generated. Each field also is effectively <code>final</code>. </p><pre><code class="language-java">record Person(String firstname, String lastname) {
    public String getName() {
        return firstname + " " + lastname;
    }
}

///////////////////

final var p = new Person("Hello", "World");

assertEquals(new Person("Hello", "World"), p, "Equality implemented");
assertEquals("Person[firstname=Hello, lastname=World]",
        p.toString(),
        "toString() implemented");

assertEquals("Hello", p.firstname, "Member");
assertEquals("Hello", p.firstname(), "Accessor");

// Won't compile - Cannot assign a value to final variable 'firstname'
// p.firstname = "New"; 

assertEquals("Hello World", p.getName(), "Custom method");</code></pre><h2 id="other-features">Other Features</h2><p>These are some additional features that I personally find interesting.</p><ul><li>JEP 343: Packaging Tool (Incubator) - Create a standalong java package to run from any platflom without requiring target platform to pre-install Java.</li><li>JEP 370: Foreign-Memory Access API (Incubator)</li></ul><h2 id="gradle-project">Gradle Project</h2><p>All changes and flags are collected in this github repo.</p><figure class="kg-card kg-bookmark-card"><a class="kg-bookmark-container" href="https://github.com/varokas/java-versions"><div class="kg-bookmark-content"><div class="kg-bookmark-title">varokas/java-versions</div><div class="kg-bookmark-description">Contribute to varokas/java-versions development by creating an account on GitHub.</div><div class="kg-bookmark-metadata"><img class="kg-bookmark-icon" src="https://github.githubassets.com/favicon.ico" alt=""><span class="kg-bookmark-author">GitHub</span><span class="kg-bookmark-publisher">varokas</span></div></div><div class="kg-bookmark-thumbnail"><img src="https://avatars2.githubusercontent.com/u/1317078?s&#x3D;400&amp;v&#x3D;4" alt=""></div></a></figure><h2 id="tools-requirements">Tools Requirements</h2><p>At the time of this post, many popular tools has JDK 14 support only in their Preview / Beta releases. </p><ul><li>Java 14 SDK</li><li>Gradle 6.3 (currently in RC. Any version lower than 6.3 will not work because of Issue <a href="https://github.com/gradle/gradle/issues/10248">#10248</a> )</li><li>Intellij 2020.1 (currently in <a href="https://www.jetbrains.com/idea/nextversion/">EAP</a>)</li><li>Compile and run java with correct flags for preview features. </li></ul><p>Using <a href="https://sdkman.io">SDKMan</a> helps installing Java/Gradle with ease.</p><pre><code class="language-bash">$ sdk install java 14.0.0.hs-adpt
$ sdk install gradle 6.3-rc-4</code></pre><p>After importing the project in IntelliJ, make sure JDK 14 is being used for both Project SDK and Gradle. Language level should be 14 (Preview) for all the preview features to be highlighted correctly. </p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2020/03/Screen-Shot-2020-03-22-at-2.13.53-PM.png" class="kg-image" alt loading="lazy"></figure><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2020/03/Screen-Shot-2020-03-22-at-2.13.18-PM.png" class="kg-image" alt loading="lazy"></figure>
