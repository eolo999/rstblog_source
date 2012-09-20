public: yes
tags: [blog, rstblog, python, github]
summary: |
  How to deploy a static blog on your github personal page

mitsuhiko's *rstblog* on Github
===============================

Introduction
------------

Why I choose a static blog generator? Because I don't feel like doing things
more complicate than they really are: do you prefer a web application full of
relational database, queries, models, etc. just to write two lines every now
and then? I am sure not.

And, how much is it nice to deploy your blog on Github itself?

Looking for a static generator with the sole prerequisite of being implemented
in Python I run into **rstblog** by Armin Ronacher aka **mitsuhiko**.
Personally I deeply appreciate everything that he did and does: clean,
essential and robust. 

In particular I am a big fan of `Flask <http://flask.pocoo.org>`_ which I used
for the most various needs: from continuous integration and deployment
applications to some personal sites (a chess one, an RSS aggregator API server,
etc.)

In short, I had no doubts and decided to go ahead with **rstblog** which I
found as usual both useful and elegant.

This post, apart from helping other people to give **rstblog** a try, serves
the purpose to inaugurate my shiny new blog.

I hope you'll find it useful.

Step 1: Create your personal github page
----------------------------------------

Head your browser to https://github.com, login and click on the **New
Repository** button.

Name your repo exactly following this pattern::

    <your_github_username>.github.com

..

More detailed informations on `Github Pages
<https://help.github.com/categories/20/articles>`_.

Step 2: Install rstblog in a virtualenv
---------------------------------------

Clone the rstblog repository::

    git clone https://github.com/mitsuhiko/rstblog.git

..

Create a new Python virtual environment with
`virtualenv <http://pypi.python.org/pypi/virtualenv>`_ or as I am doing here with
`virtualenvwrapper <http://www.doughellmann.com/projects/virtualenvwrapper/>`_::

    mkvirtualenv rstblog
    cd rstblog
    pip install .
    pip install pygments

..

Step 3: Create your blog
------------------------

Create a directory tree for your blog::

    cd ~
    mkdir -p github_blog/{static,_templates,2012}
    cd github_blog

..

Create a new ``config.yml`` file and fill it like this:

.. code:: yaml

    active_modules: [pygments, tags, blog]
    author: Name Surname
    canonical_url: http://your_github_username.github.com/
    feed:
      name: My Blog or whatever
      subtitle: whatever you want
    modules:
      pygments:
        style: tango

..

.. DANGER::

   Pay attention to the indentation: no tabs and every level MUST be indented
   by 2 spaces.

Copy and edit default templates from rstblog's repository::

    cp -r <path_to_rstblog>/rstblog/templates/* _templates/

..

Create ``_templates/layout.html`` and edit:

.. code:: jinja

    <html>
      <head>
        <meta charset=utf-8>
      {% block htmlhead %}
        <title>{% block title %}Home{% endblock %} | Your Name or Whatever</title>
        <link rel="stylesheet" href="/static/style.css" type="text/css">
        <link href="/feed.atom" rel="alternate"
            title="Your atom feed title" type="application/atom+xml">
        {%- for link in links %}
        <link rel="{{ link.rel }}" href="{{ link.href }}"{%
          if link.media %} media="{{ link.media }}"{% endif %} type="{{ link.type }}">
        {%- endfor %}
      {% endblock %}
      </head>
      <body>
        <div class=container>
          <div class=header>
            <a href="/about/">Your Name or Whatever</a>'s Blog
          </div>
          <div class=navigation>
            <ul>
              <li><a href="/">blog</a>
              <li><a href="/archive/">archive</a>
              <li><a href="/tags/">tags</a>
              <li><a href="/about/">about</a>
            </ul>
          </div>
          <div class=body>
          {% block body %}{% endblock %}
          </div>
          <div class=footer>
            <p>&copy; Copyright {{ format_date(format='YYYY') }} by Your Name.
            <p>
              Content licensed under the Creative Commons
              attribution-noncommercial-sharealike License.
            <p>
              Contact me via <a href="mailto:rstblog@example.com">mail</a>,
              <a href="http://twitter.com/username">twitter</a>,
              <a href="http://github.com/username">github</a> or
              <a href="http://bitbucket.org/username">bitbucket</a>.
            (<a href="/feed.atom" rel="alternate" title="Your atom feed title">feed</a>)
          </div>
        </div>
      </body>
    </html>

..

This is the layout of **mitsuhiko** himself at http://lucumr.pocoo.org and I am
using it so that you understand which are the variables passed to the template
engine.

Step 4: Create your first post
------------------------------

Rstblog will automatically set up dates according to the directory structure;
so create folders like this::

    # today is 2012-09-19 so:
    mkdir -p 2012/9/19

..

Create and edit your first blog post ``2012/9/19/my_first_post.rst`` using
`restructured text
<http://docutils.sourceforge.net/docs/user/rst/quickref.html>`_ syntax::

    public: yes
    tags: [whatever, ever, never]
    summary: |
      This is my first blog post

    My First Blog post
    ==================

    text here

    A section
    ---------

    again text

..

And then create and edit ``about.rst`` talking about you::

    public: yes

    About me
    ========

    blah blah blha

..

Build::

    run-rstblog build

..

and run to see the results::

    run-rstblog serve

..

Mmmh, not nice. Obviously you should create a CSS file ;) The layout looks for
``static/syle.css``.

Step 5: Push to github
----------------------

Create a new repo in your blog's ``_build`` folder::

    cd _build
    git init
    git add .
    git commit -m "Initial Commit"

..

Add github's remote as origin and push::

    git remote add origin git@github.com:<github_username>/<github_username>.github.com.git
    git push -u origin master

..

Done! But...

You'll want to put the blog source under version control too.

Create a new repository on github and::

    cd <your_blog_source_folder>
    echo "_build/" >> .gitignore
    git init 
    git add .
    git commit -m "Initial Commit"
    git remote add origin git@github.com:<github_username>/<blog_source_repo>.git
    git push -u origin master

..

Finally you can create a ``Makefile``::

    
    all: clean build serve

    run: build serve

    clean:
            rm -rf _build/*

    build:
            run-rstblog build

    serve:
            run-rstblog serve

..

.. DANGER::
    Pay attention to the indentation: in this case there must be no spaces but
    just tabs.

Conclusion
----------

I hope you have your blog up and running and that I didn't miss some step.
Please send me your feedback and let me know if you deployed your blog
following this simple tutorial.

A big thanks to **mitsuhiko** for another piece of nice and useful software.

