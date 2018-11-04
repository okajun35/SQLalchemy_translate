Þ    ,      |              Ü  Æ   Ý  ì   ¤  Ï     ~   a  Ë   à  f   ¬  [        o  -     Â  º  ¨  }	  ¯   &     Ö  '  ì  l     n     o   ð  W   `     ¸  F   ×  `     -     V   ­       ¼    ¥  U  É  û  f  Å     ,  D   >  »     Æ   ?  ³    Ù  º  L     ²   á        ¨  
  B!  C   M#  h   #  ×  ú#  Q   Ò%    $&  ê   «'    (  ð   ¶)     §*    @+  {   Y,  k   Õ,  !   A-  >   c-  S  ¢-  Á  ö/  ½   ¸1  /   v2  Z  ¦2  °   4  ¸   ²4     k5  Q   ë5  )   =6  T   g6  ¥   ¼6  `   b7  |   Ã7  Ð   @8  ?  9  ï  Q;  .  A=  ¼  pA  	   -C  z   7C  ¼   ²C  ê   oD  ô  ZE  %  OG  a   uI  ô   ×I  S  ÌJ  ×   L  M  øM  Z   FP     ¡P  X  (Q  a   S   :attr:`.Mapper.all_orm_descriptors` - namespace of all mapped attributes, plus user-defined attributes defined using systems such as :class:`.hybrid_property`, :class:`.AssociationProxy` and others. :attr:`.Mapper.attrs` - a namespace of all mapped attributes.  The attributes themselves are instances of :class:`.MapperProperty`, which contain additional attributes that can lead to the mapped SQL expression or column, if applicable. :attr:`.Mapper.column_attrs` - the mapped attribute namespace limited to column and SQL expression attributes.   You might want to use :attr:`.Mapper.columns` to get at the :class:`.Column` objects directly. :attr:`.Mapper.columns` - A namespace of :class:`.Column` objects and other named SQL expressions associated with the mapping. :attr:`.Mapper.local_table` - The :class:`.Table` that is "local" to this mapper; this differs from :attr:`.Mapper.mapped_table` in the case of a mapper mapped using inheritance to a composed selectable. :attr:`.Mapper.mapped_table` - The :class:`.Table` or other selectable to which this mapper is mapped. :attr:`.Mapper.relationships` - namespace of all :class:`.RelationshipProperty` attributes. :ref:`subqueryload_ordering` A mapping which resolves this is as follows:: A relational database can return rows in any arbitrary order, when an explicit ordering is not set. While this ordering very often corresponds to the natural order of rows within a table, this is not the case for all databases and all queries.   The consequence of this is that any query that limits rows using ``LIMIT`` or ``OFFSET`` should **always** specify an ``ORDER BY``. Otherwise, it is not deterministic which rows will actually be returned. Above, we receive two ``addresses`` rows for ``user.id`` of 2, and none for 1.  We've wasted two rows and failed to actually load the collection.  This is an insidious error because without looking at the SQL and the results, the ORM will not show that there's any issue; if we access the ``addresses`` for the ``User`` we have, it will emit a lazy load for the collection and we won't see that anything actually went wrong. All tables in a relational database should have primary keys.   Even a many-to-many association table - the primary key would be the composite of the two association columns:: Are you doing this?:: As of SQLAlchemy version 0.9.5, the above condition is detected, and will warn that the ``id`` column of ``A`` and ``B`` is being combined under the same-named attribute ``id``, which above is a serious issue since it means that a ``B`` object's primary key will always mirror that of its ``A``. Better yet is when using fully declared table metadata, use the ``primary_key=True`` flag on those columns:: Column-based attributes can be given any name desired in the mapping. See :ref:`mapper_column_distinct_names`. Depending on database specifics, there is a chance we may get a result like the following for the two queries:: From there, all information about the class can be accessed through properties such as: Given the example as follows:: How do I configure a Column that is a Python reserved word or similar? How do I get a list of all columns, relationships, mapped attributes, etc. given a mapped class? How do I map a table that has no primary key? I'm getting a warning or error about "Implicitly combining column X under attribute Y" I'm using Declarative and setting primaryjoin/secondaryjoin using an ``and_()`` or ``or_()``, and I am getting an error message about foreign keys. In almost all cases, a table does have a so-called :term:`candidate key`, which is a column or series of columns that uniquely identify a row.  If a table truly doesn't have this, and has actual fully duplicate rows, the table is not corresponding to `first normal form <http://en.wikipedia.org/wiki/First_normal_form>`_ and cannot be mapped.   Otherwise, whatever columns comprise the best candidate key can be applied directly to the mapper:: It's important to note that we're only talking about the SQLAlchemy ORM; an application which builds on Core and deals only with :class:`.Table` objects, :func:`.select` constructs and the like, **does not** need any primary key to be present on or associated with a table in any way (though again, in SQL, all tables should really have some kind of primary key, lest you need to actually update or delete specific rows). Most ORMs require that objects have some kind of primary key defined because the object in memory must correspond to a uniquely identifiable row in the database table; at the very least, this allows the object can be targeted for UPDATE and DELETE statements which will affect only that object's row and no other.   However, the importance of the primary key goes far beyond that.  In SQLAlchemy, all ORM-mapped objects are at all times linked uniquely within a :class:`.Session` to their specific database row using a pattern called the :term:`identity map`, a pattern that's central to the unit of work system employed by SQLAlchemy, and is also key to the most common (and not-so-common) patterns of ORM usage. Note that the :func:`.joinedload` eager loader strategy does not suffer from the same problem because only one query is ever issued, so the load query cannot be different from the main query.  Similarly, the :func:`.selectinload` eager loader strategy also does not have this issue as it links its collection loads directly to primary key values just loaded. ORM Configuration Or if the objects you need are already available, skip the strings:: SQLAlchemy implements :func:`.orm.subqueryload` by issuing a separate query, the results of which are matched up to the results from the first query. We see two queries emitted like this: Suppose we did want ``A.id`` and ``B.id`` to be mirrors of each other, despite the fact that ``B.a_id`` is where ``A.id`` is related.  We could combine them together using :func:`.column_property`:: That's an ``and_()`` of two string expressions, which SQLAlchemy cannot apply any mapping towards.  Declarative allows :func:`.relationship` arguments to be specified as strings, which are converted into expression objects using ``eval()``.   But this doesn't occur inside of an ``and_()`` expression - it's a special operation declarative applies only to the *entirety* of what's passed to primaryjoin or other arguments as a string:: The SQLAlchemy ORM, in order to map to a particular table, needs there to be at least one column denoted as a primary key column; multiple-column, i.e. composite, primary keys are of course entirely feasible as well.  These columns do **not** need to be actually known to the database as primary key columns, though it's a good idea that they are.  It's only necessary that the columns *behave* as a primary key does, e.g. as a unique and not nullable identifier for a row. The same idea applies to all the other arguments, such as ``foreign_keys``:: The second query embeds the first query as a source of rows. When the inner query uses ``OFFSET`` and/or ``LIMIT`` without ordering, the two queries may not see the same results: The solution to this problem is to always specify a deterministic sort order, so that the main query always returns the same set of rows. This generally means that you should :meth:`.Query.order_by` on a unique column on the table. The primary key is a good choice for this:: This behavior is often desirable and is allowed without warning in the case where the two columns are linked together via a foreign key relationship within an inheritance mapping.   When the warning or exception occurs, the issue can be resolved by either assigning the columns to differently-named attributes, or if combining them together is desired, by using :func:`.column_property` to make this explicit. This condition refers to when a mapping contains two columns that are being mapped under the same attribute name due to their name, but there's no indication that this is intentional.  A mapped class needs to have explicit names for every attribute that is to store an independent value; when two columns have the same name and aren't disambiguated, they fall under the same attribute and the effect is that the value from one column is **copied** into the other, based on which column was assigned to the attribute first. This information is all available from the :class:`.Mapper` object. To get at the :class:`.Mapper` for a particular mapped class, call the :func:`.inspect` function on it:: When we use a SQLAlchemy method like :meth:`.Query.first`, we are in fact applying a ``LIMIT`` of one to the query, so without an explicit ordering it is not deterministic what row we actually get back. While we may not notice this for simple queries on databases that usually returns rows in their natural order, it becomes much more of an issue if we also use :func:`.orm.subqueryload` to load related collections, and we may not be loading the collections as intended. Why is ``ORDER BY`` required with ``LIMIT`` (especially with ``subqueryload()``)? Project-Id-Version: PROJECT VERSION
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
 ï¼attrï¼ `.Mapper.all_orm_descriptors`  - ãã¹ã¦ã®ããããããå±æ§ã®ååç©ºéã¨ãclassï¼` .hybrid_property`ãï¼classï¼ `.AssociationProxy`ãªã©ã®ã·ã¹ãã ãä½¿ã£ã¦å®ç¾©ãããã¦ã¼ã¶å®ç¾©å±æ§ã ï¼attrï¼ `.Mapper.attrs`  - ãããããããã¹ã¦ã®å±æ§ã®ååç©ºéãå±æ§èªä½ã¯ï¼classï¼ `.MapperProperty`ã®ã¤ã³ã¹ã¿ã³ã¹ã§ãããããã¯ãé©ç¨å¯è½ãªå ´åãããããããSQLå¼ã¾ãã¯åã«ã¤ãªããè¿½å ã®å±æ§ãå«ãã§ãã¾ãã ï¼attrï¼ `.Mapper.column_attrs`  - ã«ã©ã ã¨SQLå¼ã®å±æ§ã«éå®ãããããããããå±æ§ã®ååç©ºéã ï¼classï¼ `.Column`ãªãã¸ã§ã¯ããç´æ¥åå¾ããã«ã¯ãattrï¼` .Mapper.columns`ãä½¿ç¨ãã¾ãã ï¼attrï¼ `.Mapper.columns`  - ï¼classï¼` .Column`ãªãã¸ã§ã¯ãã¨ãã®ãããã³ã°ã«é¢é£ããä»ã®ååä»ãSQLå¼ã®ååç©ºéã ï¼attrï¼ `.Mapper.local_table`ï¼ãã®ãããã¼ã«ã¯ï¼classï¼` .table`ãããã¾ããããã¯ãä½æãããé¸æå¯è½ãªãã¸ã§ã¯ãã«ç¶æ¿ãä½¿ç¨ãã¦ãããããããããã¼ã®å ´åã¯ãï¼attrï¼ `.Mapper.mapped_table`ã¨ã¯ç°ãªãã¾ãã ï¼attrï¼ `.Mapper.mapped_table`  - ï¼classï¼` .Table`ã¾ãã¯ãã®ãããã¼ãããããããä»ã®é¸æè¢ã ï¼attrï¼ `.Mapper.relationships`  -  allï¼classï¼` .RelationshipProperty`å±æ§ã®ååç©ºéã§ãã ï¼refï¼ `subqueryload_ordering` ãããè§£æ±ºãããããã³ã°ã¯æ¬¡ã®ã¨ããã§ã:: ãªã¬ã¼ã·ã§ãã«ã»ãã¼ã¿ãã¼ã¹ã¯ãæç¤ºçãªé åºä»ããè¨­å®ããã¦ããªãå ´åãä»»æã®é åºã§è¡ãæ»ããã¨ãã§ãã¾ãããã®é åºä»ãã¯ããã¼ãã«åã®è¡ã®èªç¶é åºã«éå¸¸ã«ããå¯¾å¿ãã¾ãããããã¯ãã¹ã¦ã®ãã¼ã¿ãã¼ã¹ããã³ãã¹ã¦ã®ã¯ã¨ãªã§ã¯å½ã¦ã¯ã¾ãã¾ããããã®çµæã `` LIMIT``ã¾ãã¯ `` OFFSET``ãä½¿ã£ã¦è¡ãå¶éããã¯ã¨ãªã¯å¸¸ã«** `ORDER BY``ãæå®ããå¿è¦ãããã¾ããããä»¥å¤ã®å ´åãå®éã«è¿ãããè¡ã¯ç¢ºå®çã§ã¯ããã¾ããã ä¸ã®ä¾ã§ã¯ã2ã¤ã® `` user.id``ã®2ã¤ã® `` addresses``è¡ãåãåãã¾ã.1ã¤ã§ã¯2ã¤ã®è¡ãç¡é§ã«ãã¾ããã SQLã¨çµæãè¦ããã¨ãªããORMã¯åé¡ããªããã¨ãç¤ºããããããã¯é°è¬ã®ã¨ã©ã¼ã§ããç§ãã¡ãæã£ã¦ãã `` User``ã® `` addresses``ã«ã¢ã¯ã»ã¹ããã¨ãã³ã¬ã¯ã·ã§ã³ã®éå»¶ã­ã¼ããçºçããå®éã«ä½ããééã£ã¦ãããã¨ã¯ããã¾ããã ãªã¬ã¼ã·ã§ãã«ãã¼ã¿ãã¼ã¹ã®ãã¹ã¦ã®ãã¼ãã«ã«ã¯ä¸»ã­ã¼ãå¿è¦ã§ããå¤å¯¾å¤é¢é£ãã¼ãã«ã§ãã£ã¦ããä¸»ã­ã¼ã¯2ã¤ã®é¢é£åã®è¤åã§ã:: ããªãã¯ããããã£ã¦ãã¾ããï¼:: SQLAlchemyã®ãã¼ã¸ã§ã³0.9.5ã§ã¯ãä¸è¨ã®æ¡ä»¶ãæ¤åºããã `` A``ã¨ `` B``ã® `` id``ã«ã©ã ãåãååã®å±æ§ `` id``ã®ä¸ã§çµåããã¦ãããã¨ãè­¦åãã¾ã`ããã¯éå¤§ãªåé¡ã§ãããªããªãã` `B``ãªãã¸ã§ã¯ãã®ä¸»ã­ã¼ã¯ãå¸¸ã«` `A``ã®ä¸»ã­ã¼ã¨åãã§ããããã§ãã ããã«å®å¨ã«å®£è¨ããããã¼ãã«ã®ã¡ã¿ãã¼ã¿ãä½¿ç¨ããã¨ãã¯ããããã®ã«ã©ã ã§ `` primary_key = True``ãã©ã°ãä½¿ç¨ãã¦ãã ãã:: åãã¼ã¹ã®å±æ§ã«ã¯ããããã³ã°ã§å¿è¦ãªä»»æã®ååãä»ãããã¨ãã§ãã¾ããåç§ï¼refï¼ `mapper_column_distinct_names`ãåç§ãã¦ãã ããã ãã¼ã¿ãã¼ã¹ã®ç¹æ§ã«ãã£ã¦ã¯ã2ã¤ã®ã¯ã¨ãªã§æ¬¡ã®ãããªçµæãå¾ãããå¯è½æ§ãããã¾ãã ããããã¯ã©ã¹ã«é¢ãããã¹ã¦ã®æå ±ã«ã¢ã¯ã»ã¹ã§ãã¾ãã ä¸ããããä¾ãæ¬¡ã«ç¤ºãã¾ã:: Pythonã®äºç´èªãªã©ã®åãè¨­å®ããã«ã¯ã©ãããã°ããã§ããï¼ ãããã³ã°ãããã¯ã©ã¹ãä¸ããããå ´åãã©ã®ããã«ãã¦åãé¢ä¿ãããããããå±æ§ãªã©ã®ãªã¹ããåå¾ã§ãã¾ããï¼ ãã©ã¤ããªã­ã¼ãæããªããã¼ãã«ãã©ã®ããã«ãããããã®ã§ããï¼ \ &quot;å±æ§Xã®ä¸ã«åXãæé»çã«çµåãããã¨ã«ã¤ãã¦ã®è­¦åã¾ãã¯ã¨ã©ã¼ãè¡¨ç¤ºããã¾ãã ç§ã¯Declarativeãä½¿ãã `` and _ï¼ï¼ ``ã `` _ï¼ï¼ ``ãä½¿ã£ã¦primaryjoin / secondaryjoinãè¨­å®ãã¦ãã¾ããç§ã¯å¤é¨ã­ã¼ã«é¢ããã¨ã©ã¼ã¡ãã»ã¼ã¸ãåãåãã¾ãã ã»ã¨ãã©ã®å ´åããã¼ãã«ã«ã¯ãããããï¼termï¼ `åè£ã­ã¼ï¼candidate keyï¼ &#39;ãããã¾ããããã¯ãè¡ãä¸æã«è­å¥ããåã¾ãã¯åã®åã§ãããã¼ãã«ã«æ¬å½ã«ããããªããå®éã«å®å¨ã«éè¤ããè¡ãããå ´åããã¼ãã«ã¯ `æåã®æ­£è¦å½¢ã«å¯¾å¿ãã¦ãã¾ãã<http://en.wikipedia.org/wiki/First_normal_form> `_ã¨ããããããã¨ã¯ã§ãã¾ãããããã§ãªããã°ãæè¯ã®åè£ã­ã¼ãæ§æããã©ã®åããããã¼ã«ãç´æ¥é©ç¨ãããã¨ãã§ãã¾ã:: SQLAlchemy ORMã«ã¤ãã¦ã®ã¿è©±ãã¦ãããã¨ã«æ³¨æãã¦ãã ããã classï¼ `.Table`ãªãã¸ã§ã¯ããï¼funcï¼` .select`æ§é ä½ãªã©ãæ±ãã¢ããªã±ã¼ã·ã§ã³ã§ã¯ã**ãã¼ãã«ã«å­å¨ãããã¾ãã¯ãã¼ãã«ã«é¢é£ãããã©ã¤ããªã­ã¼ã¯å¿è¦ããã¾ããï¼å®éã«ã¯ãç¹å®ã®è¡ãå®éã«æ´æ°ã¾ãã¯åé¤ããå¿è¦ããªããããSQLã§ã¯ãã¹ã¦ã®ãã¼ãã«ã«ä½ããã®ãã©ã¤ããªã­ã¼ãå¿è¦ã§ãï¼ã ã»ã¨ãã©ã®ORMã§ã¯ãã¡ã¢ãªåã®ãªãã¸ã§ã¯ãããã¼ã¿ãã¼ã¹ãã¼ãã«ã®ä¸æã®è­å¥å¯è½ãªè¡ã«å¯¾å¿ãã¦ããå¿è¦ãããããããªãã¸ã§ã¯ãã«ã¯ä¸ç¨®ã®ä¸»ã­ã¼ãå®ç¾©ããã¦ããå¿è¦ãããã¾ããæä½ã§ããããã¯ãªãã¸ã§ã¯ããUPDATEã¨DELETEã¹ãã¼ãã¡ã³ãã®å¯¾è±¡ã«ãªããã¨ãå¯è½ã«ãã¾ãããã®ã¹ãã¼ãã¡ã³ãã¯ããã®ãªãã¸ã§ã¯ãã®è¡ã ãã«å½±é¿ããä»ã«ã¯å½±é¿ãã¾ãããããããä¸»ã­ã¼ã®éè¦æ§ã¯ãããã¯ããã«è¶ãã¦ãã¾ãã SQLAlchemyã§ã¯ããã¹ã¦ã®ORMã§ãããããããªãã¸ã§ã¯ãã¯ãï¼termï¼ `identity map`ã¨ãããã¿ã¼ã³ãä½¿ç¨ãã¦ãç¹å®ã®ãã¼ã¿ãã¼ã¹è¡ã«å¯¾ãã¦å¸¸ã«classï¼` .Session`åã§ä¸æã«ãªã³ã¯ããã¾ããããã¯ä½æ¥­ã¦ãããã®ä¸­å¿çãªãã¿ã¼ã³ã§ãSQLAlchemyã«ãã£ã¦æ¡ç¨ããã¦ããã·ã¹ãã ã§ãããORMã®ä½¿ç¨æ³ã®æãä¸è¬çãªï¼ããã»ã©ä¸è¬çã§ã¯ãªãï¼ãã¿ã¼ã³ã®éµã§ãããã¾ãã ï¼funcï¼ `.joinedload` eagerã­ã¼ãã¼æ¦ç¥ã¯ã1ã¤ã®ã¯ã¨ãªã¼ããçºè¡ããã¦ããªãã®ã§ãã­ã¼ãã¯ã¨ãªã¼ã¯ã¡ã¤ã³ã¯ã¨ãªã¼ã¨ç°ãªããã¨ãã§ããªããããåãåé¡ãçºçãã¾ãããåæ§ã«ãï¼funcï¼ `.selectinload` eagerã­ã¼ãã¼æ¦ç¥ããã­ã¼ããããã°ããã®ä¸»ã­ã¼å¤ã«ã³ã¬ã¯ã·ã§ã³ã®ã­ã¼ããç´æ¥ãªã³ã¯ããã®ã§ããã®åé¡ã¯ããã¾ããã ORMè¨­å® ã¾ãã¯ãå¿è¦ãªãªãã¸ã§ã¯ãããã§ã«å©ç¨å¯è½ãªå ´åã¯ãæå­åãã¹ã­ãããã¦ãã ãã:: SQLAlchemyã¯ï¼funcï¼ `.orm.subqueryload`ãå®è£ãã¾ãããã®çµæã¯æåã®ã¯ã¨ãªã®çµæã¨ä¸è´ãã¾ããæ¬¡ã®ããã«2ã¤ã®ã¯ã¨ãªãçæããã¦ãã¾ãã `` A.id``ã `` A.id``ã¨é¢é£ãã¦ããã«ããããããã `` A.id``ã¨ `` B.id``ãé¡ã®ããã«ãããã¨ãã¾ãããã funcï¼ `.column_property` ::ãä½¿ã£ã¦ããããçµã¿åããããã¨ãã§ãã¾ãã ããã¯ã2ã¤ã®æå­åå¼ã® ``ã¨_ï¼ï¼ ``ã§ããSQLAlchemyã¯ããã«å¯¾ãã¦ã©ããªãããã³ã°ãé©ç¨ã§ãã¾ããã Declarativeã¯ï¼funcï¼ `.relationship`å¼æ°ãæå­åã¨ãã¦æå®ãã` `evalï¼ï¼` `ãä½¿ã£ã¦å¼ãªãã¸ã§ã¯ãã«å¤æãã¾ããããããããã¯ `` and _ï¼ï¼ ``ã®å¼ã®ä¸­ã§ã¯çºçãã¾ãããç¹å¥ãªæ¼ç®å®£è¨ã¯ãprimaryjoinãä»ã®å¼æ°ã«æå­åã¨ãã¦æ¸¡ããããã®ã®*å¨ä½ã«ã®ã¿é©ç¨ããã¾ã:: SQLAlchemy ORMã¯ãç¹å®ã®ãã¼ãã«ã«ãããããããã«ããã©ã¤ããªã­ã¼ã«ã©ã ã¨å¼ã°ããå°ãªãã¨ã1ã¤ã®ã«ã©ã ãå¿è¦ã§ãããã¡ãããè¤æ°åã®è¤åã­ã¼ãä¸»ã­ã¼ããã¡ããå®å¨ã«å®ç¾å¯è½ã§ãããããã®åã¯ããã¼ã¿ãã¼ã¹ã«å®éã«ãã©ã¤ããªã­ã¼åã¨ãã¦èªè­ãããå¿è¦ã¯ããã¾ãããããããè¯ãèãã§ããå*ãä¸»ã­ã¼ã¨ãã¦åä½ãããã¨ãå¿è¦ãªã®ã¯ããã¨ãã°è¡ã®ä¸æã®nullableã§ã¯ãªãè­å¥å­ã§ãã `` foreign_keys``ã®ãããªä»ã®ãã¹ã¦ã®å¼æ°ã«ãåãèãæ¹ãé©ç¨ããã¾ã:: 2çªç®ã®ã¯ã¨ãªã¯ãæåã®ã¯ã¨ãªãè¡ã®ã½ã¼ã¹ã¨ãã¦åãè¾¼ã¿ã¾ããåå´ã®ã¯ã¨ãªãé åºä»ãããã« `` OFFSET``ã `` LIMIT``ãä½¿ãã¨ãã2ã¤ã®ã¯ã¨ãªã¯åãçµæãè¦ããã¨ãã§ãã¾ããï¼ ãã®åé¡ãè§£æ±ºããã«ã¯ãå¸¸ã«æ±ºå®è«çãªã½ã¼ãé ãæå®ãã¦ãã¡ã¤ã³ã¯ã¨ãªãå¸¸ã«åãè¡ã»ãããè¿ãããã«ãã¾ããããã¯ä¸è¬çã«ããã¼ãã«ã®ä¸æã®åã«ï¼methï¼ `.Query.order_by`ãæå®ãããã¨ãæå³ãã¾ãããã©ã¤ããªã­ã¼ã¯ããã«é©ãã¦ãã¾ã:: ãã®åä½ã¯ãã°ãã°æã¾ãããã¨ã§ããã2ã¤ã®åãç¶æ¿ãããã³ã°åã§å¤é¨ã­ã¼é¢ä¿ãä»ãã¦ä¸ç·ã«ãªã³ã¯ããã¦ããå ´åã¯è­¦åãªãã§è¨±å¯ããã¾ããè­¦åã¾ãã¯ä¾å¤ãçºçããå ´åããã®åé¡ãè§£æ±ºããã«ã¯ãï¼funcï¼ `.column_property`ãä½¿ç¨ãã¦ç°ãªãååã®å±æ§ã«åãå²ãå½ã¦ãããã¾ãã¯ããããçµã¿åããããã¨ãæã¾ããå ´åã«è§£æ±ºãã¾ãã ãã®æ¡ä»¶ã¯ãååã®ããã«åãå±æ§åã®ä¸ã«ãããã³ã°ããã¦ãã2ã¤ã®åããããã³ã°ã«å«ã¾ãã¦ããå ´åãæãã¾ããããããæå³çã§ããã¨ããæç¤ºã¯ããã¾ãããããããããã¯ã©ã¹ã¯ãç¬ç«ããå¤ãæ ¼ç´ãããã¹ã¦ã®å±æ§ã«å¯¾ãã¦æç¤ºçãªååãæã¤å¿è¦ãããã¾ãã 2ã¤ã®åãåãååã§ææ§ãããªãå ´åããããã¯åãå±æ§ã«å±ãããã®çµæãããåã®å¤ã¯æåã«ãã®å±æ§ã«å²ãå½ã¦ãããåã«åºã¥ãã¦**ã³ãã¼**ããã¾ãã ãã®æå ±ã¯ãã¹ã¦ï¼classï¼ `.Mapper`ãªãã¸ã§ã¯ãããå©ç¨ã§ãã¾ãã ç¹å®ã®ããããããã¯ã©ã¹ã®ï¼classï¼ `.Mapper`ãåå¾ããã«ã¯ãï¼funcï¼` .inspect`é¢æ°ãå¼ã³åºãã¾ã:: ï¼methï¼ `.Query.first`ã®ãããªSQLAlchemyã¡ã½ãããä½¿ç¨ããã¨ãå®éã«ã¯` `LIMIT``ãã¯ã¨ãªã«é©ç¨ãã¦ããã®ã§ãæç¤ºçãªé åºä»ããããªãã¦ããå®éã«ã©ã®è¡ã«æ»ããã¯ç¢ºå®çã§ã¯ããã¾ãããéå¸¸ã¯èªç¶é åºã§è¡ãè¿ããã¼ã¿ãã¼ã¹ã«å¯¾ããç°¡åãªã¯ã¨ãªã§ã¯ãããæ°ä»ããªãããããã¾ããããé¢é£ããã³ã¬ã¯ã·ã§ã³ãèª­ã¿è¾¼ãããã«ï¼funcï¼ `.orm.subqueryload`ãä½¿ç¨ããã¨ããã£ã¨åé¡ã«ãªãã¾ããã³ã¬ã¯ã·ã§ã³ãæå³ããã¨ããã«èª­ã¿è¾¼ã¿ã¾ãã `` LIMIT``ï¼ç¹ã« `` subqueryloadï¼ï¼ ``ã§ `` ORDER BY``ãå¿è¦ãªã®ã¯ãªãã§ããï¼ 