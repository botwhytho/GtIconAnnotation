Class {
	#name : #LeIconAnnotationNode,
	#superclass : #LeIconParseNode,
	#instVars : [
		'items',
		'bars'
	],
	#category : #GtIconAnnotation
}

{ #category : #generated }
LeIconAnnotationNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitAnnotation: self
]

{ #category : #generated }
LeIconAnnotationNode >> bars [
	^ bars
]

{ #category : #generated }
LeIconAnnotationNode >> bars: anOrderedCollection [
	bars := anOrderedCollection
]

{ #category : #generated }
LeIconAnnotationNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #generated }
LeIconAnnotationNode >> compositeTokenVariables [
	^ #(#bars)
]

{ #category : #'generated-initialize-release' }
LeIconAnnotationNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
	bars := OrderedCollection new: 2.
]

{ #category : #generated }
LeIconAnnotationNode >> items [
	^ items
]

{ #category : #generated }
LeIconAnnotationNode >> items: anOrderedCollection [
	self setParents: self items to: nil.
	items := anOrderedCollection.
	self setParents: self items to: self
]
