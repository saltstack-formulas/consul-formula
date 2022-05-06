
Changelog
=========

`1.2.0 <https://github.com/saltstack-formulas/consul-formula/compare/v1.1.1...v1.2.0>`_ (2022-05-06)
--------------------------------------------------------------------------------------------------------

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gemfile.lock:** fix erroneous indentation (\ `84e5f14 <https://github.com/saltstack-formulas/consul-formula/commit/84e5f1416bf8b2861824f8cd3bb1b49b2cd228dc>`_\ )

Features
^^^^^^^^


* **freebsd:** add ``FreeBSD`` support (\ `c49d33b <https://github.com/saltstack-formulas/consul-formula/commit/c49d33b921275297d101f9fbaf1e79de6c029842>`_\ )

Tests
^^^^^


* **freebsd:** add ``kitchen`` ``FreeBSD`` recipes and ``github`` workflow (\ `09f60fd <https://github.com/saltstack-formulas/consul-formula/commit/09f60fd11c8a8cd300bdc7e47311ddcb4e165fed>`_\ )

`1.1.1 <https://github.com/saltstack-formulas/consul-formula/compare/v1.1.0...v1.1.1>`_ (2022-05-05)
--------------------------------------------------------------------------------------------------------

Code Refactoring
^^^^^^^^^^^^^^^^


* use of ``mapdata`` and ``libtofs`` (\ `c287bdc <https://github.com/saltstack-formulas/consul-formula/commit/c287bdcf77a409426b4e44a1e5d47611fceb6622>`_\ )

`1.1.0 <https://github.com/saltstack-formulas/consul-formula/compare/v1.0.2...v1.1.0>`_ (2022-04-27)
--------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **map:** update to v5 ``map.jinja`` (\ `2968032 <https://github.com/saltstack-formulas/consul-formula/commit/296803292e6f20e276ae0bddf679a17d541f8c18>`_\ )

Tests
^^^^^


* **_mapdata:** fix ``CentOS 8`` name in integration file [skip ci] (\ `a8fe75a <https://github.com/saltstack-formulas/consul-formula/commit/a8fe75a9d8c61be612df1ba21b2ad8a5e8d4e3c6>`_\ )

