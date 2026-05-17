---
layout: post
title: Setting up local Spark Cluster
date: '2024-12-01 23:03:54 +0000'
slug: local-spark
permalink: "/local-spark/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/photo-1560841580-413ff7c6f310?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDE3fHxoaXZlfGVufDB8fHx8MTczMzA5MTc5NXww&ixlib=rb-4.0.3&q=80&w=2000
ghost_id: 674ce1bf47e9b800013096ef
visibility: public
---

<p><a href="https://aws.amazon.com/emr/" rel="noreferrer">EMR</a> presents a convenient method for rapidly deploying a cluster. However, we frequently require an ability to explore locally stored data rapidly. This guide walktlhoughts setting up a minimal local spark cluster fit for stated purpose. </p><p>The completed project can be found here.</p><figure class="kg-card kg-bookmark-card"><a class="kg-bookmark-container" href="https://github.com/varokas/spark-demo"><div class="kg-bookmark-content"><div class="kg-bookmark-title">GitHub - varokas/spark-demo</div><div class="kg-bookmark-description">Contribute to varokas/spark-demo development by creating an account on GitHub.</div><div class="kg-bookmark-metadata"><img class="kg-bookmark-icon" src="https://github.githubassets.com/assets/pinned-octocat-093da3e6fa40.svg" alt=""><span class="kg-bookmark-author">GitHub</span><span class="kg-bookmark-publisher">varokas</span></div></div><div class="kg-bookmark-thumbnail"><img src="https://opengraph.githubassets.com/e2b58aeb94941657825eb1bca0a84dbf42ccd7fbbe351286412a361025818326/varokas/spark-demo" alt=""></div></a></figure><ol><li>PySpark</li><li>Jupyter Notebook connecting to Pyspark</li><li>Writing Iceberg Table Locally</li><li>Writing Iceberg Table to AWS (TBD)</li><li>Reading Parquet files from AWS (TBD)</li></ol><h3 id="pyspark">PySpark</h3><p>Install Java and Sparks via <a href="https://sdkman.io" rel="noreferrer">SDK Man</a>. </p><pre><code class="language-bash">$ curl -s "https://get.sdkman.io" | bash

$ sdk install java 17.0.13-zulu
$ sdk install spark 3.5.3

# Uses (sdk list java) OR (sdk list sparks) to see all available version</code></pre><p>Install UV </p><pre><code># On macOS and Linux.
curl -LsSf https://astral.sh/uv/install.sh | sh</code></pre><h3 id="jupyter-notebook">Jupyter Notebook</h3><p>Using uv to setup the project and add libraries</p><pre><code>$ uv init 
$ uv add pyspark jupyterlab</code></pre><p>Then we can run bringup the notebook using this command </p><pre><code>$ uv run jupyter lab
</code></pre><p>Minimally we can connect to by creating Sparksession using </p><pre><code class="language-python">from pyspark.sql import SparkSession

spark = SparkSession.builder \
      .master("local[*]") \
      .appName("spark-demo") \
      .config(map={
         ## Configuration goes here
      }) \
      .getOrCreate()</code></pre><p>Starting spark this way would create a WebUI at 4040. we can inspect this address by evaluating </p><pre><code class="language-`spark.sparkContext.uiWebUrl`.">spark.sparkContext.uiWebUrl</code></pre><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2024/12/Screenshot-2024-12-02-at-5.47.31-AM.png" class="kg-image" alt="" loading="lazy" width="2000" height="1079" srcset="/assets/images/ghost/size/w600/2024/12/Screenshot-2024-12-02-at-5.47.31-AM.png 600w, /assets/images/ghost/size/w1000/2024/12/Screenshot-2024-12-02-at-5.47.31-AM.png 1000w, /assets/images/ghost/size/w1600/2024/12/Screenshot-2024-12-02-at-5.47.31-AM.png 1600w, /assets/images/ghost/2024/12/Screenshot-2024-12-02-at-5.47.31-AM.png 2000w" sizes="(min-width: 720px) 720px"></figure><h3 id="local-iceberg-table">Local Iceberg Table</h3><p>For a short experimentation with Local Iceberg table, we can configure sparks to store metadata in a local file. The example below shows how we could setup a catalog named <code>local</code> , where the data files are stored at <code>$PWD/warehouse</code></p><pre><code class="language-python">import os
cwd = os.getcwd()

spark = SparkSession.builder \
      .master("local[*]") \
      .appName("spark-demo") \
      .config(map={
          "spark.jars.packages": "org.apache.iceberg:iceberg-spark-runtime-3.5_2.12:1.7.0",          
          "spark.sql.extensions": "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions",

          "spark.sql.catalog.local": "org.apache.iceberg.spark.SparkSessionCatalog",
          "spark.sql.catalog.local.type": "hive",
          "spark.sql.catalog.local": "org.apache.iceberg.spark.SparkCatalog",
          "spark.sql.catalog.local.type": "hadoop",
          "spark.sql.catalog.local.warehouse": f"{cwd}/warehouse",
      }) \
      .getOrCreate()</code></pre><p>after  setting up spark session, we can create and use the iceberg tables from pyspark. </p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2024/12/Screenshot-2024-12-02-at-5.56.05-AM.png" class="kg-image" alt="" loading="lazy" width="1826" height="1150" srcset="/assets/images/ghost/size/w600/2024/12/Screenshot-2024-12-02-at-5.56.05-AM.png 600w, /assets/images/ghost/size/w1000/2024/12/Screenshot-2024-12-02-at-5.56.05-AM.png 1000w, /assets/images/ghost/size/w1600/2024/12/Screenshot-2024-12-02-at-5.56.05-AM.png 1600w, /assets/images/ghost/2024/12/Screenshot-2024-12-02-at-5.56.05-AM.png 1826w" sizes="(min-width: 720px) 720px"></figure><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2024/12/Screenshot-2024-12-02-at-5.56.15-AM.png" class="kg-image" alt="" loading="lazy" width="1848" height="554" srcset="/assets/images/ghost/size/w600/2024/12/Screenshot-2024-12-02-at-5.56.15-AM.png 600w, /assets/images/ghost/size/w1000/2024/12/Screenshot-2024-12-02-at-5.56.15-AM.png 1000w, /assets/images/ghost/size/w1600/2024/12/Screenshot-2024-12-02-at-5.56.15-AM.png 1600w, /assets/images/ghost/2024/12/Screenshot-2024-12-02-at-5.56.15-AM.png 1848w" sizes="(min-width: 720px) 720px"></figure><p>Data will be written to designated directory</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/2024/12/Screenshot-2024-12-02-at-5.59.23-AM.png" class="kg-image" alt="" loading="lazy" width="2000" height="1062" srcset="/assets/images/ghost/size/w600/2024/12/Screenshot-2024-12-02-at-5.59.23-AM.png 600w, /assets/images/ghost/size/w1000/2024/12/Screenshot-2024-12-02-at-5.59.23-AM.png 1000w, /assets/images/ghost/size/w1600/2024/12/Screenshot-2024-12-02-at-5.59.23-AM.png 1600w, /assets/images/ghost/2024/12/Screenshot-2024-12-02-at-5.59.23-AM.png 2064w" sizes="(min-width: 720px) 720px"></figure>
