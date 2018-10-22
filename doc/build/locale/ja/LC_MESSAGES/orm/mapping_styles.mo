��          �               |     }     �     �  �   �  �   �  )   v     �     �  E   �  �       �  �  �  �   �  *     �  9    

  �   %  �     Q   �       �    x  �          5     F  �   f  �   `  )        @     S  E   g  �   �    Z  �  q  �   !  *   �  �  �    �  �   �  �   �  Q   R     �  �  �   :class:`.InstanceState` :class:`.Mapper` :ref:`core_inspection_toplevel` A *Classical Mapping* refers to the configuration of a mapped class using the :func:`.mapper` function, without using the Declarative system.  This is SQLAlchemy's original class mapping API, and is still the base mapping system provided by the ORM. Above, a basic single-table mapping with four columns.   Additional attributes, such as relationships to other mapped classes, are also declared inline within the class definition:: As well as :attr:`.Mapper.column_attrs`:: Classical Mappings Declarative Mapping Detailed information is available including :attr:`.Mapper.columns`:: In "classical" form, the table metadata is created separately with the :class:`.Table` construct, then associated with the ``User`` class via the :func:`.mapper` function:: Information about mapped attributes, such as relationships to other classes, are provided via the ``properties`` dictionary.  The example below illustrates a second :class:`.Table` object, mapped to a class called ``Address``, then linked to ``User`` via :func:`.relationship`:: Modern SQLAlchemy features two distinct styles of mapper configuration. The "Classical" style is SQLAlchemy's original mapping API, whereas "Declarative" is the richer and more succinct system that builds on top of "Classical".   Both styles may be used interchangeably, as the end result of each is exactly the same - a user-defined class mapped by the :func:`.mapper` function onto a selectable unit, typically a :class:`.Table`. Other namespaces include :attr:`.Mapper.all_orm_descriptors`, which includes all mapped attributes as well as hybrids, association proxies:: Runtime Introspection of Mappings, Objects Some examples in the documentation still use the classical approach, but note that the classical as well as Declarative approaches are **fully interchangeable**.  Both systems ultimately create the same configuration, consisting of a :class:`.Table`, user-defined class, linked together with a :func:`.mapper`.  When we talk about "the behavior of :func:`.mapper`", this includes when using the Declarative system as well - it's still used, just behind the scenes. The *Declarative Mapping* is the typical way that mappings are constructed in modern SQLAlchemy. Making use of the :ref:`declarative_toplevel` system, the components of the user-defined class as well as the :class:`.Table` metadata to which the class is mapped are defined at once:: The :class:`.Mapper` object is available from any mapped class, regardless of method, using the :ref:`core_inspection_toplevel` system.  Using the :func:`.inspect` function, one can acquire the :class:`.Mapper` from a mapped class:: The declarative mapping system is introduced in the :ref:`ormtutorial_toplevel`.  For additional details on how this system works, see :ref:`declarative_toplevel`. This is a namespace that can be viewed in a list format or via individual names:: Types of Mappings When using classical mappings, classes must be provided directly without the benefit of the "string lookup" system provided by Declarative.  SQL expressions are typically specified in terms of the :class:`.Table` objects, i.e. ``address.c.id`` above for the ``Address`` relationship, and not ``Address.id``, as ``Address`` may not yet be linked to table metadata, nor can we specify a string here. Project-Id-Version: SQLAlchemy 1.3
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
 :class:`.InstanceState` :class:`.Mapper` :ref:`core_inspection_toplevel` A *Classical Mapping* refers to the configuration of a mapped class using the :func:`.mapper` function, without using the Declarative system.  This is SQLAlchemy's original class mapping API, and is still the base mapping system provided by the ORM. Above, a basic single-table mapping with four columns.   Additional attributes, such as relationships to other mapped classes, are also declared inline within the class definition:: As well as :attr:`.Mapper.column_attrs`:: Classical Mappings Declarative Mapping Detailed information is available including :attr:`.Mapper.columns`:: In "classical" form, the table metadata is created separately with the :class:`.Table` construct, then associated with the ``User`` class via the :func:`.mapper` function:: Information about mapped attributes, such as relationships to other classes, are provided via the ``properties`` dictionary.  The example below illustrates a second :class:`.Table` object, mapped to a class called ``Address``, then linked to ``User`` via :func:`.relationship`:: Modern SQLAlchemy features two distinct styles of mapper configuration. The "Classical" style is SQLAlchemy's original mapping API, whereas "Declarative" is the richer and more succinct system that builds on top of "Classical".   Both styles may be used interchangeably, as the end result of each is exactly the same - a user-defined class mapped by the :func:`.mapper` function onto a selectable unit, typically a :class:`.Table`. Other namespaces include :attr:`.Mapper.all_orm_descriptors`, which includes all mapped attributes as well as hybrids, association proxies:: Runtime Introspection of Mappings, Objects Some examples in the documentation still use the classical approach, but note that the classical as well as Declarative approaches are **fully interchangeable**.  Both systems ultimately create the same configuration, consisting of a :class:`.Table`, user-defined class, linked together with a :func:`.mapper`.  When we talk about "the behavior of :func:`.mapper`", this includes when using the Declarative system as well - it's still used, just behind the scenes. The *Declarative Mapping* is the typical way that mappings are constructed in modern SQLAlchemy. Making use of the :ref:`declarative_toplevel` system, the components of the user-defined class as well as the :class:`.Table` metadata to which the class is mapped are defined at once:: The :class:`.Mapper` object is available from any mapped class, regardless of method, using the :ref:`core_inspection_toplevel` system.  Using the :func:`.inspect` function, one can acquire the :class:`.Mapper` from a mapped class:: The declarative mapping system is introduced in the :ref:`ormtutorial_toplevel`.  For additional details on how this system works, see :ref:`declarative_toplevel`. This is a namespace that can be viewed in a list format or via individual names:: Types of Mappings When using classical mappings, classes must be provided directly without the benefit of the "string lookup" system provided by Declarative.  SQL expressions are typically specified in terms of the :class:`.Table` objects, i.e. ``address.c.id`` above for the ``Address`` relationship, and not ``Address.id``, as ``Address`` may not yet be linked to table metadata, nor can we specify a string here. 