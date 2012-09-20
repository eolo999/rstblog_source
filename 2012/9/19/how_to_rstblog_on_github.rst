public: yes
tags: [blog, rstblog, python, github]
summary: |
  How to deploy a static blog on your github personal page

mitsuhiko's rstblog on Github
=============================

Introduction
------------

To be written

Step 1: Create your personal github page
----------------------------------------

Head your browser to https://github.com, login and click on the **New Repository** button.

Name your repo exactly following this pattern::

    <your_github_username>.github.com

..

More detailed informations on `Github Pages <https://help.github.com/categories/20/articles>`_.

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

Create a new **config.yml** file and fill it like this:

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
  Pay attention to the indentation: no tabs and every level MUST be indented by
  2 spaces.

Copy and edit default templates from rstblog's repository::

    cp -r <path_to_rstblog>/rstblog/templates/* _templates/

..

Create **_templates/layout.html** and edit:

.. sourcecode:: jinja

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

Rstblog will automatically set up dates according to the directory structure; so create folders like this::

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

And then create and edit **about.rst** talking about you::

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

Mmmh. Obviously you should create a CSS file ;) The layout looks for **static/syle.css**.

Step 5: Push to github

Create a new repo in your blog folder::

    git init
    git add .
    git commit -a "Initial Commit"

..

Add github's remote as origin and push::

    git remote add origin git@github.com:your_github_username/your_github_username.github.com.git
    git push -u origin master

..

Done!

Conclusion
----------

To be written
