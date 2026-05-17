---
layout: post
title: AWS Lambda Functions in Scala
date: '2021-01-04 11:08:03 +0000'
slug: aws-lambda-functions-in-scala
permalink: "/aws-lambda-functions-in-scala/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/photo-1518692118831-d2b55f1d014c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxMTc3M3wwfDF8c2VhcmNofDR8fGxhbmV8ZW58MHx8fA&ixlib=rb-1.2.1&q=80&w=2000
ghost_id: 5ff2debd2a88f40001aa88ad
visibility: public
---

<h3 id="initialize-scala-project">Initialize Scala Project</h3><p>Assuming we are familiar with SBT and have that installed </p><pre><code class="language-sh">$ sbt new scala/scala-seed.g8

A minimal Scala project.

name [Scala Seed Project]: Lambda Scala Seed

Template applied in /Users/vpanusuwan/projects/./lambda-scala-seed</code></pre><h3 id="add-lambda-library">Add Lambda Library</h3><p>The libraries contains event classes which is a typed input for lambda. Check latest version at mvnrepository for <a href="https://mvnrepository.com/artifact/com.amazonaws/aws-lambda-java-core">java-core</a> and <a href="https://mvnrepository.com/artifact/com.amazonaws/aws-lambda-java-events">java-events </a>separately. </p><pre><code class="language-scala">    libraryDependencies ++= Seq(
      "com.amazonaws" % "aws-lambda-java-core" % awsLambdaVersion,
      "com.amazonaws" % "aws-lambda-java-events" % awsLambdaEventsVersion,
      scalaTest % Test
    )</code></pre><h3 id="create-handler-function">Create handler function</h3><p>Create a class with method of any name in any package. The important thing is that the method accepts a lambda event </p><pre><code class="language-scala">package example

import com.amazonaws.services.lambda.runtime.Context
import com.amazonaws.services.lambda.runtime.events.{APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse}

class Main  {
  def handler(apiGatewayEvent: APIGatewayV2HTTPEvent, context: Context): APIGatewayV2HTTPResponse = {
    println(s"body = ${apiGatewayEvent.getBody()}")
    return APIGatewayV2HTTPResponse.builder()
      .withStatusCode(200)
      .withBody("okay")
      .build()
  }
}

</code></pre><h3 id="configure-assembly-plugin">Configure Assembly Plugin</h3><p>Next is to configure the assembly plugin to produce a single fat jar containing our code and all the dependencies together. See latest version of the plugin at <a href="https://github.com/sbt/sbt-assembly">https://github.com/sbt/sbt-assembly</a> </p><p>In <code>project/plugins.sbt</code></p><pre><code class="language-scala">addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.15.0")
</code></pre><p>In <code>build.sbt</code>, configure the fat jar merging strategies. At very minimum we should discard contents in <code>META-INF</code>. Also overrides a jar name.</p><pre><code class="language-scala">assemblyJarName in assembly := "lambda-scala-seed.jar"

assemblyMergeStrategy in assembly := {
  case PathList("META-INF", xs @ _*) =&gt; MergeStrategy.discard
  case x =&gt; MergeStrategy.first
}</code></pre><h3 id="package">Package </h3><pre><code class="language-bash">sbt assembly</code></pre><p>Then finds the packaged jar at <code>target/scala-2.13/&lt;jarname&gt;</code></p><h3 id="create-function">Create Function</h3><p>Install aws cli tool <a href="https://aws.amazon.com/cli/">https://aws.amazon.com/cli/</a>. Uses following commands to deploy / update the function. </p><p>First, Lambda needs a role to execute, which should at least have the <code>AWSLambdaBasicExecutionRole</code> <a href="https://console.aws.amazon.com/iam/home?region=us-west-2#/policies/arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole$serviceLevelSummary">policy</a> attached. The policy simply enables a write to CloudWatch logs. A cdk snipplet to create such role would be.</p><pre><code class="language-python"> lambda_basic_policy = iam.ManagedPolicy.from_aws_managed_policy_name("service-role/AWSLambdaBasicExecutionRole")
 
role = iam.Role(self, "fn_lambda_role", role_name="fn_lambda_role", assumed_by=iam.ServicePrincipal("lambda.amazonaws.com"))
role.add_managed_policy(lambda_basic_policy)</code></pre><p>Then we can deploy the jar to lambda </p><pre><code class="language-bash">aws lambda create-function \
  --function-name lambda-scala-seed \
  --role "arn:aws:iam::&lt;aws_account_no&gt;:role/fn_lambda_role" \
  --zip fileb://target/scala-2.13/lambda-scala-seed.jar \
  --runtime java11 \
  --memory 256 \
  --handler "example.Main::handler"
</code></pre><h3 id="test-function">Test Function</h3><pre><code class="language-bash">aws lambda invoke --function-name "lambda-scala-seed" /dev/stdout</code></pre><h3 id="update-function">Update Function</h3><pre><code class="language-bash"> aws lambda update-function-code \
 --function-name "lambda-scala-seed" \
 --zip fileb://target/scala-2.13/lambda-scala-seed.jar
</code></pre><h3 id="references">References</h3><ul><li><a href="https://aws.amazon.com/blogs/compute/writing-aws-lambda-functions-in-scala/">https://aws.amazon.com/blogs/compute/writing-aws-lambda-functions-in-scala/</a></li><li>Events Example – <a href="https://github.com/awsdocs/aws-lambda-developer-guide/tree/main/sample-apps/java-events">https://github.com/awsdocs/aws-lambda-developer-guide/tree/main/sample-apps/java-events</a></li></ul><h3 id> </h3>
