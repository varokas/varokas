---
layout: post
title: Using AWS as Terraform Backend
date: '2020-03-26 01:43:58 +0000'
slug: using-aws-as-terraform-backend
permalink: "/using-aws-as-terraform-backend/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/photo-1512509739856-4ffd1007b233?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=2000&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ
ghost_id: 5e929aca9c3d50000174a349
visibility: public
---

<p><a href="https://www.terraform.io">Terraform</a> is great at provisioning cloud infrastructure. Terraform needs to keep the current state somewhere. Local filesystem can be used in many cases, but not ideal if there are multiple people sharing this state file. In case of AWS, we usually wants to keep it in AWS itself. </p><p>We can actually use terraform to provision these. I do find a simple copy and paste one-time run bash script sufficient for this case. This way, we do not need to maintain two sets of terraform scripts.</p><h3 id="download-and-configure-aws-cli">Download and Configure AWS CLI </h3><pre><code class="language-bash">brew install awscli</code></pre><p>Then create a profile with keys</p><pre><code class="language-bash">$ aws configure --profile myprofile
AWS Access Key ID [None]: &lt;key&gt;
AWS Secret Access Key [None]: &lt;value&gt;
Default region name [None]: &lt;region or leave none&gt;
Default output format [None]: yaml</code></pre><h3 id="create-s3-bucket">Create S3 Bucket </h3><p>It is recommended to turn on bucket versioning so the history of states is preserved.</p><pre><code class="language-bash">$ aws s3 mb s3://&lt;project&gt;-tfstate \
  --profile myprofile \
  --region us-west-2

$ aws s3api put-public-access-block \
  --bucket &lt;project&gt;-tfstate \
  --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true" \
  --profile myprofile \
  --region us-west-2

$ aws s3api put-bucket-versioning \
  --bucket &lt;project&gt;-tfstate \
  --versioning-configuration "Status=Enabled" \
  --profile myprofile \
  --region us-west-2
</code></pre><h3 id="create-dynamodb-table">Create DynamoDB Table </h3><p>While terraform uses S3 to store the actual state, it needs some locking mechanism that S3 does not provide. This is done via DynamoDB. The table must have a primary key named <code>LockID</code> as a string. </p><pre><code class="language-bash">aws dynamodb create-table \
  --table-name &lt;project&gt;-tfstate \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --profile myprofile \
  --region us-west-2</code></pre><h3 id="use-the-backend-in-terraform">Use the Backend in Terraform</h3><p>Now we can configure S3 (and DynamoDB) as our backend in <code>main.tf</code></p><pre><code>terraform {
  backend "s3" {
    bucket = "&lt;project&gt;-tfstate"
    key    = "terraform.tfstate"
    dynamodb_table = "&lt;project&gt;-tfstate"
    encrypt = true
    region = "us-west-2"
    profile = "myprofile"
  }
}</code></pre><h3 id="references">References</h3><ul><li><a href="https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html#cli-quick-configuration">https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html#cli-quick-configuration</a></li><li><a href="https://docs.aws.amazon.com/cli/latest/reference/s3api/create-bucket.html">https://docs.aws.amazon.com/cli/latest/reference/s3api/create-bucket.html</a></li><li><a href="https://docs.aws.amazon.com/cli/latest/reference/s3api/put-public-access-block.html">https://docs.aws.amazon.com/cli/latest/reference/s3api/put-public-access-block.html</a></li><li><a href="https://docs.aws.amazon.com/cli/latest/reference/dynamodb/create-table.html">https://docs.aws.amazon.com/cli/latest/reference/dynamodb/create-table.html</a></li><li><a href="https://www.terraform.io/docs/backends/types/s3.html">https://www.terraform.io/docs/backends/types/s3.html</a></li></ul>
