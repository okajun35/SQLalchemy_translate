��    /      �                �     �   �  �   B  �     �   �  �   �  6   u  .  �  �   �  �  _	  �    =   �  �     4  �  E   �  K       X  !   n      �  .   �  p   �  �   Q  6  �  Y     6   j  <   �  �  �  {   s  6  �  �   &  �     .   �  �  �  �  �  [   �   M  �   z   ?"  �   �"  �   ^#  7   �#  �   $  �  �$  $   �'  N   �'  �   (     �(  x  �(  �   p*  �   +  �   �+  �   s,  �   _-  �   �-  6   �.  .  /  �   >0  �  �0  �  n3  =   36  �   q6  4  �6  E   )8  K  o8     �:  !   �:      �:  .   ;  p   C;  �   �;  6  <<  Y   s>  6   �>  <   ?  �  A?  {   �@  6  RA  �   �B  �   kC  .   D  �  KD  �  F  [   �G  M  TH  z   �I  �   J  �   �J  7   BK  �   zK  �  ^L  $   O  N   +O  �   zO     JP   ...will map the ``Address`` class to the ``address_table`` table, including all columns present except ``street``, ``city``, ``state``, and ``zip``. ...will map the ``User`` class to the ``user_table`` table, only including the ``user_id`` and ``user_name`` columns - the rest are not referenced. Similarly:: :func:`.column_property` is also used to map a single attribute to multiple columns.  This use case arises when mapping to a :func:`~.expression.join` which has attributes which are equated to each other:: A mapping by default shares the same name for a :class:`.Column` as that of the mapped attribute - specifically it matches the :attr:`.Column.key` attribute on :class:`.Column`, which by default is the same as the :attr:`.Column.name`. A quick approach to prefix column names, typically when mapping to an existing :class:`.Table` object, is to use ``column_prefix``:: Another place where :func:`.column_property` is needed is to specify SQL expressions as mapped attributes, such as below where we create an attribute ``fullname`` that is the string concatenation of the ``firstname`` and ``lastname`` columns:: Automating Column Naming Schemes from Reflected Tables Column-based properties can normally be applied to the mapper's ``properties`` dictionary using the :class:`.Column` element directly. Use this function when the given column is not directly present within the mapper's selectable; examples include SQL expressions, functions, and scalar SELECT queries. Columns that aren't present in the mapper's selectable won't be persisted by the mapper and are effectively "read-only" attributes. Disable expiry on flush.   A column_property() which refers to a SQL expression (and not a single table-bound column) is considered to be a "read only" property; populating it has no effect on the state of data, and it can only return database state.   For this reason a column_property()'s value is expired whenever the parent object is involved in a flush, that is, has any kind of "dirty" state within a flush. Setting this parameter to ``False`` will have the effect of leaving any existing value present after the flush proceeds. Note however that the :class:`.Session` with default expiration settings still expires all attributes after a :meth:`.Session.commit` call, however. Disable expiry on flush.   A column_property() which refers to a SQL expression (and not a single table-bound column) is considered to be a "read only" property; populating it has no effect on the state of data, and it can only return database state.   For this reason a column_property()'s value is expired whenever the parent object is involved in a flush, that is, has any kind of "dirty" state within a flush. Setting this parameter to ``False`` will have the effect of leaving any existing value present after the flush proceeds. Note however that the :class:`.Session` with default expiration settings still expires all attributes after a :meth:`.Session.commit` call, however.  .. versionadded:: 0.7.3 For more examples featuring this usage, see :ref:`maptojoin`. If we want to qualify our event to only react for the specific :class:`.MetaData` object above, we can check for it in our event:: In some cases, multiple columns may have the same name, such as when mapping to a join of two or more tables that share some column name. ``include_properties`` and ``exclude_properties`` can also accommodate :class:`.Column` objects to more accurately describe which columns should be included or excluded:: In the next section we'll examine the usage of ``.key`` more closely. In the previous section :ref:`mapper_column_distinct_names`, we showed how a :class:`.Column` explicitly mapped to a class can have a different attribute name than the column.  But what if we aren't listing out :class:`.Column` objects explicitly, and instead are automating the production of :class:`.Table` objects using reflection (e.g. as described in :ref:`metadata_reflection_toplevel`)? In this case we can make use of the :meth:`.DDLEvents.column_reflect` event to intercept the production of :class:`.Column` objects and provide them with the :attr:`.Column.key` of our choice:: Mapping Table Columns Mapping a Subset of Table Columns Naming All Columns with a Prefix Naming Columns Distinctly from Attribute Names Optional data dictionary which will be populated into the :attr:`.MapperProperty.info` attribute of this object. Optional data dictionary which will be populated into the :attr:`.MapperProperty.info` attribute of this object.  .. versionadded:: 0.8 Options can be specified when mapping a :class:`.Column` using the :func:`.column_property` function.  This function explicitly creates the :class:`.ColumnProperty` used by the :func:`.mapper` to keep track of the :class:`.Column`; normally, the :func:`.mapper` creates this automatically.   Using :func:`.column_property`, we can pass additional arguments about how we'd like the :class:`.Column` to be mapped.   Below, we pass an option ``active_history``, which specifies that a change to this column's value should result in the former value being loaded first:: Or in a classical mapping, placed in the ``properties`` dictionary with the desired key:: Provide a column-level property for use with a Mapper. See examples of this usage at :ref:`mapper_sql_expressions`. Sometimes, a :class:`.Table` object was made available using the reflection process described at :ref:`metadata_reflection` to load the table's structure from the database. For such a table that has lots of columns that don't need to be referenced in the application, the ``include_properties`` or ``exclude_properties`` arguments can specify that only a subset of columns should be mapped. For example:: The above will place attribute names such as ``_user_id``, ``_user_name``, ``_password`` etc. on the mapped ``User`` class. The default behavior of :func:`~.orm.mapper` is to assemble all the columns in the mapped :class:`.Table` into mapped object attributes, each of which are named according to the name of the column itself (specifically, the ``key`` attribute of :class:`.Column`).  This behavior can be modified in several ways. The name assigned to the Python attribute which maps to :class:`.Column` can be different from either :attr:`.Column.name` or :attr:`.Column.key` just by assigning it that way, as we illustrate here in a Declarative mapping:: This approach is uncommon in modern usage.   For dealing with reflected tables, a more flexible approach is to use that described in :ref:`mapper_automated_reflection_schemes`. Using column_property for column level options When ``True``, indicates that the "previous" value for a scalar attribute should be loaded when replaced, if not already loaded. Normally, history tracking logic for simple non-primary-key scalar values only needs to be aware of the "new" value in order to perform a flush. This flag is available for applications that make use of :func:`.attributes.get_history` or :meth:`.Session.is_modified` which also need to know the "previous" value of the attribute. When ``True``, indicates that the "previous" value for a scalar attribute should be loaded when replaced, if not already loaded. Normally, history tracking logic for simple non-primary-key scalar values only needs to be aware of the "new" value in order to perform a flush. This flag is available for applications that make use of :func:`.attributes.get_history` or :meth:`.Session.is_modified` which also need to know the "previous" value of the attribute.  .. versionadded:: 0.6.6 When mapping to an existing table, the :class:`.Column` object can be referenced directly:: When this mapping is used, the columns that are not included will not be referenced in any SELECT statements emitted by :class:`.Query`, nor will there be any mapped attribute on the mapped class which represents the column; assigning an attribute of that name will have no effect beyond that of a normal Python attribute assignment. Where above ``User.id`` resolves to a column named ``user_id`` and ``User.name`` resolves to a column named ``user_name``. With the above event, the reflection of :class:`.Column` objects will be intercepted with our event that adds a new ".key" element, such as in a mapping as below:: a class which extends :class:`.ColumnProperty.Comparator` which provides custom SQL clause generation for comparison operations. a group name for this property when marked as deferred. an :class:`.AttributeExtension` instance, or list of extensions, which will be prepended to the list of attribute listeners for the resulting descriptor placed on the class. **Deprecated.** Please see :class:`.AttributeEvents`. insert and update defaults configured on individual :class:`.Column` objects, i.e. those described at :ref:`metadata_defaults` including those configured by the ``default``, ``update``, ``server_default`` and ``server_onupdate`` arguments, will continue to function normally even if those :class:`.Column` objects are not mapped. This is because in the case of ``default`` and ``update``, the :class:`.Column` object is still present on the underlying :class:`.Table`, thus allowing the default functions to take place when the ORM emits an INSERT or UPDATE, and in the case of ``server_default`` and ``server_onupdate``, the relational database itself maintains these functions. list of Column objects to be mapped. optional string that will be applied as the doc on the class-bound descriptor. when True, the column property is "deferred", meaning that it does not load immediately, and is instead loaded when the attribute is first accessed on an instance.  See also :func:`~sqlalchemy.orm.deferred`. パラメータ Project-Id-Version: SQLAlchemy 1.3
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
 ...will map the ``Address`` class to the ``address_table`` table, including all columns present except ``street``, ``city``, ``state``, and ``zip``. ...will map the ``User`` class to the ``user_table`` table, only including the ``user_id`` and ``user_name`` columns - the rest are not referenced. Similarly:: :func:`.column_property` is also used to map a single attribute to multiple columns.  This use case arises when mapping to a :func:`~.expression.join` which has attributes which are equated to each other:: A mapping by default shares the same name for a :class:`.Column` as that of the mapped attribute - specifically it matches the :attr:`.Column.key` attribute on :class:`.Column`, which by default is the same as the :attr:`.Column.name`. A quick approach to prefix column names, typically when mapping to an existing :class:`.Table` object, is to use ``column_prefix``:: Another place where :func:`.column_property` is needed is to specify SQL expressions as mapped attributes, such as below where we create an attribute ``fullname`` that is the string concatenation of the ``firstname`` and ``lastname`` columns:: Automating Column Naming Schemes from Reflected Tables Column-based properties can normally be applied to the mapper's ``properties`` dictionary using the :class:`.Column` element directly. Use this function when the given column is not directly present within the mapper's selectable; examples include SQL expressions, functions, and scalar SELECT queries. Columns that aren't present in the mapper's selectable won't be persisted by the mapper and are effectively "read-only" attributes. Disable expiry on flush.   A column_property() which refers to a SQL expression (and not a single table-bound column) is considered to be a "read only" property; populating it has no effect on the state of data, and it can only return database state.   For this reason a column_property()'s value is expired whenever the parent object is involved in a flush, that is, has any kind of "dirty" state within a flush. Setting this parameter to ``False`` will have the effect of leaving any existing value present after the flush proceeds. Note however that the :class:`.Session` with default expiration settings still expires all attributes after a :meth:`.Session.commit` call, however. Disable expiry on flush.   A column_property() which refers to a SQL expression (and not a single table-bound column) is considered to be a "read only" property; populating it has no effect on the state of data, and it can only return database state.   For this reason a column_property()'s value is expired whenever the parent object is involved in a flush, that is, has any kind of "dirty" state within a flush. Setting this parameter to ``False`` will have the effect of leaving any existing value present after the flush proceeds. Note however that the :class:`.Session` with default expiration settings still expires all attributes after a :meth:`.Session.commit` call, however.  .. versionadded:: 0.7.3 For more examples featuring this usage, see :ref:`maptojoin`. If we want to qualify our event to only react for the specific :class:`.MetaData` object above, we can check for it in our event:: In some cases, multiple columns may have the same name, such as when mapping to a join of two or more tables that share some column name. ``include_properties`` and ``exclude_properties`` can also accommodate :class:`.Column` objects to more accurately describe which columns should be included or excluded:: In the next section we'll examine the usage of ``.key`` more closely. In the previous section :ref:`mapper_column_distinct_names`, we showed how a :class:`.Column` explicitly mapped to a class can have a different attribute name than the column.  But what if we aren't listing out :class:`.Column` objects explicitly, and instead are automating the production of :class:`.Table` objects using reflection (e.g. as described in :ref:`metadata_reflection_toplevel`)? In this case we can make use of the :meth:`.DDLEvents.column_reflect` event to intercept the production of :class:`.Column` objects and provide them with the :attr:`.Column.key` of our choice:: Mapping Table Columns Mapping a Subset of Table Columns Naming All Columns with a Prefix Naming Columns Distinctly from Attribute Names Optional data dictionary which will be populated into the :attr:`.MapperProperty.info` attribute of this object. Optional data dictionary which will be populated into the :attr:`.MapperProperty.info` attribute of this object.  .. versionadded:: 0.8 Options can be specified when mapping a :class:`.Column` using the :func:`.column_property` function.  This function explicitly creates the :class:`.ColumnProperty` used by the :func:`.mapper` to keep track of the :class:`.Column`; normally, the :func:`.mapper` creates this automatically.   Using :func:`.column_property`, we can pass additional arguments about how we'd like the :class:`.Column` to be mapped.   Below, we pass an option ``active_history``, which specifies that a change to this column's value should result in the former value being loaded first:: Or in a classical mapping, placed in the ``properties`` dictionary with the desired key:: Provide a column-level property for use with a Mapper. See examples of this usage at :ref:`mapper_sql_expressions`. Sometimes, a :class:`.Table` object was made available using the reflection process described at :ref:`metadata_reflection` to load the table's structure from the database. For such a table that has lots of columns that don't need to be referenced in the application, the ``include_properties`` or ``exclude_properties`` arguments can specify that only a subset of columns should be mapped. For example:: The above will place attribute names such as ``_user_id``, ``_user_name``, ``_password`` etc. on the mapped ``User`` class. The default behavior of :func:`~.orm.mapper` is to assemble all the columns in the mapped :class:`.Table` into mapped object attributes, each of which are named according to the name of the column itself (specifically, the ``key`` attribute of :class:`.Column`).  This behavior can be modified in several ways. The name assigned to the Python attribute which maps to :class:`.Column` can be different from either :attr:`.Column.name` or :attr:`.Column.key` just by assigning it that way, as we illustrate here in a Declarative mapping:: This approach is uncommon in modern usage.   For dealing with reflected tables, a more flexible approach is to use that described in :ref:`mapper_automated_reflection_schemes`. Using column_property for column level options When ``True``, indicates that the "previous" value for a scalar attribute should be loaded when replaced, if not already loaded. Normally, history tracking logic for simple non-primary-key scalar values only needs to be aware of the "new" value in order to perform a flush. This flag is available for applications that make use of :func:`.attributes.get_history` or :meth:`.Session.is_modified` which also need to know the "previous" value of the attribute. When ``True``, indicates that the "previous" value for a scalar attribute should be loaded when replaced, if not already loaded. Normally, history tracking logic for simple non-primary-key scalar values only needs to be aware of the "new" value in order to perform a flush. This flag is available for applications that make use of :func:`.attributes.get_history` or :meth:`.Session.is_modified` which also need to know the "previous" value of the attribute.  .. versionadded:: 0.6.6 When mapping to an existing table, the :class:`.Column` object can be referenced directly:: When this mapping is used, the columns that are not included will not be referenced in any SELECT statements emitted by :class:`.Query`, nor will there be any mapped attribute on the mapped class which represents the column; assigning an attribute of that name will have no effect beyond that of a normal Python attribute assignment. Where above ``User.id`` resolves to a column named ``user_id`` and ``User.name`` resolves to a column named ``user_name``. With the above event, the reflection of :class:`.Column` objects will be intercepted with our event that adds a new ".key" element, such as in a mapping as below:: a class which extends :class:`.ColumnProperty.Comparator` which provides custom SQL clause generation for comparison operations. a group name for this property when marked as deferred. an :class:`.AttributeExtension` instance, or list of extensions, which will be prepended to the list of attribute listeners for the resulting descriptor placed on the class. **Deprecated.** Please see :class:`.AttributeEvents`. insert and update defaults configured on individual :class:`.Column` objects, i.e. those described at :ref:`metadata_defaults` including those configured by the ``default``, ``update``, ``server_default`` and ``server_onupdate`` arguments, will continue to function normally even if those :class:`.Column` objects are not mapped. This is because in the case of ``default`` and ``update``, the :class:`.Column` object is still present on the underlying :class:`.Table`, thus allowing the default functions to take place when the ORM emits an INSERT or UPDATE, and in the case of ``server_default`` and ``server_onupdate``, the relational database itself maintains these functions. list of Column objects to be mapped. optional string that will be applied as the doc on the class-bound descriptor. when True, the column property is "deferred", meaning that it does not load immediately, and is instead loaded when the attribute is first accessed on an instance.  See also :func:`~sqlalchemy.orm.deferred`. パラメータ 