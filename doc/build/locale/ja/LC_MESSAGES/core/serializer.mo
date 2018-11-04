Þ    	      d               ¬   )  ­      ×  r   ÷      j  ¢    V   ®  G     ¢   M    ð  f  w     Þ  ½   ú  ñ   ¸	  2  ª
  {   Ý  Z   Y  á   ´   Any SQLAlchemy query structure, either based on sqlalchemy.sql.* or sqlalchemy.orm.* can be used.  The mappers, Tables, Columns, Session etc. which are referenced by the structure are not persisted in serialized form, but are instead re-associated with the query structure when it is deserialized. Expression Serializer Extension Serializer/Deserializer objects for usage with SQLAlchemy query structures, allowing "contextual" deserialization. Similar restrictions as when using raw pickle apply; mapped classes must be themselves be pickleable, meaning they are importable from a module-level namespace. Table metadata that is to be loaded entirely from the serialized structure (i.e. is not already declared in the application).   Regular pickle.loads()/dumps() can be used to fully dump any ``MetaData`` object, typically one which was reflected from an existing database at some previous point in time.  The serializer module is specifically for the opposite case, where the Table metadata is already present in memory. The serializer module is only appropriate for query structures.  It is not needed for: Usage is nearly the same as that of the standard Python pickle module:: instances of user-defined classes.   These contain no references to engines, sessions or expression constructs in the typical case and can be serialized directly. Project-Id-Version: PROJECT VERSION
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
 sqlalchemy.sqlã*ã¾ãã¯sqlalchemy.ormã*ã«åºã¥ãSQLAlchemyã¯ã¨ãªæ§é ãä½¿ç¨ã§ãã¾ããæ§é ä½ã«ãã£ã¦åç§ããããããã¼ããã¼ãã«ãåãã»ãã·ã§ã³ãªã©ã¯ãã·ãªã¢ã«åãããå½¢å¼ã§ã¯æ°¸ç¶åããã¾ããããéã·ãªã¢ã«åãããã¨ãã«ã¯ã¨ãªæ§é ä½ã«åé¢é£ä»ãããã¾ãã å¼ã·ãªã¢ã©ã¤ã¶æ¡å¼µ SQLAlchemyã¯ã¨ãªæ§é ã§ä½¿ç¨ããããã®ã·ãªã¢ã©ã¤ã¶/ãã·ãªã¢ã©ã¤ã¶ãªãã¸ã§ã¯ãã§ã &quot;ã³ã³ãã­ã¹ãä¸ã®&quot;ãã·ãªã¢ã©ã¤ãºãå¯è½ã§ãã çã®pickleãé©ç¨ããå ´åã¨åæ§ã®å¶éãé©ç¨ããã¾ããããããããã¯ã©ã¹èªä½ãpickleableã§ãªããã°ãªãã¾ãããã¤ã¾ããã¢ã¸ã¥ã¼ã«ã¬ãã«ã®ååç©ºéããã¤ã³ãã¼ãå¯è½ã§ãã ã·ãªã¢ã©ã¤ãºãããæ§é ä½ããå®å¨ã«ã­ã¼ããããï¼ã¤ã¾ããã¢ããªã±ã¼ã·ã§ã³ã§ã¾ã å®£è¨ããã¦ããªãï¼ãã¼ãã«ã¡ã¿ãã¼ã¿ãéå¸¸ã®pickle.loadsï¼ï¼/ dumpsï¼ï¼ã¯ãä»¥åã®ããæç¹ã§æ¢å­ã®ãã¼ã¿ãã¼ã¹ããåæ ããã &quot;MetaData&quot;ãªãã¸ã§ã¯ããå®å¨ã«ãã³ãããããã«ä½¿ç¨ã§ãã¾ããã·ãªã¢ã©ã¤ã¶ã¢ã¸ã¥ã¼ã«ã¯ãéã®å ´åã«ç¹ã«é©ãã¦ãã¾ããããã§ã¯ããã¼ãã«ã®ã¡ã¿ãã¼ã¿ããã§ã«ã¡ã¢ãªã«å­å¨ãã¦ãã¾ãã ã·ãªã¢ã©ã¤ã¶ã¢ã¸ã¥ã¼ã«ã¯ãã¯ã¨ãªæ§é ã«ã®ã¿é©ãã¦ãã¾ããããã¯å¿è¦ã§ã¯ããã¾ããï¼ ä½¿ç¨æ³ã¯ãæ¨æºçãªPython pickleã¢ã¸ã¥ã¼ã«ã®ä½¿ç¨æ³ã¨ã»ã¼åãã§ã:: ã¦ã¼ã¶ã¼å®ç¾©ã¯ã©ã¹ã®ã¤ã³ã¹ã¿ã³ã¹ãããã¯ãå¸åçãªã±ã¼ã¹ã§ã¯ãã¨ã³ã¸ã³ãã»ãã·ã§ã³ãã¾ãã¯è¡¨ç¾æ§æã¸ã®åç§ãå«ã¾ããç´æ¥ã·ãªã¢ã«åãããã¨ãã§ãã¾ãã 