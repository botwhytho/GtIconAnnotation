Class {
	#name : #LeIconIconAnnotationNode,
	#superclass : #LeIconParseNode,
	#instVars : [
		'items',
		'bars'
	],
	#category : #GtIconAnnotation
}

{ #category : #generated }
LeIconIconAnnotationNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitIconAnnotation: self
]

{ #category : #generated }
LeIconIconAnnotationNode >> bars [
	^ bars
]

{ #category : #generated }
LeIconIconAnnotationNode >> bars: anOrderedCollection [
	bars := anOrderedCollection
]

{ #category : #generated }
LeIconIconAnnotationNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #generated }
LeIconIconAnnotationNode >> compositeTokenVariables [
	^ #(#bars)
]

{ #category : #'generated-initialize-release' }
LeIconIconAnnotationNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
	bars := OrderedCollection new: 2.
]

{ #category : #generated }
LeIconIconAnnotationNode >> items [
	^ items
]

{ #category : #generated }
LeIconIconAnnotationNode >> items: anOrderedCollection [
	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]
