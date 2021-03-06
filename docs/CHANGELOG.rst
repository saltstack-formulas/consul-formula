
Changelog
=========

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
