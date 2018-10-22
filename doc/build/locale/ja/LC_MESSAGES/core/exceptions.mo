��    9      �              �    �  �   �  4   �  �   �  6   �  �   �  ]   �  6   �  _   3     �     �      �     �  �   �  W  �	       *   %  D   P  H   �  G   �  C   &  @   j  l   �  ;     2   T  D   �  L   �  @     d   Z  Q   �  H     8   Z  A   �  1   �  7     5   ?     u  �   �  ;   -  D   i  I   �  �   �  0   �  C   �  9     I  =  �   �          /     M     l     �  !   �      �      �  �    x  �    \  �   |  4   R  �   �  6   F  �   }  ]   M  6   �  _   �     B     R      Y     z  �   �  W  i     �   *   �   D   �   H   D!  G   �!  C   �!  @   "  l   Z"  ;   �"  2   #  D   6#  L   {#  @   �#  d   	$  Q   n$  H   �$  8   	%  A   B%  1   �%  7   �%  5   �%     $&  �   @&  ;   �&  D   '  I   ]'  �   �'  0   =(  C   n(  9   �(  I  �(  �   6*     �*     �*     �*     +     :+  !   X+      z+      �+  �  �+   :class:`DBAPIError` features :attr:`~.StatementError.statement` and :attr:`~.StatementError.params` attributes which supply context regarding the specifics of the statement which had an issue, for the typical case when the error was raised within the context of emitting a SQL statement. :class:`StatementError` wraps the exception raised during execution, and features :attr:`.statement` and :attr:`.params` attributes which supply context regarding the specifics of the statement which had an issue. A disconnect is detected on a raw DB-API connection. A mixin class which, when applied to a user-defined Exception class, will not be wrapped inside of :exc:`.StatementError` if the error is emitted within the process of executing a statement. A nonexistent column is requested from a ``RowProxy``. A subclass of :class:`.DisconnectionError` that indicates that the disconnect situation encountered on the connection probably means the entire pool should be invalidated, as the database has been restarted. A subject passed to :func:`sqlalchemy.inspection.inspect` produced no context for inspection. An error occurred during execution of a SQL statement. An operation was requested from a connection, cursor, or other object that's in a closed state. Core Exceptions E.g.:: Exceptions used with SQLAlchemy. Generic error class. In a :attr:`.MetaData.sorted_tables` operation, two :class:`.ForeignKey` or :class:`.ForeignKeyConstraint` objects mutually refer to each other.  Apply the ``use_alter=True`` flag to one or both, see :ref:`use_alter`. In a Session flush operation, if two objects are mutually dependent on each other, they can not be inserted or deleted via INSERT or DELETE statements alone; an UPDATE will be needed to post-associate or pre-deassociate one of the foreign key constrained values. The ``post_update`` flag described at :ref:`post_update` can resolve this cycle. Issued at runtime. Issued once per usage of a deprecated API. Raised by ``ForeignKey`` to indicate a reference cannot be resolved. Raised by ``ForeignKey`` when the referred ``Column`` cannot be located. Raised by ``ForeignKey`` when the referred ``Table`` cannot be located. Raised by topological sorts when a circular dependency is detected. Raised when a connection pool times out on getting a connection. Raised when a dynamically-loaded module (usually a database dialect) of a particular name cannot be located. Raised when a schema name is beyond the max character limit Raised when an error occurs during SQL compilation Raised when an invalid or conflicting function argument is supplied. Raised when an object is passed to .execute() that can't be executed as SQL. Raised when an operation is not supported by the given compiler. Raised when more than one foreign key matching can be located between two selectables during a join. Raised when no foreign keys can be located between two selectables during a join. Raised when the connection pool should invalidate all stale connections. Raised when the execution of a database operation fails. SQL was attempted without a database connection to execute it on. SQLAlchemy was asked to do something it can't do. Table does not exist or is not visible to a connection. Table exists but can't be reflectted for some reason. The DBAPI exception object. The base exception class is :exc:`.SQLAlchemyError`.  Exceptions which are raised as a result of DBAPI exceptions are all subclasses of :exc:`.DBAPIError`. The parameter list being used when this exception occurred. The string SQL statement being invoked when this exception occurred. The wrapped exception object is available in the :attr:`.orig` attribute. The wrapped exception object is available in the :attr:`~.StatementError.orig` attribute. Its type and properties are DB-API implementation specific. There are two scenarios where this error occurs: This error generally corresponds to construction time state errors. This error generally corresponds to runtime state errors. This error is raised and consumed internally by a connection pool.  It can be raised by the :meth:`.PoolEvents.checkout` event so that the host pool forces a retry; the exception will be caught three times in a row before the pool gives up and raises :class:`~sqlalchemy.exc.InvalidRequestError` regarding the connection attempt. This exception will be handled otherwise the same way as :class:`.DisconnectionError`, allowing three attempts to reconnect before giving up. Wraps a DB-API DataError. Wraps a DB-API DatabaseError. Wraps a DB-API IntegrityError. Wraps a DB-API InterfaceError. Wraps a DB-API InternalError. Wraps a DB-API NotSupportedError. Wraps a DB-API OperationalError. Wraps a DB-API ProgrammingError. Wraps exceptions raised by the DB-API underlying the database operation.  Driver-specific implementations of the standard DB-API exception types are wrapped by matching sub-types of SQLAlchemy's :class:`DBAPIError` when possible.  DB-API's ``Error`` type maps to :class:`DBAPIError` in SQLAlchemy, otherwise the names are identical.  Note that there is no guarantee that different DB-API implementations will raise the same exception type for any given error condition. Project-Id-Version: SQLAlchemy 1.3
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
 :class:`DBAPIError` features :attr:`~.StatementError.statement` and :attr:`~.StatementError.params` attributes which supply context regarding the specifics of the statement which had an issue, for the typical case when the error was raised within the context of emitting a SQL statement. :class:`StatementError` wraps the exception raised during execution, and features :attr:`.statement` and :attr:`.params` attributes which supply context regarding the specifics of the statement which had an issue. A disconnect is detected on a raw DB-API connection. A mixin class which, when applied to a user-defined Exception class, will not be wrapped inside of :exc:`.StatementError` if the error is emitted within the process of executing a statement. A nonexistent column is requested from a ``RowProxy``. A subclass of :class:`.DisconnectionError` that indicates that the disconnect situation encountered on the connection probably means the entire pool should be invalidated, as the database has been restarted. A subject passed to :func:`sqlalchemy.inspection.inspect` produced no context for inspection. An error occurred during execution of a SQL statement. An operation was requested from a connection, cursor, or other object that's in a closed state. Core Exceptions E.g.:: Exceptions used with SQLAlchemy. Generic error class. In a :attr:`.MetaData.sorted_tables` operation, two :class:`.ForeignKey` or :class:`.ForeignKeyConstraint` objects mutually refer to each other.  Apply the ``use_alter=True`` flag to one or both, see :ref:`use_alter`. In a Session flush operation, if two objects are mutually dependent on each other, they can not be inserted or deleted via INSERT or DELETE statements alone; an UPDATE will be needed to post-associate or pre-deassociate one of the foreign key constrained values. The ``post_update`` flag described at :ref:`post_update` can resolve this cycle. Issued at runtime. Issued once per usage of a deprecated API. Raised by ``ForeignKey`` to indicate a reference cannot be resolved. Raised by ``ForeignKey`` when the referred ``Column`` cannot be located. Raised by ``ForeignKey`` when the referred ``Table`` cannot be located. Raised by topological sorts when a circular dependency is detected. Raised when a connection pool times out on getting a connection. Raised when a dynamically-loaded module (usually a database dialect) of a particular name cannot be located. Raised when a schema name is beyond the max character limit Raised when an error occurs during SQL compilation Raised when an invalid or conflicting function argument is supplied. Raised when an object is passed to .execute() that can't be executed as SQL. Raised when an operation is not supported by the given compiler. Raised when more than one foreign key matching can be located between two selectables during a join. Raised when no foreign keys can be located between two selectables during a join. Raised when the connection pool should invalidate all stale connections. Raised when the execution of a database operation fails. SQL was attempted without a database connection to execute it on. SQLAlchemy was asked to do something it can't do. Table does not exist or is not visible to a connection. Table exists but can't be reflectted for some reason. The DBAPI exception object. The base exception class is :exc:`.SQLAlchemyError`.  Exceptions which are raised as a result of DBAPI exceptions are all subclasses of :exc:`.DBAPIError`. The parameter list being used when this exception occurred. The string SQL statement being invoked when this exception occurred. The wrapped exception object is available in the :attr:`.orig` attribute. The wrapped exception object is available in the :attr:`~.StatementError.orig` attribute. Its type and properties are DB-API implementation specific. There are two scenarios where this error occurs: This error generally corresponds to construction time state errors. This error generally corresponds to runtime state errors. This error is raised and consumed internally by a connection pool.  It can be raised by the :meth:`.PoolEvents.checkout` event so that the host pool forces a retry; the exception will be caught three times in a row before the pool gives up and raises :class:`~sqlalchemy.exc.InvalidRequestError` regarding the connection attempt. This exception will be handled otherwise the same way as :class:`.DisconnectionError`, allowing three attempts to reconnect before giving up. Wraps a DB-API DataError. Wraps a DB-API DatabaseError. Wraps a DB-API IntegrityError. Wraps a DB-API InterfaceError. Wraps a DB-API InternalError. Wraps a DB-API NotSupportedError. Wraps a DB-API OperationalError. Wraps a DB-API ProgrammingError. Wraps exceptions raised by the DB-API underlying the database operation.  Driver-specific implementations of the standard DB-API exception types are wrapped by matching sub-types of SQLAlchemy's :class:`DBAPIError` when possible.  DB-API's ``Error`` type maps to :class:`DBAPIError` in SQLAlchemy, otherwise the names are identical.  Note that there is no guarantee that different DB-API implementations will raise the same exception type for any given error condition. 