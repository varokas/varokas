---
layout: post
title: Secrets in Code with Mozilla SOPS
date: '2020-05-25 07:17:07 +0000'
slug: secrets-in-code-with-mozilla-sops
permalink: "/secrets-in-code-with-mozilla-sops/"
author: Varokas Panusuwan
tags: []
feature_image: https://images.unsplash.com/photo-1564313677573-481bd55237ad?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=2000&fit=max&ixid=eyJhcHBfaWQiOjExNzczfQ
ghost_id: 5ec952942a88f40001aa83d2
visibility: public
---

<p>Secrets presents a challenging dilemma for infrasture-as-a-code. Solution today converge mostly on storing these secrets in some external trusted system (Kube Secrets, Docker Secrets, Build System Secrest, Vault) outside of the code. </p><p>Using SOPS, we can check in the <strong>encrypted</strong> secrets (e.g. connection passwords) along with the code. The only thing out of sight is the encryption key wrapping these passwords. </p><p>The added value also is that SOPS understand structured file (JSON,YAML) and encrypt only values, leaving the keys intact to easily inspect.</p><p><strong>Example – </strong>This file could be checked into github along with the code.</p><pre><code class="language-javascript">{
  "postgres_password": "ENC[AES256_GCM,data:PsyN..,type:str]",
  "aws_access_key": "ENC[AES256_GCM,data:PsyN..,type:str]",
}</code></pre><figure class="kg-card kg-bookmark-card"><a class="kg-bookmark-container" href="https://github.com/mozilla/sops"><div class="kg-bookmark-content"><div class="kg-bookmark-title">mozilla/sops</div><div class="kg-bookmark-description">Simple and flexible tool for managing secrets. Contribute to mozilla/sops development by creating an account on GitHub.</div><div class="kg-bookmark-metadata"><img class="kg-bookmark-icon" src="https://github.githubassets.com/favicons/favicon.svg" alt=""><span class="kg-bookmark-author">GitHub</span><span class="kg-bookmark-publisher">mozilla</span></div></div><div class="kg-bookmark-thumbnail"><img src="https://avatars0.githubusercontent.com/u/131524?s&#x3D;400&amp;v&#x3D;4" alt=""></div></a></figure><h2 id="installation">Installation</h2><h3 id="macos">MacOS </h3><pre><code class="language-bash">$ brew install sops</code></pre><h3 id="windows">Windows</h3><ol><li>Go to the latest release page: <a href="https://github.com/mozilla/sops/releases/latest">https://github.com/mozilla/sops/releases/latest</a></li><li>Download <a href="https://github.com/mozilla/sops/releases/download/v3.5.0/sops-v3.5.0.exe" rel="nofollow">sops-v3.5.0.exe</a> (or whatever the latest version is)</li><li>Rename the file from <a href="https://github.com/mozilla/sops/releases/download/v3.5.0/sops-v3.5.0.exe" rel="nofollow"><code>sops-v3.5.0.exe</code></a> to just <code>sops.exe</code></li><li>Copy the file <code>sops.exe</code> to <code>C:\Windows\System32</code>. </li><li>Or – Alternately, put the file in any directory and set the Path environment variable accordingly</li></ol><h2 id="encryption-key-configuration">Encryption Key Configuration</h2><p>The most important configuration for SOPS is what encryption key to use. In many case this is the only configuration needed.</p><p>Create a <code>.sops.yaml</code> at the root directory of the project with one of the configuration outlined below. </p><p>The key could be any PGP key. Alternately the key could also be provided by a Key Management Service (KMS) in AWS or Google Cloud. A good choice especially if the code eventually would be deployed to these cloud providers. </p><h3 id="aws-kms">AWS KMS</h3><p>A master key can be created in hardware security modules via <a href="https://aws.amazon.com/kms/">AWS Key Management Service (KMS)</a>. We need <code>arn</code> of the key with a corresponding AWS Profile that has a permission to use the key.</p><pre><code class="language-bash">$ aws --profile myprofile configure
AWS Access Key ID [None]: KEY_ID
AWS Secret Access Key [None]: SECRET_ACCESS_KEY

