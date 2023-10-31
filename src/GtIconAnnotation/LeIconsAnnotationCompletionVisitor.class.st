Class {
	#name : #LeIconsAnnotationCompletionVisitor,
	#superclass : #Object,
	#traits : 'TSmaCCComponentVisitor + TLeIconParseNodeVisitor',
	#classTraits : 'TSmaCCComponentVisitor classTrait + TLeIconParseNodeVisitor classTrait',
	#category : #GtIconAnnotation
}

{ #category : #initialization }
LeIconsAnnotationCompletionVisitor class >> initialize [
	super initialize.
	LeContentCompletionVisitor additionalCompletionVisitors add: self
]

{ #category : #initialization }
LeIconsAnnotationCompletionVisitor class >> obsolete [
	LeContentCompletionVisitor additionalCompletionVisitors
		remove: self
		ifAbsent: [  ].
	^ super obsolete
]
