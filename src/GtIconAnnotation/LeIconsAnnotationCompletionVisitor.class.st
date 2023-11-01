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

{ #category : #generated }
LeIconsAnnotationCompletionVisitor >> visitAnnotation: anAnnotation [
	| first last completion isCursorInside |
	"anAnnotation items size < 2 ifTrue: [ ^ self visitArgument: anAnnotation ].
	first := anAnnotation items second startPosition.
	last := anAnnotation items second stopPosition + 1."
	anAnnotation bar ifNil: [ ^ self visitArgument: anAnnotation ].
	first := anAnnotation bar stopPosition.
	last := anAnnotation items second stopPosition + 1.
	
	isCursorInside := self composite position >= first and: [ self composite position < last ].
	
	isCursorInside ifFalse: [ ^ self visitArgument: anAnnotation ].
			
	completion := LeIconCompletionResult forHeight: (first + 1 to: last).
	"'completion got trigerred?' logToPackageBeacon."
	^ self composite completionResult: completion
]