# Create .sops.yaml At project root
$ vi .sops.yaml
creation_rules:
  # If assuming roles for another account use "arn+role_arn".
  # See Advanced usage
  - kms: "arn:aws:kms:..."
    aws_profile: myprofile</code></pre><p>The permission needed for key operations are:</p><pre><code class="language-json">"Action": [
  "kms:Encrypt",
  "kms:Decrypt",
  "kms:ReEncrypt*",
  "kms:GenerateDataKey*",
  "kms:DescribeKey"
],</code></pre><p>For slightly more advanced use cases. We could also access master key from another account using AWS AssumeRole mechanism. This is particularly useful when we have one master key in production, but wanted to also access it from our staging AWS account. See <a href="https://github.com/mozilla/sops#assuming-roles-and-using-kms-in-various-aws-accounts">https://github.com/mozilla/sops#assuming-roles-and-using-kms-in-various-aws-accounts</a></p><h3 id="pgp-optionally-via-keybase-">PGP (optionally via Keybase)</h3><p>For personal use cases, using a PGP key probably suffice. If you are a <a href="https://keybase.io">keybase</a> user, you already have a PGP key. We needed to do the followings</p><ol><li>Install GPG</li><li>Export private keys from Keybase </li><li>Import the keys to local machine</li><li>(optional) Remove passphrase from the key</li><li>Create <code>.sops.yaml</code> at the project</li></ol><pre><code class="language-bash">$ brew install gpg ## or apt install gpg 
$ gpg --import private_key.asc

... (take note of the key ID: 0701C740FB8D24E9)
...
gpg: key 0701C740FB8D24E9: secret key imported
...
...

# This is important for the passphrase screen to show up in console
$ export GPG_TTY=$(tty)
$ gpg --edit-key 0701C740FB8D24E9
gpg&gt; passwd
# 1. Type current passphrase
# 2. Type "" (Blank)
# 3. Type "" (Confirm Blank)

$ vi .sops.yaml
creation_rules:
  - pgp: 0701C740FB8D24E9</code></pre><h3 id="generate-new-gpg-key-and-export-">Generate new GPG Key (And export) </h3><p>Sometimes we want to generate and managed the GPG key without keybase</p><pre><code class="language-bash">$ gpg --full-generate-key

Kind of key : (1) RSA and RSA (default)
keysize: 3072
Key is valid for? : 0 (Do not expire)

Real name: &lt;name&gt;
Email: &lt;email&gt;
Comment: (blank)

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o

Enter Passphrase 2 times (cannot be blank)

public and secret key created and signed.

pub   rsa3072 2020-11-26 [SC]
      3F73E4821B848420CDEAEAD585E2DE2374D6377A  ---&gt; Note this value
uid                      test1 &lt;test1@test2.com&gt;
sub   rsa3072 2020-11-26 [E]

# Remove the passphrase if wanted
# This is important for the passphrase screen to show up in console
$ export GPG_TTY=$(tty)
$ gpg --edit-key 3F73E4821B848420CDEAEAD585E2DE2374D6377A
gpg&gt; passwd
# 1. Type current passphrase
# 2. Type "" (Blank)
# 3. Type "" (Confirm Blank)</code></pre><h2 id="encrypt-decrypt-files">Encrypt / Decrypt files</h2><h3 id="create">Create </h3><p>Create a new file via sops will launch an editor</p><pre><code class="language-bash">$ sops secret.enc.json
{
  "example_key": "example_value",
}</code></pre><p>The resulting json would retain the same keys, with values encrypted. An extra metadata is added as an extra key in JSON</p><pre><code class="language-bash">$ cat secret.enc.json                                                                                            
{
	"example_key": "ENC[AES256_GCM,data:PsyNr6jRJLIPN3P0tA==,iv:Ne63tk8f6uD9GLiHQoyrS/BrK4WL2I6+9Ul8nO6PkDw=,tag:rF8Hm4gm0+xlA3BqKivY7w==,type:str]",
	"sops": {
		...
        ... (metadata here)
	}
}%</code></pre><h3 id="edit">Edit</h3><p>Editing an existing files would launch and editor and encrypt the file.</p><pre><code class="language-bash">$ sops secret.enc.json</code></pre><h3 id="encrypt-decrypt-existing-files">Encrypt / Decrypt Existing Files</h3><pre><code class="language-bash">$ sops -e secret.json &gt; secret.sops.json

