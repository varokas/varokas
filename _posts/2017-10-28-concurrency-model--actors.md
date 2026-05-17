---
layout: post
title: 'Concurrency Model: Actors'
date: '2017-10-28 00:00:00 +0000'
slug: concurrency-model--actors
permalink: "/concurrency-model--actors/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  Actors could be considered tiny micro services within our application. They consist of Actors that act on predefined set of Messages when…
canonical_url: https://medium.com/@varokas/concurrency-model-actors-8fa1b5459c88
ghost_id: 5e929aca9c3d50000174a32b
visibility: public
---

<p>Actors could be considered tiny micro services within our application. They consist of <strong>Actors</strong> that act on predefined set of <strong>Messages </strong>when received. Notable example is <a href="https://doc.akka.io/docs/akka/2.5.4/scala/actors.html">Akka Actors</a>.</p><h3 id="akka-actors">Akka Actors</h3><p>A <strong>Message</strong> is simply a Scala case class which carries information</p><pre><code>case class Message(info: String)</code></pre><p>An <strong>Actor</strong> receives messages that are sent directly to it</p><pre><code>class MyActor extends Actor {
  def receive = {
    case Message(info) =&gt; println(s"received: $info")
    case _             =&gt; println("unknown message")
  }
}</code></pre><p>To send a message, use an exclamation mark (!). This could be done from anywhere. Usually it is from an external event or another actor.</p><pre><code>myActor ! myMessage</code></pre><p>Before using actors, we need to create the system and the actors within. It is important to keep references to all the actors and that will be used for message passing later on.</p><pre><code>val system = ActorSystem("actors")
val myActor = system.actorOf(Props[MyActor])</code></pre><h3 id="good-for">Good For</h3><ul><li>Simulation of interaction between real-world objects, systems, or software processes</li><li>When we know exactly who is the entity (actor) responsible for processing the message</li></ul><h3 id="not-good-for">Not Good For</h3><ul></ul><!--kg-card-begin: html--><iframe src="https://embed.scalafiddle.io/embed?sfid=vyKmCe4/2&passive&" width="1032" height="430" frameborder="0" scrolling="no"></iframe><!--kg-card-end: html-->