`1.0.2 <https://github.com/saltstack-formulas/consul-formula/compare/v1.0.1...v1.0.2>`_ (2022-04-25)
--------------------------------------------------------------------------------------------------------

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen+gitlab:** update for new pre-salted images [skip ci] (\ `897ba26 <https://github.com/saltstack-formulas/consul-formula/commit/897ba268a1afb35b1cdee8e5703b068a8ae9dd86>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** add correct description [skip ci] (\ `5563e25 <https://github.com/saltstack-formulas/consul-formula/commit/5563e25b9d9a81f09f755c80a537bb970ffceef5>`_\ )

Tests
^^^^^


* **map:** verify ``map.jinja`` dump using ``_mapdata`` state (\ `2043908 <https://github.com/saltstack-formulas/consul-formula/commit/204390868fe20e60db95021bb331ddfdb68dc758>`_\ )
* **system:** add ``build_platform_codename`` [skip ci] (\ `2d97668 <https://github.com/saltstack-formulas/consul-formula/commit/2d976680c1840093cbe8dead04886415f53230e6>`_\ )

`1.0.1 <https://github.com/saltstack-formulas/consul-formula/compare/v1.0.0...v1.0.1>`_ (2022-02-12)
--------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **install:** use correct ``unzip`` package name for ``Gentoo`` (\ `a8ee3ae <https://github.com/saltstack-formulas/consul-formula/commit/a8ee3aed313f65d7a03c4112c6f4f75709830727>`_\ )

Code Refactoring
^^^^^^^^^^^^^^^^


* **salt-lint:** fix violations (\ `bf73fca <https://github.com/saltstack-formulas/consul-formula/commit/bf73fca44b41f00c86d3151a74c36e8040103930>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* update linters to latest versions [skip ci] (\ `53f6d33 <https://github.com/saltstack-formulas/consul-formula/commit/53f6d33c06e31e14daf6e3be314e497a6709c8f4>`_\ )
* **3003.1:** update inc. AlmaLinux, Rocky & ``rst-lint`` [skip ci] (\ `100f869 <https://github.com/saltstack-formulas/consul-formula/commit/100f869279a779bcc8879f96598e619a7456c01b>`_\ )
* **commitlint:** ensure ``upstream/master`` uses main repo URL [skip ci] (\ `c0fc41f <https://github.com/saltstack-formulas/consul-formula/commit/c0fc41f79bcb9d808e9256b847380d99b83e2ba0>`_\ )
* **gemfile:** allow rubygems proxy to be provided as an env var [skip ci] (\ `ae4f178 <https://github.com/saltstack-formulas/consul-formula/commit/ae4f17808ae8e2deb4e931c74b6f02d18613c994>`_\ )
* **gemfile+lock:** use ``ssf`` customised ``inspec`` repo [skip ci] (\ `4538659 <https://github.com/saltstack-formulas/consul-formula/commit/4538659d97351dba8f3f1e59895aaaca083af47c>`_\ )
* **gemfile+lock:** use ``ssf`` customised ``kitchen-docker`` repo [skip ci] (\ `1b8393c <https://github.com/saltstack-formulas/consul-formula/commit/1b8393cfb53c6a3598dee1e0b40c56506abab1cd>`_\ )
* **gitlab-ci:** add ``rubocop`` linter (with ``allow_failure``\ ) [skip ci] (\ `fddea73 <https://github.com/saltstack-formulas/consul-formula/commit/fddea731fee9cea4d5fcc9343467156c74b468ed>`_\ )
* **gitlab-ci:** use GitLab CI as Travis CI replacement (\ `f58d76f <https://github.com/saltstack-formulas/consul-formula/commit/f58d76f5565be12433d078e26080c0e209dc70a8>`_\ )
* **kitchen:** move ``provisioner`` block & update ``run_command`` [skip ci] (\ `ae1833c <https://github.com/saltstack-formulas/consul-formula/commit/ae1833c43c61928fc4e13d5d73279b2cb7f4833e>`_\ )
* **kitchen+ci:** update with ``3004`` pre-salted images/boxes [skip ci] (\ `f9bc278 <https://github.com/saltstack-formulas/consul-formula/commit/f9bc278ea1fb415b54477f0ff3dd0db0cc212652>`_\ )
* **kitchen+ci:** update with latest ``3003.2`` pre-salted images [skip ci] (\ `fc1ed54 <https://github.com/saltstack-formulas/consul-formula/commit/fc1ed5464beac4245fd453c555a5962bcfc96d17>`_\ )
* **kitchen+ci:** update with latest CVE pre-salted images [skip ci] (\ `6988c3f <https://github.com/saltstack-formulas/consul-formula/commit/6988c3f0304c55ea50ba24f1592627f6e5a1faec>`_\ )
* **kitchen+ci:** use latest pre-salted images (after CVE) [skip ci] (\ `1b036c3 <https://github.com/saltstack-formulas/consul-formula/commit/1b036c349cd621828c656f1add3e2d8998ff390a>`_\ )
* **kitchen+gitlab:** adjust matrix to add ``3003`` [skip ci] (\ `80037f8 <https://github.com/saltstack-formulas/consul-formula/commit/80037f87cfdea32c62e3c50c60c3825f17358de1>`_\ )
* **kitchen+gitlab:** remove Ubuntu 16.04 & Fedora 32 (EOL) [skip ci] (\ `33bfe13 <https://github.com/saltstack-formulas/consul-formula/commit/33bfe1392547b49e0b55dedef3d0c099a64c43ea>`_\ )
* **kitchen+gitlab:** update for new pre-salted images [skip ci] (\ `0ab6348 <https://github.com/saltstack-formulas/consul-formula/commit/0ab6348571235fcf65ad3c922d948848905628ba>`_\ )
* add ``arch-master`` to matrix and update ``.travis.yml`` [skip ci] (\ `d7f0250 <https://github.com/saltstack-formulas/consul-formula/commit/d7f02505f3f4d172fcc4c78d825f10cfc8edbb28>`_\ )
* add Debian 11 Bullseye & update ``yamllint`` configuration [skip ci] (\ `6790314 <https://github.com/saltstack-formulas/consul-formula/commit/67903143f6daa76622faaa8d024ee42c87656a09>`_\ )
* **kitchen+gitlab-ci:** use latest pre-salted images [skip ci] (\ `95978ee <https://github.com/saltstack-formulas/consul-formula/commit/95978ee1954a8212ef3c7985e6b49f7c038c112d>`_\ )
* **pre-commit:** update hook for ``rubocop`` [skip ci] (\ `c518638 <https://github.com/saltstack-formulas/consul-formula/commit/c51863804186f5a9019918a31175a2f1a1ba6d42>`_\ )

Tests
^^^^^


* standardise use of ``share`` suite & ``_mapdata`` state [skip ci] (\ `13db8f4 <https://github.com/saltstack-formulas/consul-formula/commit/13db8f4f61147c427a0761838cec9f7aa7257731>`_\ )

`1.0.0 <https://github.com/saltstack-formulas/consul-formula/compare/v0.13.0...v1.0.0>`_ (2020-12-13)
---------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* replace deprecated ui option with ui_config (\ `3830ade <https://github.com/saltstack-formulas/consul-formula/commit/3830ade3398b42c0053f5b094497d461eed836e2>`_\ )

BREAKING CHANGES
^^^^^^^^^^^^^^^^


* This cannot be updated in a non-breaking fashion, but
  the least disruptive route was chosen.
* If both ``ui`` and ``ui_config.enabled`` are set,
  ``ui_config`` takes precedence.  Hence, the change may enable the UI on
  machines which had previously set ``ui`` to false. This is arguably better
  than defaulting to ``false``\ , which would disable the UI where it is
  supposed to be enabled.
* Removing the option entirely breaks similarly if users
  rely on the formula defaults, since Consul's default is ``false`` and the
  formula's default used to be ``true``.
* The only other way to break less would be to set both
  options, but then users would also have override both (which is not
  obvious and very annoying) and there would still be no way forward to
  when Consul actually removes the deprecated option.

`0.13.0 <https://github.com/saltstack-formulas/consul-formula/compare/v0.12.0...v0.13.0>`_ (2020-12-13)
-----------------------------------------------------------------------------------------------------------

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gemfile.lock:** add to repo with updated ``Gemfile`` [skip ci] (\ `cdf1565 <https://github.com/saltstack-formulas/consul-formula/commit/cdf15658c1a8068a72f2110ede5219c4b4953677>`_\ )
* **kitchen:** use ``saltimages`` Docker Hub where available [skip ci] (\ `0525720 <https://github.com/saltstack-formulas/consul-formula/commit/0525720080bfd4fe89e1a84729e31e4055e92b95>`_\ )
* **kitchen+travis:** add new platforms [skip ci] (\ `e0e19d5 <https://github.com/saltstack-formulas/consul-formula/commit/e0e19d5ea05a029627b0f3aa3516bf9e9b480de3>`_\ )
* **kitchen+travis:** adjust matrix to add ``3000.2`` & remove ``2018.3`` [skip ci] (\ `5379660 <https://github.com/saltstack-formulas/consul-formula/commit/537966061de97cd2ea875fa3986b22e78ac17109>`_\ )
* **kitchen+travis:** adjust matrix to add ``3000.3`` [skip ci] (\ `2d02fdf <https://github.com/saltstack-formulas/consul-formula/commit/2d02fdfdc1725d3f8ef04e2228b8f5965254e69c>`_\ )
* **kitchen+travis:** adjust matrix to update ``3000`` to ``3000.1`` (\ `d36521c <https://github.com/saltstack-formulas/consul-formula/commit/d36521c262801a6e292b86e783d0d415090e3fa2>`_\ )
* **kitchen+travis:** remove ``master-py2-arch-base-latest`` [skip ci] (\ `f61fd0f <https://github.com/saltstack-formulas/consul-formula/commit/f61fd0f0893d9a0e5cf3ef55155d464c0c40a9bd>`_\ )
* **pre-commit:** add to formula [skip ci] (\ `b587c20 <https://github.com/saltstack-formulas/consul-formula/commit/b587c20dc91dd5fab36bfe06df27db5812b86288>`_\ )
* **pre-commit:** enable/disable ``rstcheck`` as relevant [skip ci] (\ `1911fa8 <https://github.com/saltstack-formulas/consul-formula/commit/1911fa869a3943a33bfa06519e3844cd99b38936>`_\ )
* **pre-commit:** finalise ``rstcheck`` configuration [skip ci] (\ `3bd7a05 <https://github.com/saltstack-formulas/consul-formula/commit/3bd7a05d0b4e0b75af82115be2d1789e3c1887f1>`_\ )
* **travis:** add notifications => zulip [skip ci] (\ `785955c <https://github.com/saltstack-formulas/consul-formula/commit/785955c10b5e2945ef0aba10742d7a498b5467c3>`_\ )
* **workflows/commitlint:** add to repo [skip ci] (\ `2a7adf5 <https://github.com/saltstack-formulas/consul-formula/commit/2a7adf5847dcbb227edf2fb20997755190aa10cf>`_\ )

Features
^^^^^^^^


* **gitlab-ci:** use GitLab CI as Travis CI replacement (\ `99639ee <https://github.com/saltstack-formulas/consul-formula/commit/99639ee6027efd02c77bc3e170acf29dadbe08e8>`_\ )

`0.12.0 <https://github.com/saltstack-formulas/consul-formula/compare/v0.11.2...v0.12.0>`_ (2020-03-26)
-----------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **semantic-release:** implement for this formula (\ `ec8f6c9 <https://github.com/saltstack-formulas/consul-formula/commit/ec8f6c92aa91d2714287b640f5210ff62e063ade>`_\ )
