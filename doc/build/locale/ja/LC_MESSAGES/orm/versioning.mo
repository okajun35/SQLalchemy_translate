Þ                               &  %  õ  L     B     `  Þ     Æ   _  £   &    Ê    O	  ,   Þ
          (  E   @  4     i  »  ï  %      S  ¯  ²    §   ¶  æ  ^  £  E  4  é  G    û  f  m   b  ]  Ð     .!  Ú   ¶!    "     $  Y  5$    %  $    (  4   E(    z(  ð   )  »   *  Ý  ?+    -  E   8/  *   ~/  '   ©/  c   Ñ/  N   50  é  0  ä  n2    S6  Ý  `9  8  ><  Ñ   w>  3  I?  Ý  }A  k  [C  ½  ÇD  g  F     íH  È  ~I     GK  Ü   ÞK   :ref:`custom_guid_type` Above, the ``User`` mapping tracks integer versions using the column ``version_id``.   When an object of type ``User`` is first flushed, the ``version_id`` column will be given a value of "1".   Then, an UPDATE of the table later on will always be emitted in a manner similar to the following:: Because the versioning feature relies upon comparison of the **in memory** record of an object, the feature only applies to the :meth:`.Session.flush` process, where the ORM flushes individual in-memory rows to the database. It does **not** take effect when performing a multirow UPDATE or DELETE using :meth:`.Query.update` or :meth:`.Query.delete` methods, as these methods only emit an UPDATE or DELETE statement but otherwise do not have direct access to the contents of those rows being affected. Configuring a Version Counter Custom Version Counters / Types For example, if we wanted to track the versioning of our ``User`` class using a randomly generated GUID, we could do this (note that some backends support a native GUID type, but we illustrate here using a simple string):: In the above scenario, as ``xmin`` is a system column provided by PostgreSQL, we use the ``system=True`` argument to mark it as a system-provided column, omitted from the ``CREATE TABLE`` statement. It is **strongly recommended** that the ``version_id`` column be made NOT NULL.  The versioning feature **does not support** a NULL value in the versioning column. It is *strongly recommended* that server side version counters only be used when absolutely necessary and only on backends that support :term:`RETURNING`, e.g. PostgreSQL, Oracle, SQL Server (though SQL Server has `major caveats <http://blogs.msdn.com/b/sqlprogrammability/archive/2008/07/11/update-with-output-clause-triggers-and-sqlmoreresults.aspx>`_ when triggers are used), Firebird. Other kinds of values or counters can be used for versioning.  Common types include dates and GUIDs.   When using an alternate type or counter scheme, SQLAlchemy provides a hook for this scheme using the ``version_id_generator`` argument, which accepts a version generation callable.  This callable is passed the value of the current known version, and is expected to return the subsequent version. Programmatic or Conditional Version Counters Server Side Version Counters Simple Version Counting Support for programmatic and conditional version identifier tracking. Support for server side version identifier tracking. The :class:`.Mapper` supports management of a :term:`version id column`, which is a single table column that increments or otherwise updates its value each time an ``UPDATE`` to the mapped table occurs.  This value is checked each time the ORM emits an ``UPDATE`` or ``DELETE`` against the row to ensure that the value held in memory matches the database value. The ORM typically does not actively fetch the values of database-generated values when it emits an INSERT or UPDATE, instead leaving these columns as "expired" and to be fetched when they are next accessed, unless the ``eager_defaults`` :func:`.mapper` flag is set.  However, when a server side version column is used, the ORM needs to actively fetch the newly generated value.  This is so that the version counter is set up *before* any concurrent transaction may update it again.   This fetching is also best done simultaneously within the INSERT or UPDATE statement using :term:`RETURNING`, otherwise if emitting a SELECT statement afterwards, there is still a potential race condition where the version counter may change before it can be fetched. The ``version_id_generator`` can also be configured to rely upon a value that is generated by the database.  In this case, the database would need some means of generating new identifiers when a row is subject to an INSERT as well as with an UPDATE.   For the UPDATE case, typically an update trigger is needed, unless the database in question supports some other native version identifier.  The PostgreSQL database in particular supports a system column called `xmin <http://www.postgresql.org/docs/9.1/static/ddl-system-columns.html>`_ which provides UPDATE versioning.  We can make use of the PostgreSQL ``xmin`` column to version our ``User`` class as follows:: The above UPDATE statement is updating the row that not only matches ``user.id = 1``, it also is requiring that ``user.version_id = 1``, where "1" is the last version identifier we've been known to use on this object. If a transaction elsewhere has modified the row independently, this version id will no longer match, and the UPDATE statement will report that no rows matched; this is the condition that SQLAlchemy tests, that exactly one row matched our UPDATE (or DELETE) statement.  If zero rows match, that indicates our version of the data is stale, and a :exc:`.StaleDataError` is raised. The database that enforces repeatable reads will typically either have locked the target row against a concurrent update, or is employing some form of multi version concurrency control such that it will emit an error when the transaction is committed.  SQLAlchemy's version_id_col is an alternative which allows version tracking to occur for specific tables within a transaction that otherwise might not have this isolation level set. The most straightforward way to track versions is to add an integer column to the mapped table, then establish it as the ``version_id_col`` within the mapper options:: The persistence engine will call upon ``uuid.uuid4()`` each time a ``User`` object is subject to an INSERT or an UPDATE.  In this case, our version generation function can disregard the incoming value of ``version``, as the ``uuid4()`` function generates identifiers without any prerequisite value.  If we were using a sequential versioning scheme such as numeric or a special character system, we could make use of the given ``version`` in order to help determine the subsequent value. The purpose of this feature is to detect when two concurrent transactions are modifying the same row at roughly the same time, or alternatively to provide a guard against the usage of a "stale" row in a system that might be re-using data from a previous transaction without refreshing (e.g. if one sets ``expire_on_commit=False`` with a :class:`.Session`, it is possible to re-use the data from a previous transaction). We can update our ``User`` object without incrementing the version counter as well; the value of the counter will remain unchanged, and the UPDATE statement will still check against the previous value.  This may be useful for schemes where only certain classes of UPDATE are sensitive to concurrency issues:: When ``version_id_generator`` is set to False, we can also programmatically (and conditionally) set the version identifier on our object in the same way we assign any other mapped attribute.  Such as if we used our UUID example, but set ``version_id_generator`` to ``False``, we can set the version identifier at our choosing:: When detecting concurrent updates within transactions, it is typically the case that the database's transaction isolation level is below the level of :term:`repeatable read`; otherwise, the transaction will not be exposed to a new row value created by a concurrent update which conflicts with the locally updated value.  In this case, the SQLAlchemy versioning feature will typically not be useful for in-transaction conflict detection, though it still can be used for cross-transaction staleness detection. When the target database supports RETURNING, an INSERT statement for our ``User`` class will look like this:: Where above, the ORM can acquire any newly generated primary key values along with server-generated version identifiers in one statement.   When the backend does not support RETURNING, an additional SELECT must be emitted for **every** INSERT and UPDATE, which is much less efficient, and also introduces the possibility of missed version counters:: With the above mapping, the ORM will rely upon the ``xmin`` column for automatically providing the new value of the version id counter. `Repeatable Read Isolation Level <http://www.postgresql.org/docs/9.1/static/transaction-iso.html#XACT-REPEATABLE-READ>`_ - PostgreSQL's implementation of repeatable read, including a description of the error condition. Project-Id-Version: PROJECT VERSION
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
 ï¼refï¼ `custom_guid_type` ä¸è¨ã® `` User``ãããã³ã°ã¯ `` version_id``ã«ã©ã ãä½¿ã£ã¦æ´æ°ãã¼ã¸ã§ã³ãè¿½è·¡ãã¾ãã `` User``åã®ãªãã¸ã§ã¯ããæåã«ãã©ãã·ã¥ãããã¨ã `` version_id``ã«ã©ã ã¯\ &quot;1 \&quot;ã®å¤ãä¸ãããã¾ãããã®å¾ãæ¬¡ã®ãããªæ¹æ³ã§è¡¨ã®UPDATEãå¸¸ã«çºè¡ããã¾ãã ãã¼ã¸ã§ã³ç®¡çæ©è½ã¯ãªãã¸ã§ã¯ãã®**ã¡ã¢ãª**ã¬ã³ã¼ãã®æ¯è¼ã«ä¾å­ããããããã®æ©è½ã¯ï¼methï¼ `.Session.flush`ãã­ã»ã¹ã«ã®ã¿é©ç¨ããã¾ãããã®ãã­ã»ã¹ã§ã¯ãORMã«ãã£ã¦åãã®ã¡ã¢ãªåã®è¡ããã¼ã¿ãã¼ã¹ã«ãã©ãã·ã¥ããã¾ãã methï¼ `.Query.update`ã¡ã½ããã¾ãã¯ï¼methï¼` .Query.delete`ã¡ã½ãããä½¿ç¨ãã¦è¤æ°è¡ã®UPDATEã¾ãã¯DELETEãå®è¡ããå ´åã¯**ãããã®ã¡ã½ããã¯UPDATEã¾ãã¯DELETEã¹ãã¼ãã¡ã³ãã®ã¿ãåºåãã¾ãããå½±é¿ãåããè¡ã®åå®¹ã«ç´æ¥ã¢ã¯ã»ã¹ãããã¨ã¯ã§ãã¾ããã ãã¼ã¸ã§ã³ã«ã¦ã³ã¿ã®è¨­å® ã«ã¹ã¿ã ãã¼ã¸ã§ã³ã®ã«ã¦ã³ã¿/ã¿ã¤ã ãã¨ãã°ãã©ã³ãã ã«çæãããGUIDãä½¿ç¨ãã¦ã `` User``ã¯ã©ã¹ã®ãã¼ã¸ã§ã³ç®¡çãè¿½è·¡ãããå ´åããããè¡ããã¨ãã§ãã¾ãï¼ããã¤ãã®ããã¯ã¨ã³ãã¯ãã¤ãã£ããªGUIDã¿ã¤ãããµãã¼ããã¦ãã¾ããã ä¸è¨ã®ã·ããªãªã§ã¯ã `` xmin``ã¯PostgreSQLãæä¾ããã·ã¹ãã ã«ã©ã ã§ããããã `` system = True``å¼æ°ãä½¿ç¨ãã¦ã·ã¹ãã æä¾ã®ã«ã©ã ã¨ãã¦ãã¼ã¯ãã¾ããããã¯ `` CREATE TABLE``æã `` version_id``ã«ã©ã ãNOT NULLã«ãããã¨ãå¼·ããå§ããã¾ã**ããã¼ã¸ã§ã³ç®¡çæ©è½**ã¯ããã¼ã¸ã§ã³ç®¡çåã®NULLå¤ããµãã¼ããã¦ãã¾ããã ãµã¼ãã¼ãµã¤ãã®ãã¼ã¸ã§ã³ã«ã¦ã³ã¿ã¼ã¯çµ¶å¯¾ã«å¿è¦ãªã¨ãã«ã®ã¿ä½¿ç¨ãããã¨ãå¼·ããå§ããã¾ããtermï¼ `RETURNING`ããµãã¼ãããããã¯ã¨ã³ããä¾ãã°PostgreSQLãOracleãSQL Serverï¼ãã ãSQL Serverã«ã¯ä¸»ãªæ³¨æç¹ãããã¾ã<http://blogs.msdn.com/b/sqlprogrammability/archive/2008/07/11/update-with-output-clause-triggers-and-sqlmoreresults.aspx> `_ããªã¬ãä½¿ç¨ãããã¨ãã«_ï¼ãFirebirdã ãã¼ã¸ã§ã³ç®¡çã«ã¯ä»ã®ç¨®é¡ã®å¤ãã«ã¦ã³ã¿ãä½¿ç¨ã§ãã¾ããä¸è¬çãªåã«ã¯ãæ¥ä»ã¨GUIDãå«ã¾ãã¾ããä»£æ¿åã¾ãã¯ã«ã¦ã³ã¿æ¹å¼ãä½¿ç¨ããå ´åãSQLAlchemyã¯ããã¼ã¸ã§ã³çæå¼ã³åºãå¯è½ãåãå¥ãã `` version_id_generator``å¼æ°ãä½¿ç¨ãã¦ããã®ã¹ã­ã¼ã ã®ããã¯ãæä¾ãã¾ãããã®å¼ã³åºãå¯è½ãªãã¸ã§ã¯ãã¯ç¾å¨ã®æ¢ç¥ã®ãã¼ã¸ã§ã³ã®å¤ãæ¸¡ãããå¾ç¶ã®ãã¼ã¸ã§ã³ãè¿ããã¨ãæå¾ããã¾ãã ãã­ã°ã©ã åã¾ãã¯æ¡ä»¶ä»ããã¼ã¸ã§ã³ã®ã«ã¦ã³ã¿ ãµã¼ãã¼å´ãã¼ã¸ã§ã³ã«ã¦ã³ã¿ åç´ãªãã¼ã¸ã§ã³ã®ã«ã¦ã³ã ãã­ã°ã©ã åããã³æ¡ä»¶ä»ããã¼ã¸ã§ã³è­å¥å­ãã©ãã­ã³ã°ã®ãµãã¼ãã ãµã¼ãã¼å´ã®ãã¼ã¸ã§ã³è­å¥å­ãã©ãã­ã³ã°ã®ãµãã¼ãã ï¼classï¼ `.Mapper`ã¯ãï¼termï¼` version id column`ã®ç®¡çããµãã¼ããã¦ãã¾ããããã¯ããããããããã¼ãã«ã¸ã® `` UPDATE``ãçºçãããã³ã«ãã®å¤ãã¤ã³ã¯ãªã¡ã³ãã¾ãã¯æ´æ°ããåä¸ã®ãã¼ãã«ã«ã©ã ã§ãããã®å¤ã¯ORMãè¡ã«å¯¾ãã¦ãUPDATEãã¾ãã¯ãDELETEããçºè¡ãããã³ã«ãã§ãã¯ãããã¡ã¢ãªã«ä¿æããã¦ããå¤ããã¼ã¿ãã¼ã¹å¤ã¨ä¸è´ãããã¨ãä¿è¨¼ãã¾ãã ORMã¯éå¸¸ãINSERTã¾ãã¯UPDATEãçºè¡ããã¨ãã«ãã¼ã¿ãã¼ã¹çæå¤ã®å¤ãç©æ¥µçã«ãã§ãããã¾ããããããã®åã\ &quot;æéåã\&quot;ã¨ãã¦æ®ããæ¬¡åã¢ã¯ã»ã¹æã«ãã§ãããã¾ãã funcï¼ `.mapper`ãã©ã°ãã»ããããã¦ãã¾ãããã ãããµã¼ãã¼å´ã®ãã¼ã¸ã§ã³åãä½¿ç¨ããå ´åãORMã¯æ°ããçæãããå¤ãã¢ã¯ãã£ãã«åå¾ããå¿è¦ãããã¾ããããã¯ããã¼ã¸ã§ã³ã«ã¦ã³ã¿ãè¨­å®ããã¦ãã*ãããåæãã©ã³ã¶ã¯ã·ã§ã³ããããåã³æ´æ°ããåã«*è¨­å®ããã¦ããããã§ãããã®ãã§ããã¯ãINSERTã¹ãã¼ãã¡ã³ãã¾ãã¯UPDATEã¹ãã¼ãã¡ã³ãåã§ï¼termï¼ `RETURNING`ãä½¿ç¨ãã¦åæã«è¡ãã®ãæåã§ããããããªãã¨ãå¾ã§SELECTã¹ãã¼ãã¡ã³ããçºè¡ããå ´åã§ãããã§ããã§ããåã«ãã¼ã¸ã§ã³ã«ã¦ã³ã¿ã¼ãå¤æ´ãããå¯è½æ§ãããã¾ãã `` version_id_generator``ã¯ããã¼ã¿ãã¼ã¹ã«ãã£ã¦çæãããå¤ã«ä¾å­ããããã«è¨­å®ãããã¨ãã§ãã¾ãããã®å ´åããã¼ã¿ãã¼ã¹ã¯ãè¡ãINSERTã¨UPDATEã®ä¸¡æ¹ãåããã¨ãã«æ°ããè­å¥å­ãçæããææ®µãå¿è¦ã¨ãã¾ãã UPDATEã®å ´åãåé¡ã®ãã¼ã¿ãã¼ã¹ãä»ã®ãã¤ãã£ããã¼ã¸ã§ã³è­å¥å­ããµãã¼ããã¦ããªãéããéå¸¸ã¯æ´æ°ããªã¬ã¼ãå¿è¦ã§ãã PostgreSQLãã¼ã¿ãã¼ã¹ã¯ãç¹ã«ã `xmin <http://www.postgresql.org/docs/9.1/static/ddl-system-columns.html> `_ã¯UPDATEãã¼ã¸ã§ã³ç®¡çãæä¾ãã¾ãã PostgreSQLã® `` xmin``ã«ã©ã ãä½¿ã£ã¦ã `` User``ã¯ã©ã¹ãæ¬¡ã®ããã«ãã¼ã¸ã§ã³ã¢ãããããã¨ãã§ãã¾ã:: ä¸è¨ã®UPDATEæã¯ã `` user.id = 1``ã¨ä¸è´ããã ãã§ãªãã `` user.version_id = 1``ãå¿è¦ã¨ãã¦ããè¡ãæ´æ°ãã¦ãã¾ãã\ &quot;1 \&quot;ã¯ããã®ãªãã¸ã§ã¯ãã§ä½¿ç¨ãããã¨ãç¥ããã¦ãã¾ããå¥ã®å ´æã®ãã©ã³ã¶ã¯ã·ã§ã³ãç¬ç«ã«è¡ãå¤æ´ããå ´åããã®ãã¼ã¸ã§ã³IDã¯ä¸è´ããªããªããUPDATEæã¯ä¸è´ããè¡ããªããã¨ãå ±åãã¾ããããã¯ãSQLAlchemyããã¹ããã¦ããæ¡ä»¶ã§ãã¡ããã©1ã¤ã®è¡ãUPDATEï¼ã¾ãã¯DELETEï¼ã¹ãã¼ãã¡ã³ãã¨ä¸è´ãã¦ãã¾ããã¼ã­è¡ãä¸è´ããã¨ããã¼ã¿ã®ãã¼ã¸ã§ã³ãå¤ããaï¼excï¼ `.StaleDataError`ãçºçãããã¨ãç¤ºãã¾ãã åå¾©å¯è½ãªèª­ã¿åããå¼·å¶ãããã¼ã¿ãã¼ã¹ã¯ãéå¸¸ãä¸¦è¡æ´æ°ã«å¯¾ãã¦ã¿ã¼ã²ããè¡ãã­ãã¯ãã¦ãããããã©ã³ã¶ã¯ã·ã§ã³ãã³ããããããã¨ãã«ã¨ã©ã¼ãçºè¡ãããããªä½ããã®å½¢å¼ã®ãã«ããã¼ã¸ã§ã³åæå®è¡å¶å¾¡ãæ¡ç¨ãã¦ãã¾ãã SQLAlchemyã®version_id_colã¯ããã®åé¢ã¬ãã«ãè¨­å®ããã¦ããªãå¯è½æ§ããããã©ã³ã¶ã¯ã·ã§ã³åã®ç¹å®ã®ãã¼ãã«ã§ãã¼ã¸ã§ã³ãã©ãã­ã³ã°ãå®è¡ã§ããããã«ããä»£æ¿ææ®µã§ãã ãã¼ã¸ã§ã³ãè¿½è·¡ããæãç°¡åãªæ¹æ³ã¯ããããããããã¼ãã«ã«æ´æ°åãè¿½å ããããããããã¼ãªãã·ã§ã³ã® `` version_id_col``ã¨ãã¦è¨­å®ãããã¨ã§ãï¼ æ°¸ç¶ã¨ã³ã¸ã³ã¯ã `` User``ãªãã¸ã§ã¯ããINSERTã¾ãã¯UPDATEã®å¯¾è±¡ã¨ãªããã³ã«ã `` uuid.uuid4ï¼ï¼ ``ãå¼ã³åºãã¾ãããã®å ´åã `` uuid4ï¼ï¼ ``é¢æ°ã¯åææ¡ä»¶å¤ãªãã§è­å¥å­ãçæããã®ã§ããã¼ã¸ã§ã³çæé¢æ°ã¯ `` version``ã®å¥åå¤ãç¡è¦ã§ãã¾ããæ°å¤ãç¹æ®æå­ã·ã¹ãã ãªã©ã®ã·ã¼ã±ã³ã·ã£ã«ãã¼ã¸ã§ãã³ã°ã¹ã­ã¼ã ãä½¿ç¨ãã¦ããå ´åãå¾ç¶ã®å¤ãæ±ºå®ããããã«ãä¸ãããã `` version``ãå©ç¨ãããã¨ãã§ãã¾ãã ãã®æ©è½ã®ç®çã¯ã2ã¤ã®åæãã©ã³ã¶ã¯ã·ã§ã³ãåãè¡ãã»ã¼åãæéã«å¤æ´ãã¦ãããã©ãããæ¤åºããããã¾ãã¯ãã¼ã¿ãåå©ç¨ãã¦ããå¯è½æ§ãããã·ã¹ãã åã®å¤ãè¡ã®ä½¿ç¨ã«å¯¾ãã¦ã¬ã¼ããæä¾ãããã¨ã§ãï¼ä¾ãã°ï¼classï¼ `.Session`ã§` expire_on_commit = False``ãè¨­å®ããã¨ãä»¥åã®ãã©ã³ã¶ã¯ã·ã§ã³ããã®ãã¼ã¿ãåå©ç¨ãããã¨ãã§ãã¾ãï¼ã ãã¼ã¸ã§ã³ã«ã¦ã³ã¿ãã¤ã³ã¯ãªã¡ã³ãããã« `` User``ãªãã¸ã§ã¯ããæ´æ°ãããã¨ãã§ãã¾ããã«ã¦ã³ã¿ã¼ã®å¤ã¯å¤æ´ããããUPDATEã¹ãã¼ãã¡ã³ãã¯å¼ãç¶ãåã®å¤ã¨ç§åãã¾ããããã¯ãããç¨®ã®UPDATEã®ã¯ã©ã¹ã ããä¸¦è¡æ§ã®åé¡ã«ææã§ããã¹ã­ã¼ã ã§å½¹ã«ç«ã¡ã¾ã:: `` version_id_generator``ãFalseã«è¨­å®ããã¦ããå ´åãä»ã®ããããããå±æ§ãå²ãå½ã¦ãã®ã¨åãæ¹æ³ã§ããã­ã°ã©ã ä¸ï¼ããã¦æ¡ä»¶ä»ãã§ï¼ãªãã¸ã§ã¯ãã®ãã¼ã¸ã§ã³è­å¥å­ãè¨­å®ãããã¨ãã§ãã¾ãããã¨ãã°ãUUIDã®ä¾ãä½¿ç¨ãã¦ãã¦ã `` version_id_generator``ã `` False``ã«è¨­å®ããå ´åããã¼ã¸ã§ã³è­å¥å­ã¯æ¬¡ã®ããã«è¨­å®ã§ãã¾ã:: ãã©ã³ã¶ã¯ã·ã§ã³åã§ã®åææ´æ°ãæ¤åºããå ´åãéå¸¸ããã¼ã¿ãã¼ã¹ã®ãã©ã³ã¶ã¯ã·ã§ã³åé¢ã¬ãã«ãä»¥ä¸ã®ã¬ãã«ããä½ãå ´åãããã¾ããtermï¼ `repeatable read`;ããä»¥å¤ã®å ´åããã©ã³ã¶ã¯ã·ã§ã³ã¯ãã­ã¼ã«ã«æ´æ°å¤ã¨ç«¶åããä¸¦è¡æ´æ°ã«ãã£ã¦ä½æãããæ°ããè¡å¤ã«å¬éããã¾ããããã®å ´åãSQLAlchemyã®ãã¼ã¸ã§ãã³ã°æ©è½ã¯ãéå¸¸ããã©ã³ã¶ã¯ã·ã§ã³åã®ç«¶åæ¤åºã«ã¯ä½¿ç¨ã§ãã¾ãããããã©ã³ã¶ã¯ã·ã§ã³åã®ç«¶åæ¤åºã«ã¯æå¹ã§ã¯ããã¾ããã ã¿ã¼ã²ãããã¼ã¿ãã¼ã¹ãRETURNINGããµãã¼ããã¦ããå ´åã `` User``ã¯ã©ã¹ã®INSERTæã¯æ¬¡ã®ããã«ãªãã¾ã:: ä¸è¨ã®å ´åãORMã¯ãæ°ããçæãããä¸»ã­ã¼å¤ãã1ã¤ã®ã¹ãã¼ãã¡ã³ãåã®ãµã¼ãã¼çæãã¼ã¸ã§ã³è­å¥å­ã¨ã¨ãã«åå¾ã§ãã¾ããããã¯ã¨ã³ããRETURNINGããµãã¼ããã¦ããªãå ´åã** INSERTã¨UPDATEã®**ã«å¯¾ãã¦ã¯ãããå¹ççã§ã¯ãªãè¿½å ã®SELECTãçºè¡ããå¿è¦ãããã¾ããã¾ãããã¼ã¸ã§ã³ã«ã¦ã³ã¿ãç´å¤±ãã¦ãã¾ãå¯è½æ§ãããã¾ãã ä¸è¨ã®ãããã³ã°ã§ã¯ãORMã¯ãã¼ã¸ã§ã³IDã«ã¦ã³ã¿ã®æ°ããå¤ãèªåçã«æä¾ãã `` xmin``ã«ã©ã ã«ä¾å­ãã¾ãã `åå¾©å¯è½ãªèª­ã¿åãåé¢ã¬ãã«<http://www.postgresql.org/docs/9.1/static/transaction-iso.html#XACT-REPEATABLE-READ> `_  - ã¨ã©ã¼ç¶æã®èª¬æãå«ãPostgreSQLã®åå¾©å¯è½ãªèª­ã¿è¾¼ã¿ã®å®è£ã 