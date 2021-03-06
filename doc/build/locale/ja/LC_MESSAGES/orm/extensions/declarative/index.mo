Þ          <               \      ]   /  i   :      Ô  	   [    e  X  û   Declarative The Declarative system is the typically used system provided by the SQLAlchemy ORM in order to define classes mapped to relational database tables.  However, as noted in :ref:`classical_mapping`, Declarative is in fact a series of extensions that ride on top of the SQLAlchemy :func:`.mapper` construct. While the documentation typically refers to Declarative for most examples, the following sections will provide detailed information on how the Declarative API interacts with the basic :func:`.mapper` and Core :class:`.Table` systems, as well as how sophisticated patterns can be built using systems such as mixins. Project-Id-Version: PROJECT VERSION
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
 å®£è¨ç å®£è¨ã·ã¹ãã ã¯ããªã¬ã¼ã·ã§ãã«ãã¼ã¿ãã¼ã¹ãã¼ãã«ã«ãããã³ã°ãããã¯ã©ã¹ãå®ç¾©ããããã«ãSQLAlchemy ORMã«ãã£ã¦æä¾ãããä¸è¬çã«ä½¿ç¨ãããã·ã¹ãã ã§ããããããï¼refï¼ `classical_mapping`ã«è¨è¼ããã¦ããããã«ãDeclarativeã¯å®éã«ã¯SQLAlchemyï¼funcï¼` .mapper`æ§é ã®ä¸ã«ä¹ãä¸é£ã®æ¡å¼µã§ãã ãã­ã¥ã¡ã³ãã§ã¯éå¸¸ãã»ã¨ãã©ã®ä¾ã§å®£è¨åãåç§ãã¦ãã¾ãããæ¬¡ã®ã»ã¯ã·ã§ã³ã§ã¯ãå®£è¨åAPIãåºæ¬çãªï¼funcï¼ `.mapper`ã·ã¹ãã ã¨Coreï¼classï¼` .Table`ã·ã¹ãã ã¨ã®ããã¨ãã®è©³ç´°ã¨ãããã¯ã¹ã¤ã³ãªã©ã®ã·ã¹ãã ãä½¿ç¨ãã¦ãã¿ã¼ã³ãæ§ç¯ã§ãã¾ãã 