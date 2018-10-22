��          �               �  �  �     P  G   �       �   &     �  P   �  )     4   D  C   y  H   �  �     v   �  !   ;  '   ]  k   �  [   �  (  M  �  v	  f   Q  �   �  s   v    �  -   �     (  x  I  �  �     U  G   �       �   +     �  P   �  )     4   I  C   ~  H   �  �     v   �  !   @  '   b  k   �  [   �  (  R  �  {  f   V  �   �  s   {    �  -   �     -   :class:`.InstrumentationManager` can be subclassed in order to change how class instrumentation proceeds. This class exists for the purposes of integration with other object management frameworks which would like to entirely modify the instrumentation methodology of the ORM, and is not intended for regular usage.  For interception of class instrumentation events, see :class:`.InstrumentationEvents`. :class:`.InstrumentationManager` was moved from :mod:`sqlalchemy.orm.instrumentation` to :mod:`sqlalchemy.ext.instrumentation`. A dictionary of callables, implementing all or some of the above (TODO) API Reference Allows a class to specify a slightly or wildly different technique for tracking changes made to mapped attributes and collections. Alternate Class Instrumentation An extensible sequence of callables which return instrumentation implementations An instance of a ClassManager or subclass An instance of an InstrumentationManager or subclass An object implementing all or some of InstrumentationManager (TODO) Attribute, elects custom instrumentation when present on a mapped class. By default, the only finder is find_native_user_instrumentation_hook, which searches for INSTRUMENTATION_MANAGER.  If all finders return None, standard ClassManager instrumentation is used. Extends :class:`.InstrumentationFactory` with additional bookkeeping, to accommodate multiple types of class managers. Extensible class instrumentation. Factory for new ClassManager instances. For examples of how the instrumentation extension is used, see the example :ref:`examples_instrumentation`. Only one instrumentation implementation is allowed in a given object inheritance hierarchy. The :mod:`sqlalchemy.ext.instrumentation` package provides for alternate systems of class instrumentation within the ORM.  Class instrumentation refers to how the ORM places attributes on the class which maintain data and track changes to that data, as well as event hooks installed on the class. The :mod:`sqlalchemy.orm.instrumentation` was split out so that all functionality having to do with non-standard instrumentation was moved out to :mod:`sqlalchemy.ext.instrumentation`. When imported, the module installs itself within :mod:`sqlalchemy.orm.instrumentation` so that it takes effect, including recognition of ``__sa_instrumentation_manager__`` on mapped classes, as well :data:`.instrumentation_finders` being used to determine class instrumentation resolution. The API for this class should be considered as semi-stable, and may change slightly with new releases. The extension package is provided for the benefit of integration with other object management packages, which already perform their own instrumentation.  It is not intended for general use. The value of this attribute must be a callable and will be passed a class object.  The callable must return one of: This attribute is consulted by SQLAlchemy instrumentation resolution, once the :mod:`sqlalchemy.ext.instrumentation` module has been imported.  If custom finders are installed in the global instrumentation_finders list, they may or may not choose to honor this attribute. User-defined class instrumentation extension. When a class is registered, each callable will be passed a class object. If None is returned, the next finder in the sequence is consulted.  Otherwise the return must be an instrumentation factory that follows the same guidelines as sqlalchemy.ext.instrumentation.INSTRUMENTATION_MANAGER. Project-Id-Version: SQLAlchemy 1.3
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
 :class:`.InstrumentationManager` can be subclassed in order to change how class instrumentation proceeds. This class exists for the purposes of integration with other object management frameworks which would like to entirely modify the instrumentation methodology of the ORM, and is not intended for regular usage.  For interception of class instrumentation events, see :class:`.InstrumentationEvents`. :class:`.InstrumentationManager` was moved from :mod:`sqlalchemy.orm.instrumentation` to :mod:`sqlalchemy.ext.instrumentation`. A dictionary of callables, implementing all or some of the above (TODO) API Reference Allows a class to specify a slightly or wildly different technique for tracking changes made to mapped attributes and collections. Alternate Class Instrumentation An extensible sequence of callables which return instrumentation implementations An instance of a ClassManager or subclass An instance of an InstrumentationManager or subclass An object implementing all or some of InstrumentationManager (TODO) Attribute, elects custom instrumentation when present on a mapped class. By default, the only finder is find_native_user_instrumentation_hook, which searches for INSTRUMENTATION_MANAGER.  If all finders return None, standard ClassManager instrumentation is used. Extends :class:`.InstrumentationFactory` with additional bookkeeping, to accommodate multiple types of class managers. Extensible class instrumentation. Factory for new ClassManager instances. For examples of how the instrumentation extension is used, see the example :ref:`examples_instrumentation`. Only one instrumentation implementation is allowed in a given object inheritance hierarchy. The :mod:`sqlalchemy.ext.instrumentation` package provides for alternate systems of class instrumentation within the ORM.  Class instrumentation refers to how the ORM places attributes on the class which maintain data and track changes to that data, as well as event hooks installed on the class. The :mod:`sqlalchemy.orm.instrumentation` was split out so that all functionality having to do with non-standard instrumentation was moved out to :mod:`sqlalchemy.ext.instrumentation`. When imported, the module installs itself within :mod:`sqlalchemy.orm.instrumentation` so that it takes effect, including recognition of ``__sa_instrumentation_manager__`` on mapped classes, as well :data:`.instrumentation_finders` being used to determine class instrumentation resolution. The API for this class should be considered as semi-stable, and may change slightly with new releases. The extension package is provided for the benefit of integration with other object management packages, which already perform their own instrumentation.  It is not intended for general use. The value of this attribute must be a callable and will be passed a class object.  The callable must return one of: This attribute is consulted by SQLAlchemy instrumentation resolution, once the :mod:`sqlalchemy.ext.instrumentation` module has been imported.  If custom finders are installed in the global instrumentation_finders list, they may or may not choose to honor this attribute. User-defined class instrumentation extension. When a class is registered, each callable will be passed a class object. If None is returned, the next finder in the sequence is consulted.  Otherwise the return must be an instrumentation factory that follows the same guidelines as sqlalchemy.ext.instrumentation.INSTRUMENTATION_MANAGER. 