$ sops -d secret.sops.json &gt; secret.sops</code></pre><p>⚠️ <strong>Important</strong> - If the PGP key has passphrase, make sure this environment variables is set or you will run into problems </p><pre><code class="language-bash">GPG_TTY=$(tty)</code></pre><figure class="kg-card kg-bookmark-card"><a class="kg-bookmark-container" href="https://github.com/mozilla/sops/issues/304#issuecomment-377195341"><div class="kg-bookmark-content"><div class="kg-bookmark-title">Cannot decrypt with GPG 2.2.5 and SOPS 3.0.0 · Issue #304 · mozilla/sops</div><div class="kg-bookmark-description">It appears the utility is looking for a secret key in a file but my GPG installation (through macOS homebrew) uses the gpg-agent. I cannot decrypt files as demonstrated below. $ sops --version sops...</div><div class="kg-bookmark-metadata"><img class="kg-bookmark-icon" src="https://github.githubassets.com/favicons/favicon.svg" alt=""><span class="kg-bookmark-author">GitHub</span><span class="kg-bookmark-publisher">mozilla</span></div></div><div class="kg-bookmark-thumbnail"><img src="https://avatars0.githubusercontent.com/u/131524?s&#x3D;400&amp;v&#x3D;4" alt=""></div></a></figure><h2 id="integration-recipes">Integration Recipes</h2><p>Many tools provide a plugin to directly read and write encrypted SOPS file. </p><h3 id="terraform">Terraform</h3><p>Download the following provider plugin from github</p><figure class="kg-card kg-bookmark-card"><a class="kg-bookmark-container" href="https://github.com/carlpett/terraform-provider-sops"><div class="kg-bookmark-content"><div class="kg-bookmark-title">carlpett/terraform-provider-sops</div><div class="kg-bookmark-description">A Terraform provider for reading Mozilla sops files - carlpett/terraform-provider-sops</div><div class="kg-bookmark-metadata"><img class="kg-bookmark-icon" src="https://github.githubassets.com/favicons/favicon.svg" alt=""><span class="kg-bookmark-author">GitHub</span><span class="kg-bookmark-publisher">carlpett</span></div></div><div class="kg-bookmark-thumbnail"><img src="https://avatars2.githubusercontent.com/u/214867?s&#x3D;400&amp;v&#x3D;4" alt=""></div></a></figure><pre><code class="language-bash">$ mkdir -p ~/.terraform.d/plugins
$ curl -L -o ~/.terraform.d/plugins/terraform-provider-sops_v0.5.0_darwin_amd64.zip \
"https://github.com/carlpett/terraform-provider-sops/releases/download/v0.5.0/terraform-provider-sops_v0.5.0_darwin_amd64.zip"

$ unzip ~/.terraform.d/plugins/terraform-provider-sops_v0.5.0_darwin_amd64.zip \
-d ~/.terraform.d/plugins

$ terraform init</code></pre><p>Then we could define a <code>data</code> resource that automatically decrypt SOPS json.</p><pre><code class="language-bash">provider "sops" {}

data "sops_file" "secrets" {
  source_file = "secrets.enc.json"
}

## Using
provider "aws" {
  region = "us-west-2"
  access_key = data.sops_file.secrets.data["aws_access_key"]
  secret_key = data.sops_file.secrets.data["aws_secret_key"]
}</code></pre><h3 id="encrypted-private-keys">Encrypted Private Keys</h3><p>SOPs works with any unstrutured files as well. The data will get encoded into a <code>data</code> key in a resulting json automatically.</p><pre><code class="language-bash">$ sops -e private_key &gt; private_key.sops
$ cat private_key.sops
{
  "data": "ENC[AES256_GCM,data:bVr....."
  "sops:: { ... }
}
$ rm private_key</code></pre><p>Using the keys, we could just pipe the decrypted result to <code>ssh-add</code> without writing to file first.</p><pre><code class="language-bash">ssh-add - &lt;&lt;&lt; $(sops -d private_key.sops)</code></pre><h3 id="python-script">Python Script</h3><p>SOPS used to be written in python, but reimplemented in golang. The pip package exists but with many features missing. It is probably better to call it via subprocess.</p><pre><code class="language-python">import subprocess
b = subprocess.check_output(['sops', "-d", "private_key.sops"])</code></pre><h3 id="kubernetes-secrets">Kubernetes Secrets</h3><p>Create a new yaml file, but indicates to SOPs that only <code>data</code> and <code>stringData</code> are keys to encrypt</p><pre><code class="language-bash">$ sops --encrypted-regex '^(data|stringData)$' secrets-mysecret.yaml

apiVersion: v1
kind: Secret
metadata:
    name: mysecret
type: Opaque
stringData:
  mySecret: hello123</code></pre><p>Apply by pipe the decrypted output to K8s</p><pre><code class="language-bash">sops -d secrets-mysecret.yaml | kubectl -n workflow apply -f -</code></pre>
