Class {
	#name : #LeIconArgumentNode,
	#superclass : #LeIconParseNode,
	#instVars : [
		'value',
		'name',
		'equals'
	],
	#category : #GtIconAnnotation
}

{ #category : #generated }
LeIconArgumentNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitArgument: self
]

{ #category : #generated }
LeIconArgumentNode >> equals [
	^ equals
]

{ #category : #generated }
LeIconArgumentNode >> equals: aSmaCCToken [
	equals := aSmaCCToken
]

{ #category : #generated }
LeIconArgumentNode >> name [
	^ name
]

{ #category : #generated }
LeIconArgumentNode >> name: aSmaCCToken [
	name := aSmaCCToken
]

{ #category : #generated }
LeIconArgumentNode >> tokenVariables [
	^ #(#value #name #equals)
]

{ #category : #generated }
LeIconArgumentNode >> value [
	^ value
]

{ #category : #generated }
LeIconArgumentNode >> value: aSmaCCToken [
	value := aSmaCCToken
]
