��                          �     n  �  \   �  �   [  2     �   S    �  (    P   ;
  �   �
  W   $  /   |  $   �  >  �  8       I  �   N  C   �  �  @  �   8  �  �  �   �  �  Z  �  #     �             s   6    �  "   �  x  �  �   f  n  �  \   W  �   �  2  y   �   �!    T"  (  k#  P   �%  �   �%  W   }&  /   �&  $   '  >  *'  8   i)    �)  �   �+  C   U,  �  �,  �   �.  �  T/  �   �0  �  �1  �  |3     Q5     `5     y5  s   �5    6  "   #7   Above, the ``fullname`` attribute is interpreted at both the instance and class level, so that it is available from an instance:: An option exists which can apply the ad-hoc ``A.x + A.y`` expression to the returned ``A`` objects instead of as a separate tuple entry; this is the :func:`.with_expression` query option in conjunction with the :func:`.query_expression` attribute mapping.    The class is mapped to include a placeholder attribute where any particular SQL expression may be applied:: Attributes on a mapped class can be linked to SQL expressions, which can be used in queries. Correlated subqueries may be used as well.  Below we use the :func:`.select` construct to create a SELECT that links together the count of ``Address`` objects available for a particular ``User``:: Disadvantages to using :func:`.orm.column_property` for SQL expressions include that the expression must be compatible with the SELECT statement emitted for the class as a whole, and there are also some configurational quirks which can occur when using :func:`.orm.column_property` from declarative mixins. For many-to-many relationships, use :func:`.and_` to join the fields of the association table to both tables in a relation, illustrated here with a classical mapping:: If import issues prevent the :func:`.column_property` from being defined inline with the class, it can be assigned to the class after both are configured.   In Declarative this has the effect of calling :meth:`.Mapper.add_property` to add an additional property after the fact:: In cases where a SQL query more elaborate than what :func:`.orm.column_property` or :class:`.hybrid_property` can provide must be emitted, a regular Python function accessed as an attribute can be used, assuming the expression only needs to be available on an already-loaded instance.   The function is decorated with Python's own ``@property`` decorator to mark it as a read-only attribute.   Within the function, :func:`.object_session` is used to locate the :class:`.Session` corresponding to the current object, which is then used to emit a query:: In the above example, we define a :func:`.select` construct like the following:: On an object where :func:`.query_expression` were not used to populate the attribute, the attribute on an object instance will have the value ``None``. Our "fullname" example can be expressed using :func:`.orm.column_property` as follows:: Query-time SQL expressions as mapped attributes SQL Expressions as Mapped Attributes The :func:`.orm.column_property` function can be used to map a SQL expression in a manner similar to a regularly mapped :class:`.Column`. With this technique, the attribute is loaded along with all other column-mapped attributes at load time.  This is in some cases an advantage over the usage of hybrids, as the value can be loaded up front at the same time as the parent row of the object, particularly if the expression is one which links to other tables (typically as a correlated subquery) to access data that wouldn't normally be available on an already loaded object. The :func:`.query_expression` mapping has these caveats: The :meth:`.select.correlate_except` directive indicates that each element in the FROM clause of this :func:`.select` may be omitted from the FROM list (that is, correlated to the enclosing SELECT statement against ``User``) except for the one corresponding to ``Address``.  This isn't strictly necessary, but prevents ``Address`` from being inadvertently omitted from the FROM list in the case of a long string of joins between ``User`` and ``Address`` tables where SELECT statements against ``Address`` are nested. The ``A.expr`` expression will resolve to NULL in the above WHERE clause and ORDER BY clause. To use the expression throughout the query, assign to a variable and use that:: The above query returns tuples of the form ``(A object, integer)``. The easiest and most flexible way to link relatively simple SQL expressions to a class is to use a so-called "hybrid attribute", described in the section :ref:`hybrids_toplevel`.  The hybrid provides for an expression that works at both the Python level as well as at the SQL expression level.  For example, below we map a class ``User``, containing attributes ``firstname`` and ``lastname``, and include a hybrid that will provide for us the ``fullname``, which is the string concatenation of the two:: The mapped attribute currently **cannot** be applied to other parts of the query, such as the WHERE clause, the ORDER BY clause, and make use of the ad-hoc expression; that is, this won't work:: The meaning of the above statement is, select the count of ``Address.id`` rows where the ``Address.user_id`` column is equated to ``id``, which in the context of the ``User`` class is the :class:`.Column` named ``id`` (note that ``id`` is also the name of a Python built in function, which is not what we want to use here - if we were outside of the ``User`` class definition, we'd use ``User.id``). The plain descriptor approach is useful as a last resort, but is less performant in the usual case than both the hybrid and column property approaches, in that it needs to emit a SQL query upon each access. The query_expression value **does not refresh when the object is expired**.  Once the object is expired, either via :meth:`.Session.expire` or via the expire_on_commit behavior of :meth:`.Session.commit`, the value is removed from the attribute and will return ``None`` on subsequent access. Only by running a new :class:`.Query` that touches the object which includes a new :func:`.with_expression` directive will the attribute be set to a non-None value. The string concatenation example is a simple one, where the Python expression can be dual purposed at the instance and class level.  Often, the SQL expression must be distinguished from the Python expression, which can be achieved using :meth:`.hybrid_property.expression`.  Below we illustrate the case where a conditional needs to be present inside the hybrid, using the ``if`` statement in Python and the :func:`.sql.expression.case` construct for SQL expressions:: Using a Hybrid Using a plain descriptor Using column_property We can then query for objects of type ``A``, applying an arbitrary SQL expression to be populated into ``A.expr``:: When using :meth:`.Session.query`, we have the option to specify not just mapped entities but ad-hoc SQL expressions as well.  Suppose if a class ``A`` had integer attributes ``.x`` and ``.y``, we could query for ``A`` objects, and additionally the sum of ``.x`` and ``.y``, as follows:: as well as usable within queries:: Project-Id-Version: SQLAlchemy 1.3
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
 Above, the ``fullname`` attribute is interpreted at both the instance and class level, so that it is available from an instance:: An option exists which can apply the ad-hoc ``A.x + A.y`` expression to the returned ``A`` objects instead of as a separate tuple entry; this is the :func:`.with_expression` query option in conjunction with the :func:`.query_expression` attribute mapping.    The class is mapped to include a placeholder attribute where any particular SQL expression may be applied:: Attributes on a mapped class can be linked to SQL expressions, which can be used in queries. Correlated subqueries may be used as well.  Below we use the :func:`.select` construct to create a SELECT that links together the count of ``Address`` objects available for a particular ``User``:: Disadvantages to using :func:`.orm.column_property` for SQL expressions include that the expression must be compatible with the SELECT statement emitted for the class as a whole, and there are also some configurational quirks which can occur when using :func:`.orm.column_property` from declarative mixins. For many-to-many relationships, use :func:`.and_` to join the fields of the association table to both tables in a relation, illustrated here with a classical mapping:: If import issues prevent the :func:`.column_property` from being defined inline with the class, it can be assigned to the class after both are configured.   In Declarative this has the effect of calling :meth:`.Mapper.add_property` to add an additional property after the fact:: In cases where a SQL query more elaborate than what :func:`.orm.column_property` or :class:`.hybrid_property` can provide must be emitted, a regular Python function accessed as an attribute can be used, assuming the expression only needs to be available on an already-loaded instance.   The function is decorated with Python's own ``@property`` decorator to mark it as a read-only attribute.   Within the function, :func:`.object_session` is used to locate the :class:`.Session` corresponding to the current object, which is then used to emit a query:: In the above example, we define a :func:`.select` construct like the following:: On an object where :func:`.query_expression` were not used to populate the attribute, the attribute on an object instance will have the value ``None``. Our "fullname" example can be expressed using :func:`.orm.column_property` as follows:: Query-time SQL expressions as mapped attributes SQL Expressions as Mapped Attributes The :func:`.orm.column_property` function can be used to map a SQL expression in a manner similar to a regularly mapped :class:`.Column`. With this technique, the attribute is loaded along with all other column-mapped attributes at load time.  This is in some cases an advantage over the usage of hybrids, as the value can be loaded up front at the same time as the parent row of the object, particularly if the expression is one which links to other tables (typically as a correlated subquery) to access data that wouldn't normally be available on an already loaded object. The :func:`.query_expression` mapping has these caveats: The :meth:`.select.correlate_except` directive indicates that each element in the FROM clause of this :func:`.select` may be omitted from the FROM list (that is, correlated to the enclosing SELECT statement against ``User``) except for the one corresponding to ``Address``.  This isn't strictly necessary, but prevents ``Address`` from being inadvertently omitted from the FROM list in the case of a long string of joins between ``User`` and ``Address`` tables where SELECT statements against ``Address`` are nested. The ``A.expr`` expression will resolve to NULL in the above WHERE clause and ORDER BY clause. To use the expression throughout the query, assign to a variable and use that:: The above query returns tuples of the form ``(A object, integer)``. The easiest and most flexible way to link relatively simple SQL expressions to a class is to use a so-called "hybrid attribute", described in the section :ref:`hybrids_toplevel`.  The hybrid provides for an expression that works at both the Python level as well as at the SQL expression level.  For example, below we map a class ``User``, containing attributes ``firstname`` and ``lastname``, and include a hybrid that will provide for us the ``fullname``, which is the string concatenation of the two:: The mapped attribute currently **cannot** be applied to other parts of the query, such as the WHERE clause, the ORDER BY clause, and make use of the ad-hoc expression; that is, this won't work:: The meaning of the above statement is, select the count of ``Address.id`` rows where the ``Address.user_id`` column is equated to ``id``, which in the context of the ``User`` class is the :class:`.Column` named ``id`` (note that ``id`` is also the name of a Python built in function, which is not what we want to use here - if we were outside of the ``User`` class definition, we'd use ``User.id``). The plain descriptor approach is useful as a last resort, but is less performant in the usual case than both the hybrid and column property approaches, in that it needs to emit a SQL query upon each access. The query_expression value **does not refresh when the object is expired**.  Once the object is expired, either via :meth:`.Session.expire` or via the expire_on_commit behavior of :meth:`.Session.commit`, the value is removed from the attribute and will return ``None`` on subsequent access. Only by running a new :class:`.Query` that touches the object which includes a new :func:`.with_expression` directive will the attribute be set to a non-None value. The string concatenation example is a simple one, where the Python expression can be dual purposed at the instance and class level.  Often, the SQL expression must be distinguished from the Python expression, which can be achieved using :meth:`.hybrid_property.expression`.  Below we illustrate the case where a conditional needs to be present inside the hybrid, using the ``if`` statement in Python and the :func:`.sql.expression.case` construct for SQL expressions:: Using a Hybrid Using a plain descriptor Using column_property We can then query for objects of type ``A``, applying an arbitrary SQL expression to be populated into ``A.expr``:: When using :meth:`.Session.query`, we have the option to specify not just mapped entities but ad-hoc SQL expressions as well.  Suppose if a class ``A`` had integer attributes ``.x`` and ``.y``, we could query for ``A`` objects, and additionally the sum of ``.x`` and ``.y``, as follows:: as well as usable within queries:: 