��    ,      |              �  �   �  �   �  �   �  ~   a  �   �  f   �  [        o  -   �  �  �  �  }	  �   &     �  '  �  l     n   �  o   �  W   `     �  F   �  `     -     V   �  �     �  �  �  U  �  �  f  �     ,  D   >  �   �  �   ?  �    �  �  L   �  �   �    �  �  �  
  B!  C   M#  h   �#  �  �#  Q   �%  x  $&  �   �'  �   d(  �   Q)  ~   !*  �   �*  f   l+  [   �+     /,  -   L,  �  z,  �  =.  �   �/     �0  '  �0  l   �1  n   A2  o   �2  W    3     x3  F   �3  `   �3  -   ?4  V   m4  �   �4  �  X5  �  7  �  �8  f  �;     �<  D   �<  �   C=  �   �=  �  �>  �  z@  L   TB  �   �B    TC  �  hD  
  F  C   H  h   QH  �  �H  Q   �J   :attr:`.Mapper.all_orm_descriptors` - namespace of all mapped attributes, plus user-defined attributes defined using systems such as :class:`.hybrid_property`, :class:`.AssociationProxy` and others. :attr:`.Mapper.attrs` - a namespace of all mapped attributes.  The attributes themselves are instances of :class:`.MapperProperty`, which contain additional attributes that can lead to the mapped SQL expression or column, if applicable. :attr:`.Mapper.column_attrs` - the mapped attribute namespace limited to column and SQL expression attributes.   You might want to use :attr:`.Mapper.columns` to get at the :class:`.Column` objects directly. :attr:`.Mapper.columns` - A namespace of :class:`.Column` objects and other named SQL expressions associated with the mapping. :attr:`.Mapper.local_table` - The :class:`.Table` that is "local" to this mapper; this differs from :attr:`.Mapper.mapped_table` in the case of a mapper mapped using inheritance to a composed selectable. :attr:`.Mapper.mapped_table` - The :class:`.Table` or other selectable to which this mapper is mapped. :attr:`.Mapper.relationships` - namespace of all :class:`.RelationshipProperty` attributes. :ref:`subqueryload_ordering` A mapping which resolves this is as follows:: A relational database can return rows in any arbitrary order, when an explicit ordering is not set. While this ordering very often corresponds to the natural order of rows within a table, this is not the case for all databases and all queries.   The consequence of this is that any query that limits rows using ``LIMIT`` or ``OFFSET`` should **always** specify an ``ORDER BY``. Otherwise, it is not deterministic which rows will actually be returned. Above, we receive two ``addresses`` rows for ``user.id`` of 2, and none for 1.  We've wasted two rows and failed to actually load the collection.  This is an insidious error because without looking at the SQL and the results, the ORM will not show that there's any issue; if we access the ``addresses`` for the ``User`` we have, it will emit a lazy load for the collection and we won't see that anything actually went wrong. All tables in a relational database should have primary keys.   Even a many-to-many association table - the primary key would be the composite of the two association columns:: Are you doing this?:: As of SQLAlchemy version 0.9.5, the above condition is detected, and will warn that the ``id`` column of ``A`` and ``B`` is being combined under the same-named attribute ``id``, which above is a serious issue since it means that a ``B`` object's primary key will always mirror that of its ``A``. Better yet is when using fully declared table metadata, use the ``primary_key=True`` flag on those columns:: Column-based attributes can be given any name desired in the mapping. See :ref:`mapper_column_distinct_names`. Depending on database specifics, there is a chance we may get a result like the following for the two queries:: From there, all information about the class can be accessed through properties such as: Given the example as follows:: How do I configure a Column that is a Python reserved word or similar? How do I get a list of all columns, relationships, mapped attributes, etc. given a mapped class? How do I map a table that has no primary key? I'm getting a warning or error about "Implicitly combining column X under attribute Y" I'm using Declarative and setting primaryjoin/secondaryjoin using an ``and_()`` or ``or_()``, and I am getting an error message about foreign keys. In almost all cases, a table does have a so-called :term:`candidate key`, which is a column or series of columns that uniquely identify a row.  If a table truly doesn't have this, and has actual fully duplicate rows, the table is not corresponding to `first normal form <http://en.wikipedia.org/wiki/First_normal_form>`_ and cannot be mapped.   Otherwise, whatever columns comprise the best candidate key can be applied directly to the mapper:: It's important to note that we're only talking about the SQLAlchemy ORM; an application which builds on Core and deals only with :class:`.Table` objects, :func:`.select` constructs and the like, **does not** need any primary key to be present on or associated with a table in any way (though again, in SQL, all tables should really have some kind of primary key, lest you need to actually update or delete specific rows). Most ORMs require that objects have some kind of primary key defined because the object in memory must correspond to a uniquely identifiable row in the database table; at the very least, this allows the object can be targeted for UPDATE and DELETE statements which will affect only that object's row and no other.   However, the importance of the primary key goes far beyond that.  In SQLAlchemy, all ORM-mapped objects are at all times linked uniquely within a :class:`.Session` to their specific database row using a pattern called the :term:`identity map`, a pattern that's central to the unit of work system employed by SQLAlchemy, and is also key to the most common (and not-so-common) patterns of ORM usage. Note that the :func:`.joinedload` eager loader strategy does not suffer from the same problem because only one query is ever issued, so the load query cannot be different from the main query.  Similarly, the :func:`.selectinload` eager loader strategy also does not have this issue as it links its collection loads directly to primary key values just loaded. ORM Configuration Or if the objects you need are already available, skip the strings:: SQLAlchemy implements :func:`.orm.subqueryload` by issuing a separate query, the results of which are matched up to the results from the first query. We see two queries emitted like this: Suppose we did want ``A.id`` and ``B.id`` to be mirrors of each other, despite the fact that ``B.a_id`` is where ``A.id`` is related.  We could combine them together using :func:`.column_property`:: That's an ``and_()`` of two string expressions, which SQLAlchemy cannot apply any mapping towards.  Declarative allows :func:`.relationship` arguments to be specified as strings, which are converted into expression objects using ``eval()``.   But this doesn't occur inside of an ``and_()`` expression - it's a special operation declarative applies only to the *entirety* of what's passed to primaryjoin or other arguments as a string:: The SQLAlchemy ORM, in order to map to a particular table, needs there to be at least one column denoted as a primary key column; multiple-column, i.e. composite, primary keys are of course entirely feasible as well.  These columns do **not** need to be actually known to the database as primary key columns, though it's a good idea that they are.  It's only necessary that the columns *behave* as a primary key does, e.g. as a unique and not nullable identifier for a row. The same idea applies to all the other arguments, such as ``foreign_keys``:: The second query embeds the first query as a source of rows. When the inner query uses ``OFFSET`` and/or ``LIMIT`` without ordering, the two queries may not see the same results: The solution to this problem is to always specify a deterministic sort order, so that the main query always returns the same set of rows. This generally means that you should :meth:`.Query.order_by` on a unique column on the table. The primary key is a good choice for this:: This behavior is often desirable and is allowed without warning in the case where the two columns are linked together via a foreign key relationship within an inheritance mapping.   When the warning or exception occurs, the issue can be resolved by either assigning the columns to differently-named attributes, or if combining them together is desired, by using :func:`.column_property` to make this explicit. This condition refers to when a mapping contains two columns that are being mapped under the same attribute name due to their name, but there's no indication that this is intentional.  A mapped class needs to have explicit names for every attribute that is to store an independent value; when two columns have the same name and aren't disambiguated, they fall under the same attribute and the effect is that the value from one column is **copied** into the other, based on which column was assigned to the attribute first. This information is all available from the :class:`.Mapper` object. To get at the :class:`.Mapper` for a particular mapped class, call the :func:`.inspect` function on it:: When we use a SQLAlchemy method like :meth:`.Query.first`, we are in fact applying a ``LIMIT`` of one to the query, so without an explicit ordering it is not deterministic what row we actually get back. While we may not notice this for simple queries on databases that usually returns rows in their natural order, it becomes much more of an issue if we also use :func:`.orm.subqueryload` to load related collections, and we may not be loading the collections as intended. Why is ``ORDER BY`` required with ``LIMIT`` (especially with ``subqueryload()``)? Project-Id-Version: SQLAlchemy 1.3
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2018-10-06 18:59+0900
PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE
Last-Translator: FULL NAME <EMAIL@ADDRESS>
Language: ja
Language-Team: ja <LL@li.org>
Plural-Forms: nplurals=1; plural=0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.6.0
 :attr:`.Mapper.all_orm_descriptors` - namespace of all mapped attributes, plus user-defined attributes defined using systems such as :class:`.hybrid_property`, :class:`.AssociationProxy` and others. :attr:`.Mapper.attrs` - a namespace of all mapped attributes.  The attributes themselves are instances of :class:`.MapperProperty`, which contain additional attributes that can lead to the mapped SQL expression or column, if applicable. :attr:`.Mapper.column_attrs` - the mapped attribute namespace limited to column and SQL expression attributes.   You might want to use :attr:`.Mapper.columns` to get at the :class:`.Column` objects directly. :attr:`.Mapper.columns` - A namespace of :class:`.Column` objects and other named SQL expressions associated with the mapping. :attr:`.Mapper.local_table` - The :class:`.Table` that is "local" to this mapper; this differs from :attr:`.Mapper.mapped_table` in the case of a mapper mapped using inheritance to a composed selectable. :attr:`.Mapper.mapped_table` - The :class:`.Table` or other selectable to which this mapper is mapped. :attr:`.Mapper.relationships` - namespace of all :class:`.RelationshipProperty` attributes. :ref:`subqueryload_ordering` A mapping which resolves this is as follows:: A relational database can return rows in any arbitrary order, when an explicit ordering is not set. While this ordering very often corresponds to the natural order of rows within a table, this is not the case for all databases and all queries.   The consequence of this is that any query that limits rows using ``LIMIT`` or ``OFFSET`` should **always** specify an ``ORDER BY``. Otherwise, it is not deterministic which rows will actually be returned. Above, we receive two ``addresses`` rows for ``user.id`` of 2, and none for 1.  We've wasted two rows and failed to actually load the collection.  This is an insidious error because without looking at the SQL and the results, the ORM will not show that there's any issue; if we access the ``addresses`` for the ``User`` we have, it will emit a lazy load for the collection and we won't see that anything actually went wrong. All tables in a relational database should have primary keys.   Even a many-to-many association table - the primary key would be the composite of the two association columns:: Are you doing this?:: As of SQLAlchemy version 0.9.5, the above condition is detected, and will warn that the ``id`` column of ``A`` and ``B`` is being combined under the same-named attribute ``id``, which above is a serious issue since it means that a ``B`` object's primary key will always mirror that of its ``A``. Better yet is when using fully declared table metadata, use the ``primary_key=True`` flag on those columns:: Column-based attributes can be given any name desired in the mapping. See :ref:`mapper_column_distinct_names`. Depending on database specifics, there is a chance we may get a result like the following for the two queries:: From there, all information about the class can be accessed through properties such as: Given the example as follows:: How do I configure a Column that is a Python reserved word or similar? How do I get a list of all columns, relationships, mapped attributes, etc. given a mapped class? How do I map a table that has no primary key? I'm getting a warning or error about "Implicitly combining column X under attribute Y" I'm using Declarative and setting primaryjoin/secondaryjoin using an ``and_()`` or ``or_()``, and I am getting an error message about foreign keys. In almost all cases, a table does have a so-called :term:`candidate key`, which is a column or series of columns that uniquely identify a row.  If a table truly doesn't have this, and has actual fully duplicate rows, the table is not corresponding to `first normal form <http://en.wikipedia.org/wiki/First_normal_form>`_ and cannot be mapped.   Otherwise, whatever columns comprise the best candidate key can be applied directly to the mapper:: It's important to note that we're only talking about the SQLAlchemy ORM; an application which builds on Core and deals only with :class:`.Table` objects, :func:`.select` constructs and the like, **does not** need any primary key to be present on or associated with a table in any way (though again, in SQL, all tables should really have some kind of primary key, lest you need to actually update or delete specific rows). Most ORMs require that objects have some kind of primary key defined because the object in memory must correspond to a uniquely identifiable row in the database table; at the very least, this allows the object can be targeted for UPDATE and DELETE statements which will affect only that object's row and no other.   However, the importance of the primary key goes far beyond that.  In SQLAlchemy, all ORM-mapped objects are at all times linked uniquely within a :class:`.Session` to their specific database row using a pattern called the :term:`identity map`, a pattern that's central to the unit of work system employed by SQLAlchemy, and is also key to the most common (and not-so-common) patterns of ORM usage. Note that the :func:`.joinedload` eager loader strategy does not suffer from the same problem because only one query is ever issued, so the load query cannot be different from the main query.  Similarly, the :func:`.selectinload` eager loader strategy also does not have this issue as it links its collection loads directly to primary key values just loaded. ORM Configuration Or if the objects you need are already available, skip the strings:: SQLAlchemy implements :func:`.orm.subqueryload` by issuing a separate query, the results of which are matched up to the results from the first query. We see two queries emitted like this: Suppose we did want ``A.id`` and ``B.id`` to be mirrors of each other, despite the fact that ``B.a_id`` is where ``A.id`` is related.  We could combine them together using :func:`.column_property`:: That's an ``and_()`` of two string expressions, which SQLAlchemy cannot apply any mapping towards.  Declarative allows :func:`.relationship` arguments to be specified as strings, which are converted into expression objects using ``eval()``.   But this doesn't occur inside of an ``and_()`` expression - it's a special operation declarative applies only to the *entirety* of what's passed to primaryjoin or other arguments as a string:: The SQLAlchemy ORM, in order to map to a particular table, needs there to be at least one column denoted as a primary key column; multiple-column, i.e. composite, primary keys are of course entirely feasible as well.  These columns do **not** need to be actually known to the database as primary key columns, though it's a good idea that they are.  It's only necessary that the columns *behave* as a primary key does, e.g. as a unique and not nullable identifier for a row. The same idea applies to all the other arguments, such as ``foreign_keys``:: The second query embeds the first query as a source of rows. When the inner query uses ``OFFSET`` and/or ``LIMIT`` without ordering, the two queries may not see the same results: The solution to this problem is to always specify a deterministic sort order, so that the main query always returns the same set of rows. This generally means that you should :meth:`.Query.order_by` on a unique column on the table. The primary key is a good choice for this:: This behavior is often desirable and is allowed without warning in the case where the two columns are linked together via a foreign key relationship within an inheritance mapping.   When the warning or exception occurs, the issue can be resolved by either assigning the columns to differently-named attributes, or if combining them together is desired, by using :func:`.column_property` to make this explicit. This condition refers to when a mapping contains two columns that are being mapped under the same attribute name due to their name, but there's no indication that this is intentional.  A mapped class needs to have explicit names for every attribute that is to store an independent value; when two columns have the same name and aren't disambiguated, they fall under the same attribute and the effect is that the value from one column is **copied** into the other, based on which column was assigned to the attribute first. This information is all available from the :class:`.Mapper` object. To get at the :class:`.Mapper` for a particular mapped class, call the :func:`.inspect` function on it:: When we use a SQLAlchemy method like :meth:`.Query.first`, we are in fact applying a ``LIMIT`` of one to the query, so without an explicit ordering it is not deterministic what row we actually get back. While we may not notice this for simple queries on databases that usually returns rows in their natural order, it becomes much more of an issue if we also use :func:`.orm.subqueryload` to load related collections, and we may not be loading the collections as intended. Why is ``ORDER BY`` required with ``LIMIT`` (especially with ``subqueryload()``)? 