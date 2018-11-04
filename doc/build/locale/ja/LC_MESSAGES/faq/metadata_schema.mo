Þ          ´               L  È  M         °  _   Ä  Ì   $  >   ñ  :   0  L   k     ¸     Ê  K   S          :  I   Æ     	  D   	  ,  Õ	  0       3  	  º  Þ   Ä    £  }   C  *  Á  j   ì  c   W     »     ?  ¨   \  O     ë   U  ­   A  [   ï     K  J   á  p  ,  8      :class:`.Table` and :class:`.Column` are not good targets for direct subclassing. However, there are simple ways to get on-construction behaviors using creation functions, and behaviors related to the linkages between schema objects such as constraint conventions or naming conventions using attachment events. An example of many of these techniques can be seen at `Naming Conventions <http://www.sqlalchemy.org/trac/wiki/UsageRecipes/NamingConventions>`_. A more comprehensive option is to use schema migration tools, such as Alembic or SQLAlchemy-Migrate; see :ref:`schema_migrations` for discussion on this. Above, a connection pool connection is still checked out; furthermore, the result object above also maintains a link to this connection.  If "implicit execution" is used, the result will hold this connection opened until the result object is closed or all rows are exhausted. Does SQLAlchemy support ALTER TABLE, CREATE VIEW, CREATE TRIGGER, Schema Upgrade Functionality? General ALTER support isn't present in SQLAlchemy directly.  For special DDL on an ad-hoc basis, the :class:`.DDL` and related constructs can be used. See :doc:`core/ddl` for a discussion on this subject. How can I get the CREATE TABLE/ DROP TABLE output as a string? How can I sort Table objects in order of their dependency? How can I subclass Table/Column to provide certain behaviors/configurations? MetaData / Schema Modern SQLAlchemy has clause constructs which represent DDL operations. These can be rendered to strings like any other SQL expression:: My program is hanging when I say ``table.drop()`` / ``metadata.drop_all()`` The `Alembic <https://bitbucket.org/zzzeek/alembic>`_ tool also supports an "offline" SQL generation mode that renders database migrations as SQL scripts. The call to ``mytable.drop(engine)`` attempts to emit DROP TABLE on a second connection procured from the :class:`.Engine` which will lock. The solution is to close out all connections before emitting DROP TABLE:: There's also a special form of :class:`.Engine` that can let you dump an entire metadata creation sequence, using this recipe:: This is available via the :attr:`.MetaData.sorted_tables` function:: This usually corresponds to two conditions: 1. using PostgreSQL, which is really strict about table locks, and 2. you have a connection still open which contains locks on the table and is distinct from the connection being used for the DROP statement.  Heres the most minimal version of the pattern:: To get the string specific to a certain engine:: Project-Id-Version: PROJECT VERSION
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
 ï¼classï¼ `.Table`ã¨ï¼classï¼` .Column`ã¯ç´æ¥ãµãã¯ã©ã¹åã®è¯ãã¿ã¼ã²ããã§ã¯ããã¾ããããã ããä½æé¢æ°ãä½¿ç¨ãã¦æ§ç¯æã®ããã¤ãã¢ãåå¾ããç°¡åãªæ¹æ³ããã¹ã­ã¼ãã»ãªãã¸ã§ã¯ãéã®ãªã³ã±ã¼ã¸ã«é¢é£ããããã¤ãã¢ï¼ã¢ã¿ããã»ã¤ãã³ããä½¿ç¨ããå½åè¦åãªã©ï¼ãããã¾ãããããã®æè¡ã®å¤ãã®ä¾ã¯ããå½åè¦åã <http://www.sqlalchemy.org/trac/wiki/UsageRecipes/NamingConventions> `_ã ããåæ¬çãªãªãã·ã§ã³ã¯ãAlembicãSQLAlchemy-Migrateãªã©ã®ã¹ã­ã¼ãç§»è¡ãã¼ã«ãä½¿ç¨ãããã¨ã§ããããã«ã¤ãã¦ã®è­°è«ã¯ï¼refï¼ `schema_migrations`ãåç§ãã¦ãã ããã ä¸è¨ã®å ´åãæ¥ç¶ãã¼ã«ã®æ¥ç¶ã¯ã¾ã ãã§ãã¯ã¢ã¦ãããã¦ãã¾ããããã«ãä¸è¨ã®çµæãªãã¸ã§ã¯ãã¯ããã®æ¥ç¶ã¸ã®ãªã³ã¯ãä¿æãã¾ãã \ &quot;æé»ã®å®è¡\&quot;ãä½¿ç¨ããã¦ããå ´åãçµæã¯ãçµæãªãã¸ã§ã¯ããã¯ã­ã¼ãºãããã¾ã§ãã¾ãã¯ãã¹ã¦ã®è¡ãä½¿ãæããããã¾ã§ããã®æ¥ç¶ãä¿æãã¾ãã SQLAlchemyã¯ãALTER TABLEãCREATE VIEWãCREATE TRIGGERãSchema Upgrade Functionalityããµãã¼ããã¦ãã¾ããï¼ ä¸è¬çãªALTERãµãã¼ãã¯ãSQLAlchemyã«ã¯ç´æ¥å­å¨ãã¾ãããã¢ãããã¯ãã¼ã¹ã®ç¹å¥ãªDDLã®å ´åãï¼classï¼ `.DDL`ã¨ããã«é¢é£ããæ§é ä½ãä½¿ç¨ã§ãã¾ãããã®ä»¶ã«é¢ããè­°è«ã«ã¤ãã¦ã¯ãdocï¼ `core / ddl`ãåç§ãã¦ãã ããã CREATE TABLE / DROP TABLEã®åºåãæå­åã¨ãã¦åå¾ããã«ã¯ã©ãããã°ããã§ããï¼ ä¾å­é¢ä¿ã®é åºã§ãã¼ãã«ãªãã¸ã§ã¯ããã©ã®ããã«ã½ã¼ãã§ãã¾ããï¼ ç¹å®ã®åä½/æ§æãæä¾ããããã«ããã¼ãã«/åããµãã¯ã©ã¹åããã«ã¯ã©ãããã°ããã§ããï¼ ã¡ã¿ãã¼ã¿/ã¹ã­ã¼ã ç¾ä»£ã®SQLAlchemyã«ã¯ãDDLæä½ãè¡¨ãç¯æ§é ãããã¾ãããããã¯ä»ã®SQLå¼ã®ããã«æå­åã«ã¬ã³ããªã³ã°ãããã¨ãã§ãã¾ã:: ç§ã®ãã­ã°ã©ã ã¯ `` table.dropï¼ï¼ `` / `` metadata.drop_allï¼ï¼ `` ãã¢ã¬ã ãã¢<https://bitbucket.org/zzzeek/alembic> `_ toolã¯ããã¼ã¿ãã¼ã¹ç§»è¡ãSQLââã¹ã¯ãªããã¨ãã¦ã¬ã³ããªã³ã°ãã\&quot;ãªãã©ã¤ã³\ &quot;SQLçæã¢ã¼ãããµãã¼ããã¦ãã¾ãã `` mytable.dropï¼engineï¼ ``ã®å¼ã³åºãã¯ãã­ãã¯ãããï¼classï¼ `.Engine`ããèª¿éããã2çªç®ã®æ¥ç¶ã§DROP TABLEãéåºãããã¨ãã¾ãã è§£æ±ºç­ã¯ããã¹ã¦ã®æ¥ç¶ãéãã¦ããDROP TABLE ::ãçºè¡ãããã¨ã§ã ãã®ã¬ã·ããä½¿ç¨ãã¦ã¡ã¿ãã¼ã¿ä½æã·ã¼ã±ã³ã¹å¨ä½ããã³ãã§ããç¹å¥ãªå½¢å¼ã®ï¼classï¼ `.Engine`ãããã¾ã:: ããã¯ï¼attrï¼ `.MetaData.sorted_tables`é¢æ°ã§å©ç¨ã§ãã¾ã:: ããã¯ãéå¸¸ãæ¬¡ã®2ã¤ã®æ¡ä»¶ã«å¯¾å¿ãã¾ãã1. PostgreSQLãä½¿ç¨ãããããã¯ãã¼ãã«ã­ãã¯ã«ã¤ãã¦å³å¯ã«å³å¯ãªãã®ã§ããã2. DROPã¹ãã¼ãã¡ã³ãã§ä½¿ç¨ããã¦ããæ¥ç¶ã¨ã¯ç°ãªãããã¼ãã«ã®ã­ãã¯ãå«ãæ¥ç¶ãã¾ã éãã¦ããããã¿ã¼ã³ã®æå°éã®ãã¼ã¸ã§ã³ãå¾ã¾ã:: ç¹å®ã®ã¨ã³ã¸ã³åºæã®æå­åãåå¾ãã:: 