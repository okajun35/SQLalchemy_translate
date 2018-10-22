��          �               L  A   M  �   �  l   g     �  A   �  2   3     f  T  }  <   �  �     �  �  6  �  �   �  l  �	  �      �  �     R     o  x    A   �  �   :  l          A   �  2   �       T  (  <   }  �   �  �  p  6  k  �   �  l  ^  �   �  �  T     �        :class:`.AliasedClass` - returns an :class:`.AliasedInsp` object. :class:`.ClauseElement` - all SQL expression components, including :class:`.Table`, :class:`.Column`, serve as their own inspection objects, meaning any of these objects passed to :func:`.inspect` return themselves. :class:`.Connectable` (i.e. :class:`.Engine`, :class:`.Connection`) - returns an :class:`.Inspector` object. Available Inspection Targets Below is a listing of many of the most common inspection targets. Produce an inspection object for the given target. Runtime Inspection API The :func:`.inspect` function is the entry point to SQLAlchemy's public API for viewing the configuration and construction of in-memory objects.   Depending on the type of object passed to :func:`.inspect`, the return value will either be a related object which provides a known interface, or in many cases it will return the object itself. The :func:`.inspect` system is introduced as of version 0.8. The inspection module provides the :func:`.inspect` function, which delivers runtime information about a wide variety of SQLAlchemy objects, both within the Core as well as the ORM. The rationale for :func:`.inspect` is twofold.  One is that it replaces the need to be aware of a large variety of "information getting" functions in SQLAlchemy, such as :meth:`.Inspector.from_engine`, :func:`.orm.attributes.instance_state`, :func:`.orm.class_mapper`, and others.    The other is that the return value of :func:`.inspect` is guaranteed to obey a documented API, thus allowing third party tools which build on top of SQLAlchemy configurations to be constructed in a forwards-compatible way. The returned value in some cases may be the same object as the one given, such as if a :class:`.Mapper` object is passed.   In other cases, it will be an instance of the registered inspection type for the given object, such as if an :class:`.engine.Engine` is passed, an :class:`.Inspector` object is returned. When ``True``, if the given subject does not correspond to a known SQLAlchemy inspected type, :class:`sqlalchemy.exc.NoInspectionAvailable` is raised.  If ``False``, ``None`` is returned. ``object`` - an object given will be checked by the ORM for a mapping - if so, an :class:`.InstanceState` is returned representing the mapped state of the object.  The :class:`.InstanceState` also provides access to per attribute state via the :class:`.AttributeState` interface as well as the per-flush "history" of any attribute via the :class:`.History` object. ``type`` (i.e. a class) - a class given will be checked by the ORM for a mapping - if so, a :class:`.Mapper` for that class is returned. mapped attribute - passing a mapped attribute to :func:`.inspect`, such as ``inspect(MyClass.some_attribute)``, returns a :class:`.QueryableAttribute` object, which is the :term:`descriptor` associated with a mapped class. This descriptor refers to a :class:`.MapperProperty`, which is usually an instance of :class:`.ColumnProperty` or :class:`.RelationshipProperty`, via its :attr:`.QueryableAttribute.property` attribute. the subject to be inspected. パラメータ Project-Id-Version: SQLAlchemy 1.3
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
 :class:`.AliasedClass` - returns an :class:`.AliasedInsp` object. :class:`.ClauseElement` - all SQL expression components, including :class:`.Table`, :class:`.Column`, serve as their own inspection objects, meaning any of these objects passed to :func:`.inspect` return themselves. :class:`.Connectable` (i.e. :class:`.Engine`, :class:`.Connection`) - returns an :class:`.Inspector` object. Available Inspection Targets Below is a listing of many of the most common inspection targets. Produce an inspection object for the given target. Runtime Inspection API The :func:`.inspect` function is the entry point to SQLAlchemy's public API for viewing the configuration and construction of in-memory objects.   Depending on the type of object passed to :func:`.inspect`, the return value will either be a related object which provides a known interface, or in many cases it will return the object itself. The :func:`.inspect` system is introduced as of version 0.8. The inspection module provides the :func:`.inspect` function, which delivers runtime information about a wide variety of SQLAlchemy objects, both within the Core as well as the ORM. The rationale for :func:`.inspect` is twofold.  One is that it replaces the need to be aware of a large variety of "information getting" functions in SQLAlchemy, such as :meth:`.Inspector.from_engine`, :func:`.orm.attributes.instance_state`, :func:`.orm.class_mapper`, and others.    The other is that the return value of :func:`.inspect` is guaranteed to obey a documented API, thus allowing third party tools which build on top of SQLAlchemy configurations to be constructed in a forwards-compatible way. The returned value in some cases may be the same object as the one given, such as if a :class:`.Mapper` object is passed.   In other cases, it will be an instance of the registered inspection type for the given object, such as if an :class:`.engine.Engine` is passed, an :class:`.Inspector` object is returned. When ``True``, if the given subject does not correspond to a known SQLAlchemy inspected type, :class:`sqlalchemy.exc.NoInspectionAvailable` is raised.  If ``False``, ``None`` is returned. ``object`` - an object given will be checked by the ORM for a mapping - if so, an :class:`.InstanceState` is returned representing the mapped state of the object.  The :class:`.InstanceState` also provides access to per attribute state via the :class:`.AttributeState` interface as well as the per-flush "history" of any attribute via the :class:`.History` object. ``type`` (i.e. a class) - a class given will be checked by the ORM for a mapping - if so, a :class:`.Mapper` for that class is returned. mapped attribute - passing a mapped attribute to :func:`.inspect`, such as ``inspect(MyClass.some_attribute)``, returns a :class:`.QueryableAttribute` object, which is the :term:`descriptor` associated with a mapped class. This descriptor refers to a :class:`.MapperProperty`, which is usually an instance of :class:`.ColumnProperty` or :class:`.RelationshipProperty`, via its :attr:`.QueryableAttribute.property` attribute. the subject to be inspected. パラメータ 