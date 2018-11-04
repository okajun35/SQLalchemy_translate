Þ                        ì  [   í  7   I  {        ý         ²  $   E  p   j     Û  /   c  ?     W   Ó  ­   +     Ù  ©  õ  _   	    ÿ	  L     )   é       &  °  Ï   ×  °   §    X     w  å   û  N   á     0    @     Ç  f   J     ±     O  »   n  )  *  6   T            -   ¦  K   Ô        Ó   ¶  $       ¯  x   ±  û  *  Z   &   T      À   Ö   e  !  (  ý"  é   &$  \  %     m&  
  î&  Z   ù'     T(   A classical mapping above would define each :func:`.composite` against the existing table:: A group name for this property when marked as deferred. A simple example represents pairs of columns as a ``Point`` object. ``Point`` represents such a pair as ``.x`` and ``.y``:: Composite Column Types In-place changes to an existing composite value are no longer tracked automatically; the functionality is superseded by the :class:`.MutableComposite` class. In-place changes to an existing composite value are not tracked automatically.  Instead, the composite class needs to provide events to its parent object explicitly.   This task is largely automated via the usage of the :class:`.MutableComposite` mixin, which uses events to associate each user-defined composite object with all parent associations. Please see the example in :ref:`mutable_composites`. List of Column objects to be mapped. Optional data dictionary which will be populated into the :attr:`.MapperProperty.info` attribute of this object. Optional data dictionary which will be populated into the :attr:`.MapperProperty.info` attribute of this object.  .. versionadded:: 0.8 Redefining Comparison Operations for Composites Return a composite column-based property for use with a Mapper. See the mapping documentation section :ref:`mapper_composite` for a full usage example. Sets of columns can be associated with a single user-defined datatype. The ORM provides a single attribute which represents the group of columns using the class you provide. The "composite type" class. The "equals" comparison operation by default produces an AND of all corresponding columns equated to one another. This can be changed using the ``comparator_factory`` argument to :func:`.composite`, where we specify a custom :class:`.CompositeProperty.Comparator` class to define existing or new operations. Below we illustrate the "greater than" operator, implementing the same expression that the base "greater than" does:: The :class:`.MapperProperty` returned by :func:`.composite` is the :class:`.CompositeProperty`. The requirements for the custom datatype class are that it have a constructor which accepts positional arguments corresponding to its column format, and also provides a method ``__composite_values__()`` which returns the state of the object as a list or tuple, in order of its column-based attributes. It also should supply adequate ``__eq__()`` and ``__ne__()`` methods which test the equality of two instances. This flag specifically becomes meaningful - previously it was a placeholder. Tracking In-Place Mutations on Composites We can now persist and use ``Vertex`` instances, as well as query for them, using the ``.start`` and ``.end`` attributes against ad-hoc ``Point`` instances: We will create a mapping to a table ``vertices``, which represents two points as ``x1/y1`` and ``x2/y2``. These are created normally as :class:`.Column` objects. Then, the :func:`.composite` function is used to assign new attributes that will represent sets of columns via the ``Point`` class:: When True, the column property is "deferred", meaning that it does not load immediately, and is instead loaded when the attribute is first accessed on an instance.  See also :func:`~sqlalchemy.orm.deferred`. When ``True``, indicates that the "previous" value for a scalar attribute should be loaded when replaced, if not already loaded.  See the same flag on :func:`.column_property`. When ``True``, indicates that the "previous" value for a scalar attribute should be loaded when replaced, if not already loaded.  See the same flag on :func:`.column_property`.  .. versionchanged:: 0.7     This flag specifically becomes meaningful     - previously it was a placeholder. a class which extends :class:`.CompositeProperty.Comparator` which provides custom SQL clause generation for comparison operations. an :class:`.AttributeExtension` instance, or list of extensions, which will be prepended to the list of attribute listeners for the resulting descriptor placed on the class.  **Deprecated.**  Please see :class:`.AttributeEvents`. optional string that will be applied as the doc on the class-bound descriptor. ãã©ã¡ã¼ã¿ Project-Id-Version: PROJECT VERSION
Report-Msgid-Bugs-To: EMAIL@ADDRESS
POT-Creation-Date: 2018-11-04 09:16+0900
PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE
Last-Translator: FULL NAME <EMAIL@ADDRESS>
Language: ja
Language-Team: ja <LL@li.org>
Plural-Forms: nplurals=1; plural=0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.6.0
 ä¸è¨ã®å¤å¸çãªãããã³ã°ã¯ãããããå®ç¾©ãã¾ãï¼funcï¼ `.composite`ã¯æ¢å­ã®ãã¼ãã«ã«å¯¾ãã¦:: éå»¶ããã¦ããã¨ãã¼ã¯ããã¦ããå ´åããã®ãã­ããã£ã¼ã®ã°ã«ã¼ãåã ç°¡åãªä¾ã¯ãåã®ãã¢ã `` Point``ãªãã¸ã§ã¯ãã¨ãã¦è¡¨ç¾ãã¾ãã `` Point``ã¯ `` .x``ã¨ `` .y``ã®ãããªãã¢ãè¡¨ãã¾ã:: ã³ã³ãã¸ããåã®ç¨®é¡ æ¢å­ã®ã³ã³ãã¸ããå¤ã®ã¤ã³ãã¬ã¼ã¹å¤æ´ã¯èªåçã«ã¯è¿½è·¡ããã¾ããããã®æ©è½ã¯ï¼classï¼ `.MutableComposite`ã¯ã©ã¹ã«åã£ã¦ä»£ãããã¾ãã æ¢å­ã®ã³ã³ãã¸ããå¤ã®ã¤ã³ãã¬ã¼ã¹å¤æ´ã¯èªåçã«ã¯è¿½è·¡ããã¾ãããä»£ããã«ãè¤åã¯ã©ã¹ã¯ã¤ãã³ãããã®è¦ªãªãã¸ã§ã¯ãã«æç¤ºçã«æä¾ããå¿è¦ãããã¾ãããã®ã¿ã¹ã¯ã¯ãï¼classï¼ `.MutableComposite` mixinã®ä½¿ç¨ã«ãã£ã¦å¤§é¨åãèªååããã¾ããmixinã¯ãã¤ãã³ããä½¿ç¨ãã¦åã¦ã¼ã¶ã¼å®ç¾©ã³ã³ãã¸ãããªãã¸ã§ã¯ãããã¹ã¦ã®è¦ªã®é¢é£ä»ãã«é¢é£ä»ãã¾ãã ï¼refï¼ `mutable_composites`ã®ä¾ãè¦ã¦ãã ããã ããããããåãªãã¸ã§ã¯ãã®ãªã¹ãã ãã®ãªãã¸ã§ã¯ãã®ï¼attrï¼ `.MapperProperty.info`å±æ§ã«èª­ã¿è¾¼ã¾ãããªãã·ã§ã³ã®ãã¼ã¿è¾æ¸ã§ãã ãã®ãªãã¸ã§ã¯ãã®ï¼attrï¼ `.MapperProperty.info`å±æ§ã«èª­ã¿è¾¼ã¾ãããªãã·ã§ã³ã®ãã¼ã¿è¾æ¸ã§ãã .. versionadded :: 0.8 ã³ã³ãã¸ããã®æ¯è¼æä½ã®åå®ç¾© Mapperã§ä½¿ç¨ããè¤ååãã¼ã¹ã®ãã­ããã£ãè¿ãã¾ãã å®å¨ãªä½¿ç¨ä¾ã«ã¤ãã¦ã¯ããããã³ã°ãã­ã¥ã¡ã³ãã¼ã·ã§ã³ã®sectionï¼refï¼ `mapper_composite`ãåç§ãã¦ãã ããã åã®ã»ããã¯ãåä¸ã®ã¦ã¼ã¶ã¼å®ç¾©ãã¼ã¿åã«é¢é£ä»ãããã¨ãã§ãã¾ãã ORMã¯ãæä¾ããã¯ã©ã¹ãä½¿ç¨ãã¦åã®ã°ã«ã¼ããè¡¨ãåä¸ã®å±æ§ãæä¾ãã¾ãã \ &quot;è¤åå\&quot;ã¯ã©ã¹ã \ &quot;equals \&quot;æ¯è¼æ¼ç®ã¯ãããã©ã«ãã§ã¯ãå¯¾å¿ãããã¹ã¦ã®åã®è«çç©ãçæãã¾ããããã¯ï¼funcï¼ `.composite`ã®` `comparator_factory``å¼æ°ãä½¿ã£ã¦å¤æ´ã§ãã¾ããããã§ã¯ãcustomï¼classï¼` .CompositeProperty.Comparator`ã¯ã©ã¹ãæå®ãã¦ãæ¢å­ã®æä½ãæ°ããæä½ãå®ç¾©ãã¾ããä»¥ä¸ã§ã¯ã\ &quot;ããå¤§ãã\&quot;æ¼ç®å­ãç¤ºãã¦ããããã¼ã¹\ &quot;ããå¤§ãã\ã¨åãå¼ãå®è£ãã¦ãã¾ãï¼ ï¼funcï¼ `.composite`ã«ãã£ã¦è¿ãããï¼classï¼` .MapperProperty`ã¯ï¼classï¼ `.CompositeProperty`ã§ãã ã«ã¹ã¿ã ãã¼ã¿åã¯ã©ã¹ã®è¦ä»¶ã¯ãåãã©ã¼ãããã«å¯¾å¿ããä½ç½®å¼æ°ãåãå¥ããã³ã³ã¹ãã©ã¯ã¿ãæã¡ããªãã¸ã§ã¯ãã®ç¶æããªã¹ãã¾ãã¯ã¿ãã«ã¨ãã¦é çªã«è¿ãã¡ã½ãã__composite_values __ï¼ï¼ãæä¾ãããã¨ã§ãåãã¼ã¹ã®å±æ§ã®ãã¡ã®1ã¤ã§ããã¾ãã2ã¤ã®ã¤ã³ã¹ã¿ã³ã¹ã®ç­ä¾¡æ§ããã¹ãããé©åãª `` __eq __ï¼ï¼ ``ã¨ `` __ne __ï¼ï¼ ``ã¡ã½ãããæä¾ããå¿è¦ãããã¾ãã ãã®ãã©ã°ã¯ç¹ã«æå³ãããã¾ããä»¥åã¯ãã¬ã¼ã¹ãã«ãã§ããã ã³ã³ãã¸ããã®ã¤ã³ãã¬ã¼ã¹ã»ãã¥ã¼ããã¯ã¹ã®ãã©ãã­ã³ã° ã¢ãããã¯ãª `` Point``ã¤ã³ã¹ã¿ã³ã¹ã«å¯¾ãã¦ `` .start``ã¨ `` .end``å±æ§ãä½¿ç¨ãã¦ã `` Vertex``ã¤ã³ã¹ã¿ã³ã¹ãæ°¸ç¶åãã¦ä½¿ç¨ãããã¨ãã§ãã¾ãã `` x1 / y1``ã¨ `` x2 / y2``ã®2ã¤ã®ç¹ãè¡¨ç¾ãããã¼ãã« `` vertices``ã¸ã®ãããã³ã°ãä½æãã¾ãããããã¯éå¸¸ãclassï¼ `.Column`ãªãã¸ã§ã¯ãã¨ãã¦ä½æããã¾ããæ¬¡ã«ãï¼funcï¼ `.composite`é¢æ°ãä½¿ç¨ãã¦ã` `Point``ã¯ã©ã¹ãä»ãã¦åã®éåãè¡¨ãæ°ããå±æ§ãå²ãå½ã¦ã¾ã:: Trueã®å ´åãcolumnãã­ããã£ã¯\ &quot;deferred \&quot;ã§ããã¤ã¾ããããã«èª­ã¿è¾¼ã¾ãããã¨ã¯ãªããã¤ã³ã¹ã¿ã³ã¹ã§ãã®å±æ§ãæåã«ã¢ã¯ã»ã¹ãããã¨ãã«èª­ã¿è¾¼ã¾ãã¾ãã funcï¼ `ãsqlalchemy.orm.deferred`ãåç§ãã¦ãã ããã `` True``ã®ã¨ãã¯ãã¹ã«ã©å±æ§ã®\ &quot;previous \&quot;å¤ãç½®æããã¦ããªããã°èª­ã¿è¾¼ã¾ããªããã°ãªããªããã¨ãç¤ºãã¾ããåããã©ã°ãfuncï¼ `.column_property`ã§è¦ã¦ãã ããã `` True``ã®ã¨ãã¯ãã¹ã«ã©å±æ§ã®\ &quot;previous \&quot;å¤ãç½®æããã¦ããªããã°èª­ã¿è¾¼ã¾ããªããã°ãªããªããã¨ãç¤ºãã¾ããåããã©ã°ãfuncï¼ `.column_property`ã§è¦ã¦ãã ããã .. versionchanged :: 0.7ãã®ãã©ã°ã¯ç¹ã«æå³ãããã¾ããä»¥åã¯ãã¬ã¼ã¹ãã«ãã§ããã extendsï¼classï¼ `.CompositeProperty.Comparator`ããã¯æ¯è¼æ¼ç®ã®ããã®ã«ã¹ã¿ã SQLç¯çæãæä¾ãã¾ãã ï¼classï¼ `.AttributeExtension`ã¤ã³ã¹ã¿ã³ã¹ãã¾ãã¯ã¯ã©ã¹ã«éç½®ãããçµæã®è¨è¿°å­ã®å±æ§ãªã¹ãã¼ã®ãªã¹ãã®åã«è¿½å ãããæ¡å¼µã®ãªã¹ãã§ãã **æ¨å¥¨ããã¦ãã¾ããã**åç§ï¼classï¼ `.AttributeEvents`ã ã¯ã©ã¹ãã¤ã³ãè¨è¿°å­ã®docã¨ãã¦é©ç¨ããããªãã·ã§ã³ã®æå­åã ãã©ã¡ã¼ã¿ 