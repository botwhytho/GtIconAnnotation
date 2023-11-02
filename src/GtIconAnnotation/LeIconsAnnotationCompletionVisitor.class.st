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
	| currentSelector heightBegin heightEnd completion isCursorInside isCursorInsideSelector isCursorInsideHeight selectorBegin selectorEnd |
	currentSelector := anAnnotation items first value source.
	selectorBegin := anAnnotation items first startPosition.
	selectorEnd := anAnnotation items first stopPosition + 1.
	heightBegin := anAnnotation items second startPosition.
	heightEnd := anAnnotation items second stopPosition + 1.
	{#parentBeing -> anAnnotation parent startPosition.
		#selectorBegin -> selectorBegin.
		#selectorEnd -> selectorEnd.
		#barBegin -> anAnnotation bar startPosition.
		#barEnd -> anAnnotation bar stopPosition.
		#selectorEnd -> selectorEnd.
		#heightEnd -> heightEnd.
		#parentEnd -> anAnnotation parent stopPosition.
		#cursorPosition -> self composite position} logToPackageBeacon.

	isCursorInside := self composite position >= selectorBegin
			and: [ self composite position
					< (anAnnotation bar ifNil: [ selectorEnd ] ifNotNil: [ heightEnd ]) ].

	isCursorInside ifFalse: [ ^ self visitArgument: anAnnotation ].

	isCursorInsideSelector := self composite position >= selectorBegin
			and: [ self composite position < selectorEnd ].

	isCursorInsideSelector
		ifTrue: [ completion := LeIconSelectorCompletionResult
					forSelector: (selectorBegin  to: selectorEnd) ]
		ifFalse: [ completion := LeIconHeightCompletionResult
					forHeight: {(heightBegin to: heightEnd).currentSelector} ].
	^ self composite completionResult: completion
]
