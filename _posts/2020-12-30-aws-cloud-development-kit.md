---
layout: post
title: Define AWS Infrastructure in Python with AWS Cloud Development Kit
date: '2020-12-30 09:59:15 +0000'
slug: aws-cloud-development-kit
permalink: "/aws-cloud-development-kit/"
author: Varokas Panusuwan
tags: []
feature_image: /assets/images/ghost/2020/12/AppStacks.png
ghost_id: 5fd5f9f42a88f40001aa86bc
visibility: public
---

<p>With <a href="https://aws.amazon.com/cdk/">AWS CDK</a>, we can define an infrastructure using familiar languages (Python, JS, Java, etc) . The code will be compiled into a cloud formation JSON and deployed as a cloud formation stack. Later we can diff the changes made before redeploy. </p><h3 id="install">Install</h3><pre><code class="language-bash">brew install node
npm install -g aws-cdk    </code></pre><h3 id="initialize">Initialize</h3><pre><code class="language-bash">cdk init app --language python

python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt

pip install aws-cdk.aws-s3 # module to manage s3</code></pre><h3 id="define">Define</h3><p>Edit <code>{project_name}/{project_name}_stack.py</code> </p><pre><code class="language-python">from aws_cdk import core
from aws_cdk import aws_s3 as s3


class FnInfraStack(core.Stack):

    def __init__(self, scope: core.Construct, construct_id: str, **kwargs) -&gt; None:
        super().__init__(scope, construct_id, **kwargs)

        s3.bucket(self, "TestingBucketVarokas", versioned=True, )</code></pre><p>Preview the cloud formation template with </p><pre><code class="language-bash">cdk synth</code></pre><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2020/12/Screen-Shot-2020-12-29-at-11.52.22-AM.png" class="kg-image" alt loading="lazy"></figure><h3 id="deploy">Deploy</h3><p>We can then immediately deploy the changes as CloudFormation stack</p><pre><code class="language-bash">cdk --profile varokas deploy</code></pre><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2020/12/Screen-Shot-2020-12-29-at-11.57.59-AM.png" class="kg-image" alt loading="lazy"></figure><h3 id="changes-and-diffs">Changes and Diffs</h3><p>Any changes to the code can be diff-ed against currently deployed stack</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2020/12/Screen-Shot-2020-12-29-at-12.05.21-PM.png" class="kg-image" alt loading="lazy"></figure><h3 id="limitations">Limitations</h3><p>There isn't a way to import existing AWS resources to CDK yet</p><figure class="kg-card kg-bookmark-card"><a class="kg-bookmark-container" href="https://github.com/aws/aws-cdk-rfcs/issues/84"><div class="kg-bookmark-content"><div class="kg-bookmark-title">Support importing existing resources into a stack · Issue #84 · aws/aws-cdk-rfcs</div><div class="kg-bookmark-description">Importing existing resources into a CloudFormation stack is now supported! 🎉 The CDK should provide a elegant way to support this. https://aws.amazon.com/blogs/aws/new-import-existing-resources-int...</div><div class="kg-bookmark-metadata"><img class="kg-bookmark-icon" src="https://github.githubassets.com/favicons/favicon.svg" alt=""><span class="kg-bookmark-author">GitHub</span><span class="kg-bookmark-publisher">aws</span></div></div><div class="kg-bookmark-thumbnail"><img src="https://avatars2.githubusercontent.com/u/2232217?s&#x3D;400&amp;v&#x3D;4" alt=""></div></a></figure><p>A workaround exist by creating a failed CloudFormation deployment and fix the template.</p><figure class="kg-card kg-bookmark-card"><a class="kg-bookmark-container" href="https://medium.com/@visya/how-to-import-existing-aws-resources-into-cdk-stack-f1cea491e9"><div class="kg-bookmark-content"><div class="kg-bookmark-title">How to import existing AWS resources into CDK stack</div><div class="kg-bookmark-description">If you are not creating your account from scratch at the same time when you’re starting to work with CDK, you might need to import existing resources to CDK stack to be able to manage them. This is…</div><div class="kg-bookmark-metadata"><img class="kg-bookmark-icon" src="https://miro.medium.com/fit/c/152/152/1*sHhtYhaCe2Uc3IU0IgKwIQ.png" alt=""><span class="kg-bookmark-author">Medium</span><span class="kg-bookmark-publisher">Maria Verbenko</span></div></div><div class="kg-bookmark-thumbnail"><img src="https://miro.medium.com/max/1200/1*3GcFKUaw0AOPc22SI-BDSg.png" alt=""></div></a></figure><p> </p><h3 id="references">References</h3><figure class="kg-card kg-bookmark-card"><a class="kg-bookmark-container" href="https://docs.aws.amazon.com/cdk/latest/guide/getting_started.html"><div class="kg-bookmark-content"><div class="kg-bookmark-title">Getting started with the AWS CDK - AWS Cloud Development Kit (AWS CDK)</div><div class="kg-bookmark-description">This topic introduces you to important AWS CDK concepts and describes how to install and configure the AWS CDK.</div><div class="kg-bookmark-metadata"><img class="kg-bookmark-icon" src="https://docs.aws.amazon.com/assets/images/favicon.ico" alt=""><span class="kg-bookmark-author">AWS Cloud Development Kit (AWS CDK)</span></div></div></a></figure><p></p>
