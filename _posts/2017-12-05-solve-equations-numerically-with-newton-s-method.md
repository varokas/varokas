---
layout: post
title: Solve Equations numerically with Newton’s Method
date: '2017-12-05 00:00:00 +0000'
slug: solve-equations-numerically-with-newton-s-method
permalink: "/solve-equations-numerically-with-newton-s-method/"
author: Varokas Panusuwan
tags: []
excerpt: |2

  Trust me I’m an engineer
feature_image: /assets/images/ghost/downloaded_images/Solve-Equations-numerically-with-Newton-s-Method/1--Wy7HN8L9VceP30YqB6yjg-1.png
canonical_url: https://medium.com/@varokas/solving-equations-numerically-with-newtons-method-b3b754ad5393
ghost_id: 5e929aca9c3d50000174a335
visibility: public
---

<h3 id="trust-me-i-m-an-engineer">Trust me I’m an engineer</h3><p>There will be a time when we want to solve equation as part of our program and algebra simply just fails (Or we failed algebra — more likely).</p><h3 id="newton-s-method">Newton’s Method</h3><p>Those times are ideal to whip out good old <a href="https://en.wikipedia.org/wiki/Newton%27s_method">Newton’s Method</a> to provide a good enough answer. It is based on deceptively simple but enormously useful observation that we can get a better answer (X(n+1)) from a previous answer (Xn).</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Solve-Equations-numerically-with-Newton-s-Method/1-bTYLOoTlApfMHbwOO1UTIg.png" class="kg-image" alt loading="lazy"></figure><p>As we progress, next value of X will be closer to the answer and we can stop computing when current X produced f(x) that is closed enough to 0.</p><h3 id="step-1-confirms-the-variable">Step 1: Confirms the Variable</h3><p>The problem we are going to solve is to find <a href="https://finance.zacks.com/irr-annuity-7469.html">Internal Rate of Return with Annuity</a>. Which bears this equation</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Solve-Equations-numerically-with-Newton-s-Method/1-BtsTTdNRyBfsk4JUK-M9wA.png" class="kg-image" alt loading="lazy"></figure><p>Biggest plot twist here is that we want to solve for (r) rather than (PV), so this is not simply “plugging value and it works” business.</p><p>It is quite easy to loose track of what is the variable to solve for. Let’s confirm that there is only a single value to find while others are just given parameters.</p><p>Given the equation above. We want to solve for (r), given all the other values of (PV,PMT,n).</p><h3 id="step-2-rearrange-equation">Step 2 : Rearrange Equation</h3><p>Newton’s Method is specialized to find X that makes f(x) = 0. This is not quite how the equation is right now. Let’s move things around.</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Solve-Equations-numerically-with-Newton-s-Method/1-qZqxzla5Y4H68hTX37s_rA.png" class="kg-image" alt loading="lazy"></figure><p>A Python code for f(r) would be this def. It generates a function that accepts (r) as variable, given (n,PV,PMT) as a fixed parameter.</p><pre><code>def f(n,PV,PMT):
    return lambda r:r * (1 - r**n) / (1 - r) - PV/PMT</code></pre><h3 id="step-2-find-derivative-of-f-x-">Step 2: Find Derivative of f(x)</h3><p>The f’(x) part in Newton’s Method equation is a derivative of f(x). While not particularly hard to work out by hand, it is much simpler and fun to paste whole equation into Wolfram Alpha</p><figure class="kg-card kg-image-card"><img src="/assets/images/ghost/downloaded_images/Solve-Equations-numerically-with-Newton-s-Method/1-SixxoWa632QpwkRQHWBUkA.png" class="kg-image" alt loading="lazy"></figure><p>Again, try not to confuse which one is the variable. In this case we need (d/dr).</p><p>A Python code for f_prime(r) would be this def. It generates a function that accepts (r) as variable, given (n) as a fixed parameter. PV and PMT are not necessary as it is eliminated by derivative. They are left here just for consistency with f(r).</p><pre><code>def f_prime(n,PV,PMT): 
    return lambda r: (n*r**(n + 1) - (n + 1)*r**n + 1)/(1 - r)**2</code></pre><h3 id="step-3-graph-equation-and-slope">Step 3: Graph Equation and Slope</h3><p>To provide better context and sanity check that both equations are correct. This is also helpful in visualizing a good initial estimate.</p><p>Pick a parameter of (n,PV,PMT), graph 2 things</p><ol><li>A graph of f(r)</li><li>A graph of tangent line at a given (x_test). In this case (x_test) = 1.7</li></ol><figure class="kg-card kg-image-card kg-card-hascaption"><img src="/assets/images/ghost/downloaded_images/Solve-Equations-numerically-with-Newton-s-Method/1--Wy7HN8L9VceP30YqB6yjg.png" class="kg-image" alt loading="lazy"><figcaption>For more details in generating this graph, look at the python notebook linked at the end.</figcaption></figure><h3 id="step-4-compute">Step 4: Compute</h3><p>Everything’s set. So let’s code up Newton’s Method itself.</p><pre><code>def solve(f,f_prime,x0,tolerance=1e-4,maxiter=200):
    xn = x0
    for i in range(maxiter):
        #Very close to 0 now
        if abs(f(xn)) &lt; tolerance:
            return xn
        
        xn = xn - f(xn) / f_prime(xn)
        
    raise Exception("Does not converge")</code></pre><p>Now plug in all the hard work to find that precious (r)</p><pre><code>n, PV, PMT = 10,10000,12
x_start = 1.01

solved_r = solve(f(n, PV, PMT), f_prime(n, PV, PMT), x_start)</code></pre><p>And the value of (r) in this case is</p><pre><code>solved_r = 1.8081007002833853</code></pre><p>For those who’s interested in using a standard package can use SciPy (<a href="https://docs.scipy.org/doc/scipy-0.19.1/reference/generated/scipy.optimize.newton.html">scipy.optimize.newton</a>). Note that it will help only with this step. Finding f(r) and f_prime(r) is still a required manual work.</p><h3 id="step-5-check-your-work">Step 5: Check Your Work</h3><p>Good Engineers check their work. That’s also what we are going to do here.</p><p>Here is the PV equation that we started with coded in Python</p><pre><code>def PV(n,r,PMT):
    return PMT * r * (1 - r**n) / (1 - r)</code></pre><p>Plugged in the (solved_r) computed above to get the result that we expected (10,000).</p><pre><code>PV(10, solved_r, 12) # Yields 10000.000000180908</code></pre><h3 id="reference">Reference</h3><p>For those who are curious to see the notebook that generates all the equations and graphs, please see link below.</p><p><a href="https://notebooks.azure.com/varokas/libraries/public/html/newtons-method.ipynb"><strong>Microsoft Azure Notebooks - Online Jupyter Notebooks</strong></a><br><a href="https://notebooks.azure.com/varokas/libraries/public/html/newtons-method.ipynb"><em>Provides free online access to Jupyter notebooks running in the cloud on Microsoft Azure.</em></a><a href="https://notebooks.azure.com/varokas/libraries/public/html/newtons-method.ipynb">notebooks.azure.com</a>

</p>
