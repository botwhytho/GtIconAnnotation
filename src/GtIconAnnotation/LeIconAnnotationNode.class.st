Class {
	#name : #LeIconAnnotationNode,
	#superclass : #LeIconParseNode,
	#instVars : [
		'items',
		'bar'
	],
	#category : #GtIconAnnotation
}

{ #category : #generated }
LeIconAnnotationNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitAnnotation: self
]

{ #category : #generated }
LeIconAnnotationNode >> bar [
	^ bar
]

{ #category : #generated }
LeIconAnnotationNode >> bar: aSmaCCToken [
	bar := aSmaCCToken
]

{ #category : #generated }
LeIconAnnotationNode >> compositeNodeVariables [
	^ #(#items)
]

{ #category : #'generated-initialize-release' }
LeIconAnnotationNode >> initialize [
	super initialize.
	items := OrderedCollection new: 2.
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

{ #category : #generated }
LeIconAnnotationNode >> tokenVariables [
	^ #(#bar)
]
