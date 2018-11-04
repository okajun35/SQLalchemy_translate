Þ          L               |     }            ¢  1  }   Ô    R  V  Ù  *  0	     [  :  t  ·   ¯   A key feature of SQLAlchemy's database metadata constructs is that they are designed to be used in a *declarative* style which closely resembles that of real DDL. They are therefore most intuitive to those who have some background in creating real schema generation scripts. Database metadata can be expressed by explicitly naming the various components and their properties, using constructs such as :class:`~sqlalchemy.schema.Table`, :class:`~sqlalchemy.schema.Column`, :class:`~sqlalchemy.schema.ForeignKey` and :class:`~sqlalchemy.schema.Sequence`, all of which are imported from the ``sqlalchemy.schema`` package. It can also be generated by SQLAlchemy using a process called *reflection*, which means you start with a single object such as :class:`~sqlalchemy.schema.Table`, assign it a name, and then instruct SQLAlchemy to load all the additional information related to that name from a particular engine source. Schema Definition Language The core of SQLAlchemy's query and object mapping operations are supported by *database metadata*, which is comprised of Python objects that describe tables and other schema-level objects. These objects are at the core of three major types of operations - issuing CREATE and DROP statements (known as *DDL*), constructing SQL queries, and expressing information about structures that already exist within the database. This section references SQLAlchemy **schema metadata**, a comprehensive system of describing and inspecting database schemas. Project-Id-Version: PROJECT VERSION
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
 SQLAlchemyã®ãã¼ã¿ãã¼ã¹ã¡ã¿ãã¼ã¿ã³ã³ã¹ãã©ã¯ãã®ä¸»ãªç¹å¾´ã¯ãå®éã®DDLã¨ä¼¼ã¦ãã*å®£è¨å*ã¹ã¿ã¤ã«ã§ä½¿ç¨ããããã«è¨­è¨ããã¦ãããã¨ã§ãããããã£ã¦ãå®éã®ã¹ã­ã¼ãçæã¹ã¯ãªãããä½æããèæ¯ãæã£ã¦ããäººã«ã¨ã£ã¦ã¯ãæãç´æçã§ãã ãã¼ã¿ãã¼ã¹ã¡ã¿ãã¼ã¿ã¯ãclassï¼ `ãsqlalchemy.schema.Table`ãï¼classï¼`ãsqlalchemy.schema.Column`ãï¼classï¼ `ãsqlalchemyãªã©ã®æ§æãä½¿ç¨ãã¦ããã¾ãã¾ãªã³ã³ãã¼ãã³ãã¨ãã®ãã­ããã£ãæç¤ºçã«å½åãããã¨ã§è¡¨ç¾ã§ãã¾ããã¹ã­ã¼ã.ForeignKey`ã¨ï¼classï¼ `ãsqlalchemy.schema.Sequence`ãå«ã¿ããããã¯ãã¹ã¦` `sqlalchemy.schema``ããã±ã¼ã¸ããã¤ã³ãã¼ãããã¾ãã * reflection *ã¨ããååã®ãã­ã»ã¹ãä½¿ã£ã¦SQLAlchemyã§çæãããã¨ãã§ãã¾ããã¤ã¾ããclassï¼ `ãsqlalchemy.schema.Table`ã®ãããªåä¸ã®ãªãã¸ã§ã¯ãããå§ããååãä»ãã¦ããSQLAlchemyã«ãã¹ã¦ã®ç¹å®ã®ã¨ã³ã¸ã³ã½ã¼ã¹ãããã®ååã«é¢é£ããè¿½å æå ±ã ã¹ã­ã¼ãå®ç¾©è¨èª SQLAlchemyã®ã¯ã¨ãªã¨ãªãã¸ã§ã¯ããããã³ã°æä½ã®ä¸­æ ¸ã¯ããã¼ãã«ãä»ã®ã¹ã­ã¼ãã¬ãã«ã®ãªãã¸ã§ã¯ããè¨è¿°ããPythonãªãã¸ã§ã¯ãã§æ§æããã*ãã¼ã¿ãã¼ã¹ã¡ã¿ãã¼ã¿*ã«ãã£ã¦ãµãã¼ãããã¦ãã¾ãããããã®ãªãã¸ã§ã¯ãã¯ãCREATEããã³DROPã¹ãã¼ãã¡ã³ãï¼* DDL *ã¨å¼ã°ããï¼ã®çºè¡ãSQLç§ä¼ã®ä½æãããã³ãã¼ã¿ãã¼ã¹åã«ãã§ã«å­å¨ããæ§é ã«é¢ããæå ±ã®è¡¨ç¾ã®3ã¤ã®ä¸»ãªã¿ã¤ãã®æä½ã®ä¸­æ ¸ãæãã¦ãã¾ãã ãã®ã»ã¯ã·ã§ã³ã§ã¯ããã¼ã¿ãã¼ã¹ã¹ã­ã¼ãã®è¨è¿°ã¨æ¤æ»ã®åæ¬çãªã·ã¹ãã ã§ããSQLAlchemy **ã¹ã­ã¼ãã¡ã¿ãã¼ã¿**ãåç§ãã¦ãã¾ãã 